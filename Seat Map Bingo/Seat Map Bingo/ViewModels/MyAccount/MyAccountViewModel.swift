//
//  MyAccountViewModel.swift
//  Seat Map Bingo
//
//  Created by Evan Bakkal on 10/22/24.
//

import Foundation

@MainActor
class MyAccountViewModel: ObservableObject {
    @Published var user: User
    //@Published var achievementList: [Achievement] = [] // Your achievement data
    @Published var selectedAchievement: Achievement?
    @Published var highlightedSeats: [String] = []
    @Published var showSeatMap: Bool = false
    
    @Published var achievementList: [Achievement] = [
        Achievement(
            image: "trophy",
            title: "Create a Heart",
            description: "💙❤️💛",
            progress: 0.5
        ),
        Achievement(
            image: "trophy",
            title: "4 Corners",
            description: "Sit in all 4 corner seats",
            progress: 1.0
        ),
        Achievement(
            image: "trophy",
            title: "Fill a Row",
            description: "Set in all seats of one row",
            progress: 0.7
        )
    ]
    
    @Published var challenges: [BingoPattern] = []
    
    func fetchChallenges() {
        API.shared.fetchData(from: "https://8npg08k6cl.execute-api.us-east-2.amazonaws.com/prod/bingo-possibilities") { result in
            switch result {
            case .success(let data):
                print("Data received: \(data)")
                do {
                    let bingoPatternList = try JSONDecoder().decode(BingoPatternList.self, from: data)
                    
                    self.challenges = bingoPatternList.patterns
                    
                    for pattern in bingoPatternList.patterns {
                        print("Pattern ID: \(pattern.id), Title: \(pattern.title), Coordinates: \(pattern.seat)")
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            case .failure(let error):
                print("Error occurred: \(error)")
            }
        }
    }
    
    init(user: User) {
        self.user = user
    }
    
    func checkForWinningBingo(userHistory: [UserSeatHistory]) -> [String] {
        var bingoWinners: [String] = []
        
        for object in userHistory {
            if object.SeatNumber == "2C" {
                bingoWinners.append(object.FlightID)
            }
        }
        
        return bingoWinners
    }
}
