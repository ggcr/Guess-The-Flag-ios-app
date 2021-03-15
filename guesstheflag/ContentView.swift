import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    @State private var chose = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""

    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                       self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                    }
                }
                VStack {
                    Text("User Score: \(score)")
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            if(scoreTitle == "Correct") {
                return Alert(title: Text(scoreTitle), message: Text("Your score is \(score)!"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            } else {
                return Alert(title: Text(scoreTitle), message: Text("You clicked on the flag of \(countries[chose])\nYour score is \(score)!"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        chose = number
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
