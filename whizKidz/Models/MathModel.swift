//
//  MathModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 04.01.2025..
//

import Foundation

struct MathProblem: ProblemProtocol, Equatable {
    let id = UUID()
    let question: String
    let answers: [String]
    let correctAnswer: [String]
    let explanation: String? = nil
    let difficulty: DifficultyLevel
}

func generateProblem(level: DifficultyLevel) -> MathProblem {
    switch level {
    case .easy:
        let a = Int.random(in: 1...5)
        let b = Int.random(in: 1...5)
        let correct = a + b
        let answers = generateAnswerOptions(correct: correct)
        return MathProblem(
            question: "\(a) + \(b)",
            answers: answers,
            correctAnswer: ["\(correct)"],
            difficulty: .easy
        )

    case .medium:
        let a = Int.random(in: 1...10)
        let b = Int.random(in: 1...10)
        let c = Int.random(in: 1...5)
        let correct = a + b - c
        let answers = generateAnswerOptions(correct: correct)
        return MathProblem(
            question: "\(a) + \(b) - \(c)",
            answers: answers,
            correctAnswer: ["\(correct)"],
            difficulty: .medium
        )

    case .hard:
        let a = Int.random(in: 2...5)
        let b = Int.random(in: 2...5)
        let c = Int.random(in: 1...10)
        let correct = a * b + c
        let answers = generateAnswerOptions(correct: correct)
        return MathProblem(
            question: "\(a) x \(b) + \(c)",
            answers: answers,
            correctAnswer: ["\(correct)"],
            difficulty: .hard
        )
    }
}

func generateAnswerOptions(correct: Int) -> [String] {
    var options = Set([correct])
    while options.count < 4 {
        options.insert(correct + Int.random(in: -3...3))
    }
    return Array(options).shuffled().map { String($0) }
}

func generateMathProblemsSet(easyCount: Int = 10, mediumCount: Int = 10, hardCount: Int = 10) -> [MathProblem] {
    var problems: [MathProblem] = []

    for _ in 0..<easyCount {
        problems.append(generateProblem(level: .easy))
    }
    
    for _ in 0..<mediumCount {
        problems.append(generateProblem(level: .medium))
    }
    
    for _ in 0..<hardCount {
        problems.append(generateProblem(level: .hard))
    }

    return problems.shuffled()
}

let mathProblems: [MathProblem] = generateMathProblemsSet()

