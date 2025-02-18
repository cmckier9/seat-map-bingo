//
//  SeatMap.swift
//  Seat Map Bingo
//
//  Created by Evan Bakkal on 10/23/24.
//

import Foundation

struct SeatMapResonse: Codable {
    let data: SeatMapData
}
struct SeatMapData: Codable {
    let seatmaps: [SeatMaps]
}

struct SeatMaps: Codable {
    let decks: [Deck]
    static let facilitiesDictionary: [String:String] = [:]
    static let seatCharacteristicsDictionary: [String:String] = [:]
}

struct Deck: Codable {
    let deckDimensions: DeckDimensions
    let facilities: [Facility]
    let seats: [Seat]
}

struct DeckDimensions: Codable {
    let width: Int
    let length: Int
//    let startSeatRow: Int
//    let endSeatRow: Int
//    let startWingsX: Int
//    let endWingsX: Int
//    let startWingsRow: Int
//    let endWingsRow: Int
//    let exitRowsX: [Int]
}

struct Facility: Codable {
    let code: String
    let column: String
    let row: String
    let position: String
    let coordinates: Coordinates
}

struct Coordinates: Codable, Hashable, Comparable {
    let x: Int
    let y: Int
    
    static func == (lhs: Coordinates, rhs: Coordinates) -> Bool {
        return (lhs.x, lhs.y) == (rhs.x, rhs.y)
    }
    
    static func < (lhs: Coordinates, rhs: Coordinates) -> Bool {
        return (lhs.x, lhs.y) < (rhs.x, rhs.y)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

