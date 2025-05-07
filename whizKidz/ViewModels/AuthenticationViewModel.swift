//
//  AuthenticationViewModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 08.04.2025..
//

import Foundation
import SwiftUI
import CryptoKit

class AuthenticationViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool 
    @Published var showError: Bool = false
    @Published var usernameTaken: Bool = false
    
    init() {
        self.isAuthenticated = AuthManager.isUserAuthorized()
    }

    func hashPassword(password: String) -> String {
        let passwordData = Data(password.utf8)
        let hashed = SHA256.hash(data: passwordData)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    func checkIfUsernameExists() {
        do {
            if let _ = try DBManager.shared.fetchUser(username: username) {
                usernameTaken = true
            } else {
                usernameTaken = false
            }
        } catch {
            print("Error checking username: \(error)")
            usernameTaken = false
        }
    }
    
    func registerUser() {
        checkIfUsernameExists()
        guard !usernameTaken else { return }
        
        let hashedPassword = hashPassword(password: password)
        let currentDate = Date()
        let newUser = UserDb(username: username, password: hashedPassword, age: nil, createdAt: currentDate)
        do {
            try DBManager.shared.saveUser(newUser)
            UserDefaults.standard.set(username, forKey: KeysManager.userDefaultsKey)
            
            let token = UUID().uuidString
            KeychainManager.shared.save(token, forKey: KeysManager.keychainKey)
            
            isAuthenticated = AuthManager.isUserAuthorized()
        } catch {
            print("Registration error: \(error)")
            showError = true
        }
    }
    
    func loginUser() {
        do {
            if let user = try DBManager.shared.fetchUser(username: username) {
                if user.password == hashPassword(password: password) {
                    UserDefaults.standard.set(username, forKey: KeysManager.userDefaultsKey)
                    
                    let token = UUID().uuidString
                    KeychainManager.shared.save(token, forKey: KeysManager.keychainKey)
                    
                    isAuthenticated = AuthManager.isUserAuthorized()
                    showError = false
                } else {
                    showError = true
                }
            } else {
                showError = true
            }
        } catch {
            print("Login error: \(error)")
            showError = true
        }
    }
    
    func logOut() {
        UserDefaults.standard.removeObject(forKey: KeysManager.userDefaultsKey)
        KeychainManager.shared.delete(forKey: KeysManager.keychainKey)
        self.username = ""
        self.password = ""
        isAuthenticated = AuthManager.isUserAuthorized()
        showError = false
        usernameTaken = false
    }
    
    func printAllUsers() {
        do {
            let users = try DBManager.shared.fetchAllUsers()
            for user in users {
                print("Username: \(user.username), Created At: \(user.createdAt), Age: \(String(describing: user.age))")
            }
        } catch {
            print("Error fetching users: \(error)")
        }
    }
}

