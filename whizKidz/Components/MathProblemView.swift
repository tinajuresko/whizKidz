//
//  MathProblemView.swift
//  whizKidz
//
//  Created by Tina Jureško on 04.01.2025..
//

import SwiftUI

protocol ProblemProtocol {
    var id: UUID { get }
    var question: String { get }
    var answers: [String] { get }
    var correctAnswer: [String] { get }
    var explanation: String? { get }
}

struct ProblemView<T: ProblemProtocol>: View {
    let problem: T
    let onSolve: (Bool) -> Void
    @State private var correctAnswer: String? = nil
    @State private var clickedAnswer: String? = nil
    
        
    var body: some View {
        VStack {
            Text(problem.question)
                .font(.title)
                .foregroundColor(.gray)
                .padding()
                
            VStack {
                ForEach(problem.answers, id: \.self) { answer in
                    Button(action: {
                        clickedAnswer = answer
                        let isCorrect = problem.correctAnswer.contains(answer)
                        if isCorrect {
                            correctAnswer = answer
                        }
                        onSolve(isCorrect)
                    }) {
                        Text(answer)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(self.buttonColor(for: answer))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .padding()
        .onChange(of: problem.id) { oldState, newState in
           clickedAnswer = nil
        }
    }
    
    private func buttonColor(for answer: String) -> Color {
        if clickedAnswer == nil { // not clicked
            return Color.blue
        } else if problem.correctAnswer.first(where: {$0 == answer}) != nil && answer == correctAnswer { // clicked and correct
            return Color.green
        } else if answer == clickedAnswer && !problem.correctAnswer.contains(answer) { //clicked and incorrect
            return Color.red
        } else {
            return Color.blue
        }
    }
}

#Preview {
    VStack {
        ProblemView(problem: MathProblem(
                question: "1 + 2",
                answers: ["2", "3", "4", "5"],
                correctAnswer: ["3"], difficulty: .easy),
                        onSolve: { _ in print("Solved Math!") })

        ProblemView(problem: HygieneProblem(
                question: "When should you wash your hands?",
                answers: ["Before eating", "After using the restroom", "All of the above"],
                correctAnswer: ["All of the above"],
                explanation: "Washing hands prevents the spread of germs."),
                        onSolve: { _ in print("Solved Hygiene!") })
    }
}
