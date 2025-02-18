//
//  AchievementView.swift
//  Seat Map Bingo
//
//  Created by Christopher McKiernan on 10/23/24.
//

import SwiftUI

struct AchievementView: View {
    var achievement: Achievement
    var onSelect: (Achievement) -> Void // Add a callback for selection
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: achievement.image)
                    .font(.system(size: 35, weight: .light))
                    .foregroundStyle(Color.blue)
                VStack(alignment: .leading) {
                    achievementText()
                    ProgressView(value: achievement.progress)
                }
                .frame(maxWidth: screenWidth * 0.73)
            }
            .frame(maxWidth: screenWidth * 0.91, maxHeight: screenHeight * 0.073)
            .onTapGesture {
                onSelect(achievement) // Trigger callback when selected
            }
            Divider()
        }
    }
    
    @ViewBuilder func achievementText() -> some View {
        VStack(alignment: .leading) {
            Text(achievement.title)
                .fontWeight(.bold)
            Text(achievement.description)
        }
        .multilineTextAlignment(.leading)
    }
    
    @ViewBuilder func progressBar() -> some View {
        
    }
    
    // Screen width.
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    // Screen height.
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
}

#Preview {
    AchievementView(achievement: Achievement(
        image: "trophy",
        title: "Achievement Title",
        description: "Description for Achievement",
        progress: 0.5),
                    onSelect: {_ in }
    )
}
