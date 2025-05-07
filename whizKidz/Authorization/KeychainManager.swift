//
//  KeychainManager.swift
//  whizKidz
//
//  Created by Tina Jureško on 06.05.2025..
//

import Foundation
import KeychainAccess

final class KeychainManager {
    static let shared = KeychainManager()
    private let keychain: Keychain
    
    private init() {
        self.keychain = Keychain(service: "com.education")
    }
    
    func save(_ value: String, forKey key: String) {
        keychain[key] = value
    }
    
    func read(forKey key: String) -> String? {
        return keychain[key]
    }
    
    func delete(forKey key: String) {
        try? keychain.remove(key)
    }
}
