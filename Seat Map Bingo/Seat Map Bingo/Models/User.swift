//
//  User.swift
//  Seat Map Bingo
//
//  Created by Evan Bakkal on 10/22/24.
//

import Foundation

struct User: Codable {
    let rapidRewardsNumber: Int
    let firstName: String
    let lastName: String
    
    
    // MARK: - Computed Propertie
    var firstAndLastName: String {
        firstName + " " + lastName
    }
    
    
}

extension User: Identifiable {
    var id: Int {
        rapidRewardsNumber
    }
}
