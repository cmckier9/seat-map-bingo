//
//  SeatViewModel.swift
//  Seat Map Bingo
//
//  Created by Evan Westermann on 10/22/24.
//

import SwiftUI

@MainActor 
class SeatViewModel: ObservableObject {
    @Published var seats: [[SeatViewObj]] = []
    @Published var seatsDict: [Coordinates:Seat] = [:]
    @Published var seatMapObject: SeatMaps? {
        didSet {
            self.seatsDict = generateSeatMapDict(from: seatMapObject!)
            self.seats = generateSeatMap(rows: 30, columns: 6)
        }
    }
    
    private let seatSaveKey = "savedSeats"
    
//    var mapLength: Int {
//        seatMapObject.deck.deckConfiguration.length
//    }
//    
//    var mapWidth: Int {
//        seatMapObject.deck.deckConfiguration.width
//    }
    
    init(seatMapObj: SeatMaps?) {
        guard let seatMapObj else { return }
        self.seats = generateSeatMap(rows: 30, columns: 6)
        self.seatsDict = generateSeatMapDict(from: seatMapObject!)
        fetchSeatMap()
    }
    
    func isHighlighted(seat: SeatViewObj, highlightedSeats: [String]) -> Bool {
        return highlightedSeats.contains(seat.seat.id)
    }
    
    func fetchSeatMap() {
        API.shared.fetchData(from: "https://8npg08k6cl.execute-api.us-east-2.amazonaws.com/prod/amadeus/get-seat-map") { result in
            switch result {
            case .success(let data):
                do {
                    let seatMapResponse = try! JSONDecoder().decode(SeatMapResonse.self, from: data)
                    self.seatMapObject = seatMapResponse.data.seatmaps.first!
                }
                
            case .failure(let error):
                print(error)
            }
        }

    }
    
    func generateSeatMapDict(from seatMap: SeatMaps) -> [Coordinates:Seat] {
        var tempSeatsDict: [Coordinates:Seat] = [:]
        for seat in seatMap.decks.first!.seats {
            tempSeatsDict[seat.coordinates] = seat
        }
        return tempSeatsDict
    }
    
    func generateSeatMap(rows: Int, columns: Int) -> [[SeatViewObj]] {
        var seats: [[SeatViewObj]] = []
        for row in 1...rows {
            var rowSeats: [SeatViewObj] = []
            for column in 1...columns {
                rowSeats.append(SeatViewObj(seat: seatsDict[Coordinates(x: column, y: row)] ?? Seat(seatNumber: "LAV", coordinates: Coordinates(x: column, y: row)),
                                            isSelected: false))
            }
            seats.append(rowSeats)
        }
        return seats
    }
    
    func toggleSeatSelection(row: Int, column: Int) {
        seats[row][column].isSelected.toggle()
        saveSeats()
    }
    
    func saveSeats() {
        if let encoded = try? JSONEncoder().encode(seats) {
            UserDefaults.standard.set(encoded, forKey: seatSaveKey)
        }
    }
    
    func loadSeats() -> [[SeatViewObj]]? {
        if let data = UserDefaults.standard.data(forKey: seatSaveKey),
           let decoded = try? JSONDecoder().decode([[SeatViewObj]].self, from: data) {
            return decoded
        }
        return nil
    }
    
    func bookFlight () {
        let flattenedPeopleArray = self.seats.flatMap { $0 }
        let selectedSeat = flattenedPeopleArray.first { $0.isSelected == true && $0.seat.seatNumber != "LAV"}
        print(selectedSeat)
        let dataToSend = UserSeatHistoryPost(seat: selectedSeat!.seat.seatNumber)
        API.shared.postData(for: "https://8npg08k6cl.execute-api.us-east-2.amazonaws.com/prod/seat-history", dataToSend) { result in
            switch result {
            case .success(let data):
                print("worked")
            case .failure(let error):
                print("broke")
            }
        }
    }
}
