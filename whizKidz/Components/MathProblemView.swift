//
//  MathProblemView.swift
//  whizKidz
//
//  Created by Tina Jureško on 04.01.2025..
//

import SwiftUI

struct MathProblemView: View {
    let problem: MathProblem
    let onSolve: () -> Void
    @State private var correctAnswer: String? = nil
    @State private var clickedAnswer: String? = nil
    
        
    var body: some View {
        VStack {
            Text(problem.question)
                .font(.title)
                .padding()
                
            HStack {
                ForEach(problem.answers, id: \.self) { answer in
                    Button(action: {
                        clickedAnswer = answer
                        if answer == problem.correctAnswer {
                            correctAnswer = answer
                            onSolve()
                        }
                    }) {
                        Text(answer)
                            .padding()
                            .background(self.buttonColor(for: answer))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .padding()
        .onChange(of: problem) { oldState, newState in
           clickedAnswer = nil
        }
    }
    
    private func buttonColor(for answer: String) -> Color {
        if clickedAnswer == nil { // not clicked
            return Color.blue
        } else if answer == problem.correctAnswer && answer == correctAnswer { // clicked and correct
            return Color.green
        } else if answer == clickedAnswer && answer != problem.correctAnswer { //clicked and incorrect
            return Color.red
        } else {
            return Color.blue
        }
    }
}

#Preview {
    MathProblemView(problem: MathProblem(question: "1 + 2", answers: ["2", "3", "4", "5"], correctAnswer: "3"),
                    onSolve: {print("solved")})
}
