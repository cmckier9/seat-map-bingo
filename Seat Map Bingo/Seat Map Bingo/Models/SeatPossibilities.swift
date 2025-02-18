//
//  SeatPossibilities.swift
//  Seat Map Bingo
//
//  Created by Evan Westermann on 10/23/24.
//

import Foundation

// Struct for Bingo Pattern
struct BingoPattern: Codable, Identifiable {
    let id: Int
    let title: String
    let seat: [String]
    
    // Custom init to decode array of mixed types
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        id = try container.decode(Int.self)
        title = try container.decode(String.self)
        seat = try container.decode([String].self)
    }
}

// Model for handling an array of Bingo Patterns
struct BingoPatternList: Codable {
    let patterns: [BingoPattern]
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var patterns = [BingoPattern]()
        
        while !container.isAtEnd {
            let pattern = try container.decode(BingoPattern.self)
            patterns.append(pattern)
        }
        
        self.patterns = patterns
    }
}

