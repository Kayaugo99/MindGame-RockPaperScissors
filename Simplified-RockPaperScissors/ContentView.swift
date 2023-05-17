//
//  ContentView.swift
//  Simplified-RockPaperScissors
//
//  Created by user239371 on 5/17/23.
//

import SwiftUI



struct ContentView: View {
    @State private var computerChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var alertIsShowing = false
    @State private var questionCount = 0
    let moves = ["✊","✋","✌️"]
    
    
    
    var body: some View {
        VStack {
            Spacer()
            Text("Computer has played...")
            Text(moves[computerChoice])
                .font(.system(size: 200))
            
            if shouldWin == true {
                Text("Which one wins?")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.green)
            } else {
                Text("Which one loses?")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.red)
            }
            
            HStack {
                ForEach(0..<3) { number in
                    Button(moves[number]) {
                        play(playerChoice: number)
                        questionCount += 1
                        shouldWin.toggle()
                        computerChoice = Int.random(in: 0..<3)
                    }
                    .font(.system(size: 80))
                }
            }
            Spacer()
            Text("Score is: \(score)")
            Spacer()
        }
        .padding()
        .alert("Game over", isPresented: $alertIsShowing) {
        } message: {
            Text("Final score is \(score)")
        }
    }
    
    
    func play(playerChoice: Int) {
        let winningMoves = [1, 2, 0]
        let didWin: Bool
        
        if shouldWin {
            didWin = playerChoice == winningMoves[computerChoice]
            
        } else {
            didWin = winningMoves[playerChoice] == computerChoice
        }
        
        if didWin {
            score += 1
        } else {
            if score > 0 {
                score -= 1
            }
        }
        if questionCount == 10 {
            alertIsShowing = true
            questionCount = 0
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
