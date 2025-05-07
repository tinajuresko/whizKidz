//
//  AuthManager.swift
//  whizKidz
//
//  Created by Tina Jureško on 07.05.2025..
//

import Foundation

struct AuthManager {
    static func isUserAuthorized() -> Bool {
        let name = UserDefaults.standard.string(forKey: KeysManager.userDefaultsKey)
        let token = KeychainManager.shared.read(forKey: KeysManager.keychainKey)
        
        return name != nil && token != nil
    }
}
