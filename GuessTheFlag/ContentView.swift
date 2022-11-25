//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tirth on 10/13/22.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State var score = 0
    @State var answerTitle = ""
    @State var showingScore = false
    var body: some View {
        ZStack {
            
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30 ) {
                Text("Tap the flag of")
                    .font(.subheadline.weight(.bold))
                    .foregroundColor(.white)
                
                Text(countries[correctAnswer])
                    .font(.largeTitle.weight(.semibold))
                    .foregroundColor(.white)
                ForEach(0..<3) { number in
                    Button {
                        validateAnswer(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                    }
                }
            }
        }
        .alert(answerTitle, isPresented: $showingScore) {
            Button("Continue", action: refreshQuestion)
        } message: {
            Text("Your score: \(score)")
        }
    }
    
    func validateAnswer(_ number: Int) {
        if(correctAnswer == number) {
            score+=1
            answerTitle = "Correct!"
        } else {
            answerTitle = "Wrong!"
        }
        showingScore = true
    }
    
    func refreshQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
