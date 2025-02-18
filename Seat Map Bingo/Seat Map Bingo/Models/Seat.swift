//
//  Seat.swift
//  Seat Map Bingo
//
//  Created by Evan Westermann on 10/22/24.
//

import SwiftUI

struct Seat: Codable {
    let seatNumber: String
//    let characteristicsCodes: [String]
    let coordinates: Coordinates
//    let id = UUID()
//    let row: Int
//    let column: Int
//    var isSelected: Bool
}

extension Seat: Identifiable {
    var id: String {
        return "\(coordinates.y)\(numberToLetter(coordinates.x)!)"
    }
}

func numberToLetter(_ number: Int) -> String? {
    // Ensure the number is between 1 and 26
    guard number >= 1 && number <= 26 else { return nil }
    // Convert the number to a character
    let letter = Character(UnicodeScalar(number + 64)!) // 65 is ASCII for 'A'
    return String(letter)
}

extension Seat: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(seatNumber)
//        hasher.combine(characteristicsCodes)
        hasher.combine(coordinates)
//        hasher.combine(isSelected)
    }
}

struct SeatViewObj: Codable {
    let seat: Seat
//    let row: Int
//    let column: Int
    var isSelected: Bool
}
