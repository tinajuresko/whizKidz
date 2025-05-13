//
//  ShapeGameViewModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 13.05.2025..
//

import Foundation
import Combine

class ShapeGameViewModel: ObservableObject {
    @Published var isGameOver = false
    @Published var correctClicks: Int = 0
    
    private var timer: Timer?
    private var startDate: Date?
    
    func startGame() {
        isGameOver = false
        correctClicks = 0
        startDate = Date()
    }
    
    func incrementScore() {
        correctClicks += 1
    }
    
    func endGame() {
        isGameOver = true
        saveResult()
    }
    
    private func saveResult() {
        let scoreDouble = Double(correctClicks)
        guard let username = UserDefaults.standard.string(forKey: KeysManager.userDefaultsKey) else { return }
        DBManager.shared.saveGameStatistics(
            userId: username,
            gameName: "ShapeGame",
            category: Category.MotorSkills.rawValue,
            score: scoreDouble
        )
    }
    
    func restartGame() {
        startGame()
    }
}
