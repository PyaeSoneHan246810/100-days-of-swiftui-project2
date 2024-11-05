import SwiftUI

struct MainContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correntAnswer  = Int.random(in: 0...2)
    @State private var showScoreAlert = false
    @State private var scoreAlertTitle = ""
    @State private var score = 0
    @State private var questionCount = 0
    @State private var showFinalAlert = false
    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(color: .orange, location: 0),
                    .init(color: .red, location: 0.4)
                ],
                center: .top,
                startRadius: 200,
                endRadius: 600
            )
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                VStack(
                    spacing: 20
                ) {
                    VStack(
                        spacing: 4
                    ) {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correntAnswer])
                            .foregroundStyle(.primary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 4)
                        }
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.thinMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    .padding(.horizontal, 20)
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
        }.ignoresSafeArea()
            .alert(
                scoreAlertTitle,
                isPresented: $showScoreAlert
            ) {
                Button("Continue") {
                    continueGame()
                }
            } message: {
                Text("Your current score is \(score).")
            }
            .alert(
                "Game Finished",
                isPresented: $showFinalAlert
            ) {
                Button("Restart") {
                    restartGame()
                }
            } message: {
                Text("Your total score is \(score).")
            }
    }
    
    private func flagTapped(_ number: Int) {
        questionCount += 1
        if questionCount >= 8 {
            showFinalAlert = true
            showScoreAlert = false
        } else {
            showFinalAlert = false
            showScoreAlert = true
        }
        if number == correntAnswer {
            scoreAlertTitle = "Correct"
            score += 1
        } else {
            scoreAlertTitle = "Wrong! That's the flag of \(countries[number])"
        }
    }
    
    private func continueGame() {
        countries.shuffle()
        correntAnswer = Int.random(in: 0...2)
        showScoreAlert = false
        scoreAlertTitle = ""
        showFinalAlert = false
    }
    
    private func restartGame() {
        countries.shuffle()
        correntAnswer = Int.random(in: 0...2)
        showScoreAlert = false
        scoreAlertTitle = ""
        score = 0
        questionCount = 0
        showFinalAlert = false
    }
}

#Preview {
    MainContentView()
}
