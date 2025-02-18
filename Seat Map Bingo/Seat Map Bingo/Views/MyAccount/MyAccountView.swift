//
//  MyAccountView.swift
//  Seat Map Bingo
//
//  Created by Evan Bakkal on 10/22/24.
//

import ConfettiSwiftUI
import SwiftUI

struct MyAccountView<ViewModel: MyAccountViewModel>: View {
    
    @ObservedObject var viewModel: MyAccountViewModel = MyAccountViewModel(user: User(rapidRewardsNumber: 380192, firstName: "Evan", lastName: "Westermann"))
    
    @State var bingoWinners: [String] = []
    
    @State private var showAlert = true
    
    @State private var counter: Int = 0
    // State variable to control the presentation of the modal
    @State var showSeatMapModal = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("beachbg")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0)
                    .edgesIgnoringSafeArea(.all)
                VStack {
//                    if !bingoWinners.isEmpty {
//                        Text("You won!")
//                            .alert(isPresented: $showAlert) {
//                                    Alert(
//                                        title: Text("We Have a Winner!"),
//                                        message: Text("You won bingo for flight " + bingoWinners.joined(separator: ", ")),
//                                        dismissButton: Alert.Button.default(
//                                                Text("Dismiss"), action: { bingoWinners = [] }
//                                            )
//                                    )
//                                }
//                            .onAppear(perform: {counter += 1})
//                            .confettiCannon(counter: $counter, num: 5, confettis: [.text("💺"), .text("✈️"), .text("❤️"), .text("💙"), .text("💛")], confettiSize: 20, repetitions: 100, repetitionInterval: 0.1)
//                    }
                    
                    userInfoSection()
                        .padding(.trailing, 95)
                    
                    accountHistorySection()
                        .padding(16)
                    
                    allChallengesSection()
                        .padding(16)
                    
                    seatMapSection()
                    
                    socialMediaSection()
                }
            }
        }
        .sheet(isPresented: $showSeatMapModal) {
            // Present the SeatMapView as a modal
            SeatMapView(viewModel: SeatViewModel(seatMapObj: nil), highlightedSeats: viewModel.highlightedSeats, isAchievement: true)
                if showSeatMapModal {
                    Text("You won!")
                    .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("We Have a Winner!"),
                                message: Text("You won bingo for flight " + bingoWinners.joined(separator: ", ")),
                                dismissButton: Alert.Button.default(
                                        Text("Dismiss"), action: { bingoWinners = [] }
                                    )
                            )
                        }
                    .onAppear(perform: {counter += 1})
                    .confettiCannon(counter: $counter, num: 5, confettis: [.text("💺"), .text("✈️"), .text("❤️"), .text("💙"), .text("💛")], confettiSize: 20, repetitions: 100, repetitionInterval: 0.1)
                }
        }
        .task {
            viewModel.fetchChallenges()
            
            API.shared.fetchData(from: "https://8npg08k6cl.execute-api.us-east-2.amazonaws.com/prod/seat-history-by-userid?userID=1") { result in
                switch result {
                case .success(let data):
                    // Handle the fetched data
                    print("Data received for user seat history: \(data)")
                    let decoder = JSONDecoder()
                    do {
                    let decoded = try decoder.decode([UserSeatHistory].self, from: data)
                        bingoWinners = viewModel.checkForWinningBingo(userHistory: decoded)
                        print(decoded)
                    } catch {
                        print(error)
                        }
                case .failure(let error):
                    // Handle error
                    print("Error occurred for user seat history: \(error)")
                }
            }
        }
    }
    
    // Define which seats are highlighted for each achievement
    func getHighlightedSeats(for achievement: Achievement) -> [String] {
        switch achievement.title {
        case "4 Corners":
            return ["1A", "1F", "4A", "4F"] // Example seats for the "4 Corners" challenge
        default:
            return []
        }
    }
    
    @ViewBuilder func allChallengesSection() -> some View {
        DisclosureGroup("All Challenges") {
            VStack( alignment: .leading) {
                ForEach(viewModel.challenges) { challenge in
                    Text(challenge.title)
                        .fontWeight(.bold)
                        .padding(.top)
                }
            }
        }
        .padding()
        .background(Color.white)
        .tint(.black)
    }
    
    @ViewBuilder func userInfoSection() -> some View {
        VStack(alignment: .leading) {
            Text("Hi, " + viewModel.user.firstAndLastName)
                .font(.body)
                .bold()
            Text("RR# \(viewModel.user.rapidRewardsNumber)")
                .font(.callout)
            Text("Rapid Rewards Member since 2022")
        }
    }
    
    @ViewBuilder func accountHistorySection() -> some View {
        DisclosureGroup("Achievements") {
            VStack {
                ForEach(viewModel.achievementList) { achievement in
                    AchievementView(achievement: achievement) { _ in
                        DispatchQueue.main.async {
                            // Handle achievement selection
                            viewModel.highlightedSeats = getHighlightedSeats(for: achievement)
                            // Ensure highlightedSeats are populated before showing the modal
                            print("Highlighted Seats: \(viewModel.highlightedSeats)") // Debugging line
                            showSeatMapModal = true // Show modal
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .tint(.black)
    }

    
    @ViewBuilder func seatMapSection() -> some View {
        VStack {
            NavigationLink {
                SeatMapView(viewModel: SeatViewModel(seatMapObj: nil), highlightedSeats: [])
            } label: {
                HStack {
                    Text("Bingo Board")
                        .foregroundStyle(Color.black)
                    
                    Spacer()
                        .frame(maxWidth: screenWidth * 0.56)
                    
                    Image(systemName: "arrow.right")
                        .font(.system(size: 15, weight: .light))
                        .foregroundStyle(Color.gray)
                }
                .frame(maxWidth: screenWidth * 0.91, maxHeight: screenHeight * 0.073)
                .background(Color.white)
            }
        }
    }
    
    @ViewBuilder func socialMediaSection() -> some View {
        EmptyView()
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

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView()
    }
}
