//
//  DifficultyLevel.swift
//  whizKidz
//
//  Created by Tina Jureško on 08.05.2025..
//

import Foundation

enum DifficultyLevel: Int {
    case easy = 1
    case medium
    case hard
}

func difficultyForCurrentLevel(for currentLevelIndex: Int) -> DifficultyLevel {
    switch currentLevelIndex {
    case 0...2: return .easy
    case 3...5: return .medium
    default: return .hard
    }
}
