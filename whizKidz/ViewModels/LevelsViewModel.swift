//
//  LevelsViewModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 08.05.2025..
//

import Foundation
import Foundation
import Combine

class LevelsViewModel: ObservableObject {
    @Published var currentLevel: Level = levels[0]
    @Published var progressToNextLevel: Double = 0.0
    
    private var userId: String {
        UserDefaults.standard.string(forKey: KeysManager.userDefaultsKey) ?? ""
    }
    
    func calculateUserLevel() {
        let totalScore = DBManager.shared.fetchTotalScore(for: userId)
        let levelIndex = min(Int(totalScore / 50), levels.count - 1)

        UserDefaults.standard.set(levelIndex, forKey: KeysManager.userDefaultsLevelKey)
        
        DispatchQueue.main.async {
            self.currentLevel = levels[levelIndex]
            let progressWithinLevel = totalScore.truncatingRemainder(dividingBy: 50) / 50.0
            self.progressToNextLevel = progressWithinLevel * 100 
        }
    }
}
