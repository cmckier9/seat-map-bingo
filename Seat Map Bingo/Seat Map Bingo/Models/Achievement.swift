//
//  Achievement.swift
//  Seat Map Bingo
//
//  Created by Christopher McKiernan on 10/23/24.
//

import Foundation

struct Achievement: Codable, Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let description: String
    var progress: Float
}
