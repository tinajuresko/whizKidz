//
//  StatisticsViewModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 09.04.2025..
//

import Foundation

struct DailyScore: Identifiable {
    let id = UUID()
    let date: Date
    let score: Double
}


class StatisticsViewModel: ObservableObject {
    @Published var motorSkillsScore: Double = 0.0
    @Published var memoryScore: Double = 0.0
    @Published var logicScore: Double = 0.0
    @Published var languageUnderstandingScore: Double = 0.0
    private var gameId: String = ""
    
    private var userId: String {
        UserDefaults.standard.string(forKey: KeysManager.userDefaultsKey) ?? ""
    }
    
    init() {}
    
    func calculateWeeklyAverageScoreDifference(category: String) -> Double {
        let calendar = Calendar.current
        let now = Date()
        
        guard let startOfThisWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now)),
              let startOfLastWeek = calendar.date(byAdding: .weekOfYear, value: -1, to: startOfThisWeek),
              let endOfThisWeek = calendar.date(byAdding: .day, value: 7, to: startOfThisWeek) else {
            return 0
        }
        
        let endOfLastWeek = startOfThisWeek
        
        let lastWeekStats = DBManager.shared.fetchGameStatistics(userId: userId, category: category, from: startOfLastWeek, to: endOfLastWeek)
        let thisWeekStats = DBManager.shared.fetchGameStatistics(userId: userId, category: category, from: startOfThisWeek, to: endOfThisWeek)
        
        let avgLastWeek = lastWeekStats.map { $0.score }.average()
        let avgThisWeek = thisWeekStats.map { $0.score }.average()
        
        return avgThisWeek - avgLastWeek
    }
    
    func generateProgressComment(delta: Double) -> String {
        if delta > 0 {
            return "Great progress! The child has achieved better results in this category than last week."
        } else if delta < 0 {
            return "Performance has dropped slightly in this category. It may be helpful to play more times to improve the child's performance."
        } else {
            return "The results remained the same in this category. It might be a good idea to keep the current pace of play."
        }
    }
    
    func getProgressCommentForCategory(category: String) -> String {
        let delta = calculateWeeklyAverageScoreDifference(category: category)
        return generateProgressComment(delta: delta)
    }
    
    func fetchDailyScoresForWeek(category: String) -> [DailyScore] {
        let calendar = Calendar.current
        let now = Date()
        
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now)) else {
            return []
        }
        
        var scores: [DailyScore] = []
        
        for dayOffset in 0..<7 {
            guard let day = calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek) else { continue }
            let startOfDay = calendar.startOfDay(for: day)
            let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
            
            let dayStats = DBManager.shared.fetchGameStatistics(userId: userId, category: category, from: startOfDay, to: endOfDay)
            let avg = dayStats.map { $0.score }.average()
            
            scores.append(DailyScore(date: day, score: avg))
        }
        
        return scores
    }

}
