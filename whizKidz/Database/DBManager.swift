//
//  DBManager.swift
//  whizKidz
//
//  Created by Tina Jureško on 08.04.2025..
//

import Foundation
import GRDB

final class DBManager {
    
    static let shared = DBManager()
    
    lazy var dbQueue: DatabaseQueue = {
        let dbPath = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("db-diplomski.sqlite")
            .path
        print("Database path: \(dbPath)")
        return try! DatabaseQueue(path: dbPath)
    }()
    
    private init() {
        createTables()
    }
    
    private func createTables() {
        var migrator = DatabaseMigrator()
        migrator.registerMigration("createUserTable") { db in
            try db.create(table: "UserDb") { t in
                t.column("username", .text).primaryKey()
                t.column("password", .text).notNull()
                t.column("age", .integer)
                t.column("createdAt", .datetime).notNull()
            }
        }
        
        migrator.registerMigration("createGameStatisticsTable") { db in
            try db.create(table: "GameStatisticsDb") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("gameName", .text).notNull()
                t.column("userId", .text).notNull().references("UserDb", onDelete: .cascade)
                t.column("category", .text).notNull()
                t.column("score", .double).notNull()
                t.column("timestamp", .datetime).notNull()
            }
        }
        do {
            try migrator.migrate(dbQueue)
        } catch {
            print("Error migrating database: \(error.localizedDescription)")
        }
    }
    
    func saveUser(_ user: UserDb) throws {
        do {
            try dbQueue.write { db in
                try user.upsert(db)
            }
        } catch {
            print("Error saving user: \(error.localizedDescription)")
        }
    }
    
    func saveGameStatistics(userId: String, gameName: String, category: String, score: Double) {
        let timestamp = Date()
        let gameStats = GameStatisticsDb(gameName: gameName, userId: userId, category: category, score: score, timestamp: timestamp)
        
        do {
            try dbQueue.write { db in
                try gameStats.upsert(db)
            }
        } catch {
            print("Error saving game statistics: \(error.localizedDescription)")
        }
    }
    
    func fetchUser(username: String) throws -> UserDb? {
        do {
            return try dbQueue.read { db in
                try UserDb.fetchOne(db, key: username)
            }
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchGameStatistics(userId: String, category: String, from startDate: Date, to endDate: Date) -> [GameStatisticsDb] {
        do {
            return try dbQueue.read { db in
                try GameStatisticsDb.fetchAll(db, sql: """
                    SELECT * FROM GameStatisticsDb
                    WHERE userId = ? AND category = ? AND timestamp >= ? AND timestamp < ?
                """, arguments: [userId, category, startDate, endDate])
            }
        } catch {
            print("Error fetching game statistics: \(error.localizedDescription)")
            return []
        }
    }
   
    func fetchAllUsers() throws -> [UserDb] {
        try dbQueue.read { db in
            let users = try UserDb.fetchAll(db)
            return users
        }
    }
    
    func fetchAllScores(for userId: String) -> [GameStatisticsDb] {
        do {
            return try dbQueue.read { db in
                try GameStatisticsDb.fetchAll(db, sql: """
                    SELECT * FROM GameStatisticsDb
                    WHERE userId = ?
                """, arguments: [userId])
            }
        } catch {
            print("Error fetching all scores: \(error.localizedDescription)")
            return []
        }
    }

    func fetchTotalScore(for userId: String) -> Double {
        do {
            return try dbQueue.read { db in
                let total = try Double.fetchOne(db, sql: """
                    SELECT SUM(score) FROM GameStatisticsDb
                    WHERE userId = ?
                """, arguments: [userId]) ?? 0.0
                return total
            }
        } catch {
            print("Error fetching total score: \(error.localizedDescription)")
            return 0.0
        }
    }
}

struct UserDb: Codable, FetchableRecord, PersistableRecord {
    static var databaseTableName: String { "UserDb" }
    
    var username: String
    var password: String
    var age: Int?
    var createdAt: Date
}

enum Category: String, CaseIterable, Identifiable {
    case Memory = "Memory"
    case MotorSkills = "Motor Skills"
    case LogicalThinking = "Logical Thinking"
    case LanguageUnderstanding = "Language Understanding"
    
    var id: String { self.rawValue }
}

struct GameStatisticsDb: Codable, FetchableRecord, PersistableRecord {
    var id: Int64?
    var gameName: String
    var userId: String
    var category: String
    var score: Double
    var timestamp: Date
    
    static var databaseTableName: String { "GameStatisticsDb" }
}

