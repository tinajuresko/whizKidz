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
    
}

let mathProblems: [MathProblem] = [
    MathProblem(question: "1 + 2", answers: ["2", "3", "4", "5"], correctAnswer: ["3"]),
    MathProblem(question: "2 + 3", answers: ["4", "5", "6", "7"], correctAnswer: ["5"]),
    MathProblem(question: "4 + 5 + 6", answers: ["12", "13", "14", "15"], correctAnswer: ["15"]),
    MathProblem(question: "7 - 3", answers: ["3", "4", "5", "6"], correctAnswer: ["4"]),
    MathProblem(question: "3 + 6 + 1", answers: ["8", "9", "10", "11"], correctAnswer: ["10"]),
    MathProblem(question: "5 - 2", answers: ["2", "3", "4", "5"], correctAnswer: ["3"]),
    MathProblem(question: "6 + 4", answers: ["8", "9", "10", "11"], correctAnswer: ["10"]),
    MathProblem(question: "9 - 4", answers: ["4", "5", "6", "7"], correctAnswer: ["5"]),
    MathProblem(question: "3 + 3 + 3", answers: ["8", "9", "10", "11"], correctAnswer: ["9"]),
    MathProblem(question: "2 + 2 + 2", answers: ["5", "6", "7", "8"], correctAnswer: ["6"]),
    MathProblem(question: "2 x 3", answers: ["5", "6", "7", "8"], correctAnswer: ["6"]),
    MathProblem(question: "4 x 2", answers: ["6", "7", "8", "9"], correctAnswer: ["8"]),
    MathProblem(question: "5 x 3", answers: ["12", "13", "14", "15"], correctAnswer: ["15"]),
    MathProblem(question: "6 x 2", answers: ["10", "11", "12", "13"], correctAnswer: ["12"]),
    MathProblem(question: "1 + 5 + 3", answers: ["7", "8", "9", "10"], correctAnswer: ["9"]),
    MathProblem(question: "8 - 2 - 3", answers: ["2", "3", "4", "5"], correctAnswer: ["3"]),
    MathProblem(question: "7 + 4", answers: ["10", "11", "12", "13"], correctAnswer: ["11"]),
    MathProblem(question: "3 x 4", answers: ["10", "11", "12", "13"], correctAnswer: ["12"]),
    MathProblem(question: "6 + 7 + 2", answers: ["13", "14", "15", "16"], correctAnswer: ["15"]),
    MathProblem(question: "10 - 5 - 2", answers: ["2", "3", "4", "5"], correctAnswer: ["3"])
]
