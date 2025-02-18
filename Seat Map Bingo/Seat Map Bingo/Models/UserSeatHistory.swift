//
//  UserSeatHistory.swift
//  Seat Map Bingo
//
//  Created by Christopher McKiernan on 10/23/24.
//

import Foundation

struct UserSeatHistory: Codable {
    let FlightID: String
    let SeatNumber: String
    let DateSat: String
    let BingoActive: Bool
    let CompleteBoardId: Bool?
}

struct UserSeatHistoryPost: Codable {
    let userID = 1
    let seat: String
    let flightID = "WN123"
}
