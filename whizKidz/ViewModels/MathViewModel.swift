//
//  MathViewModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 04.01.2025..
//

import Foundation

class MathViewModel: ObservableObject {
    @Published var currentQuestion: MathProblem?
    @Published var usedQuestions: [MathProblem] = []
    @Published var round: Int = 0
    
    init() {
        getNextQuestion()
    }
    
    func getNextQuestion() {
        if let nextQuestion = getQuestion() {
            currentQuestion = nextQuestion
        }
    }
    
    private func getQuestion() -> MathProblem? {
        let availableQuestions = mathProblems.filter { question in
                    !usedQuestions.contains(where: { $0 == question })
                }
        
        if let nextQuestion = availableQuestions.randomElement() {
            usedQuestions.append(nextQuestion)
            return nextQuestion
        }
        
        usedQuestions.removeAll()
        
        return mathProblems.randomElement()
    }
    
    func playAgain() {
        round = 0
        getNextQuestion()
    }
    
}

