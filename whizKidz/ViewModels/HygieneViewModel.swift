//
//  HygieneViewModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 25.03.2025..
//

import Foundation

class HygieneViewModel: ObservableObject {
    @Published var currentQuestion: HygieneProblem?
    @Published var usedQuestions: [HygieneProblem] = []
    @Published var round: Int = 0
    @Published var correctAnswers: Int = 0
    @Published var startTime: Date?
    @Published var endTime: Date?
    @Published var duration: TimeInterval?
    @Published var speedMultiplier: Double = 1.0
    @Published var finalScore: Double = 0.0
    
    init() {
        startTime = Date()
        getNextQuestion()
    }
    
    func getNextQuestion() {
        if let nextQuestion = getQuestion() {
            currentQuestion = nextQuestion
        }
    }
    
    private func getQuestion() -> HygieneProblem? {
        let availableQuestions = hygieneProblems.filter { question in
                    !usedQuestions.contains(where: { $0 == question })
                }
        
        if let nextQuestion = availableQuestions.randomElement() {
            usedQuestions.append(nextQuestion)
            return nextQuestion
        }
        
        usedQuestions.removeAll()
        
        return hygieneProblems.randomElement()
    }
    
    func playAgain() {
        round = 0
        correctAnswers = 0
        startTime = Date()
        getNextQuestion()
    }
    
    func calculateFinalScore() {
        endTime = Date()
        if let start = startTime, let end = endTime {
            let duration = end.timeIntervalSince(start)
            speedMultiplier = max(1.0, 120.0 / duration)
            finalScore = (Double(correctAnswers)/10)*speedMultiplier
        }
    }
}
