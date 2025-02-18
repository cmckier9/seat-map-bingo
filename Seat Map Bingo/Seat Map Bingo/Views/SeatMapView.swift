//
//  SeatMapView.swift
//  Seat Map Bingo
//
//  Created by Evan Westermann on 10/22/24.
//

import SwiftUI

struct SeatMapView: View {
    @ObservedObject var viewModel: SeatViewModel // Pass the ViewModel externally
    let highlightedSeats: [String] // Seats to be highlighted (e.g., "4 Corners" seats)
    var isAchievement = false
    
    let columns: [GridItem] = Array(repeating: .init(.fixed(40)), count: 3) + [.init(.fixed(20))] + Array(repeating: .init(.fixed(40)), count: 3)

    var body: some View {
        VStack {
            
            bookButton
            
            instaShareButton
            
            Text("Select Your Seat")
                .font(.headline)
                .padding()
            
            headerRow()

            ScrollView {
                seatGrid()
            }
        }
        .onAppear {
            API.shared.fetchData(from: "https://8npg08k6cl.execute-api.us-east-2.amazonaws.com/prod/amadeus/get-seat-map") { result in
                switch result {
                case .success(let data):
                    do {
                        let seatMapResponse = try! JSONDecoder().decode(SeatMapResonse.self, from: data)
                        viewModel.seatMapObject = seatMapResponse.data.seatmaps.first!
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        .padding()
    }
    
    @ViewBuilder var bookButton: some View {
        Button(action: viewModel.bookFlight) {
            Text("Book")
                .font(.headline)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
    
    @ViewBuilder func headerRow() -> some View {
        HStack {
            Spacer().frame(width: 0) // For row numbers
            ForEach(["A", "B", "C", "", "D", "E", "F"], id: \.self) { label in
                Text(label)
                    .frame(width: label.isEmpty ? 20 : 40, height: 20) // Empty string for aisle
                    .foregroundColor(.black)
                    .font(.subheadline)
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder func seatGrid() -> some View {
        VStack {
            ForEach(viewModel.seats.indices, id: \.self) { row in
                seatRow(for: row)
            }
        }
        .padding()
    }

    @ViewBuilder func seatRow(for row: Int) -> some View {
        HStack {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<3, id: \.self) { column in
                    seatView(row: row, column: column)
                }
                
                Text("\(row + 1)")
                    .frame(width: 30, height: 40)
                    .font(.subheadline)
                    .foregroundColor(.black)

                ForEach(3..<6, id: \.self) { column in
                    seatView(row: row, column: column)
                }
            }
        }
    }

    @ViewBuilder func seatView(row: Int, column: Int) -> some View {
        SeatView(seat: viewModel.seats[row][column], isAchievement: isAchievement)
            .background(seatBackgroundColor(row: row, column: column)) // Use the helper function here
            .onTapGesture {
                viewModel.toggleSeatSelection(row: row, column: column)
            }
    }
    
    func seatBackgroundColor(row: Int, column: Int) -> Color {
        let seat = viewModel.seats[row][column]
        let isHighlighted = viewModel.isHighlighted(seat: seat, highlightedSeats: highlightedSeats)
        return isHighlighted ? Color.green : Color.gray.opacity(0.3)
    }

    
    @ViewBuilder var instaShareButton: some View {
        Button(action: shareToInstagram) {
            Text("Share Image")
                .font(.headline)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding()
    }
    
    func shareToInstagram() {
        let scrollViewContentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        let imageToShare = SeatMapView(viewModel: viewModel, highlightedSeats: highlightedSeats).asImage(scrollViewSize: scrollViewContentSize)
        
        // Save the image to the temporary directory
        let imageData = imageToShare.pngData()
                
        // Define pasteboard items
        let pasteboardItems: [String: Any] = [
            "com.instagram.sharedSticker.backgroundImage": imageData // Set the image
        ]
        
        // Add the data to the pasteboard
        let pasteboard = UIPasteboard.general
        pasteboard.items = [pasteboardItems]
        
        let appID = "831654569045710"
        
        // Open Instagram story editor via URL scheme
        let instagramUrl = URL(string: "instagram-stories://share?source_application=\(appID)")!
        if UIApplication.shared.canOpenURL(instagramUrl) {
            UIApplication.shared.open(instagramUrl, options: [:], completionHandler: nil)
        } else {
            print("Instagram is not installed on this device.")
        }
    }
}

struct SeatMapView_Previews: PreviewProvider {
    static var previews: some View {
        SeatMapView(viewModel: SeatViewModel(seatMapObj: nil), highlightedSeats: [])
    }
}
