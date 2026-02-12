//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by kalyan on 2/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private  var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var Score = 0
    
    @State private var questionCount = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(colors: [.red,.yellow,.blue], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                VStack(spacing: 50){
                    Spacer()
                    VStack() {
                        Text("Guess The correct Flag")
                            .font(.headline).foregroundStyle(.indigo)
                        Text(countries[correctAnswer])
                            .font(.subheadline)
                        
                        
                        ForEach(0..<3){number in
                            Button{
                                flagTapped(number)
                                if countries[number] == countries[correctAnswer]{
                                    scoreTitle = "correct"
                                    
                                } else{
                                    scoreTitle = "wrong"
                                }
                                showingScore = true
                            } label: {
                                Image(countries[number])
                            }.clipShape(Capsule())
                        }
                        
                        
                        Spacer()
                        Text("Score : \(Score)")
                    }
                    .padding()
                }
            }.navigationTitle("Guess the Flag")
                .alert(scoreTitle, isPresented: $showingScore){
                    Button("Continue", action: askQuestion)
                }message: {
                    Text("Your score is \(Score)")
                }
        }
    }
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            Score += 1
        } else if  number != correctAnswer{
            Score -= 1
        }
        
        if Score < 0 {
            Score = 0
        }
        
        questionCount += 1
        
        if questionCount == 8 {
            Score = 0
            questionCount = 0
        }
        
    }
    
    func askQuestion(){
       countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
   
}

#Preview {
    ContentView()
}
