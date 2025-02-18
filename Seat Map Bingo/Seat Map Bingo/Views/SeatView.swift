//
//  SeatView.swift
//  Seat Map Bingo
//
//  Created by Christopher McKiernan on 10/22/24.
//

import SwiftUI

struct SeatView: View {
    var seat: SeatViewObj
    var isAchievement = false
    
    var body: some View {
        Text("")
            .frame(width: 40, height: 40)
            .cornerRadius(8)
            .foregroundColor(.white)
            .if(!isAchievement){ view in
                view.background(seat.isSelected ? Color.blue : Color.gray)
            }
    }
}
