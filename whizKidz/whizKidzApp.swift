//
//  whizKidzApp.swift
//  whizKidz
//
//  Created by Tina Jureško on 31.12.2024..
//

import SwiftUI

@main
struct whizKidzApp: App {
    @StateObject private var authenticationVM = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            if authenticationVM.isAuthenticated {
                ContentView().environmentObject(authenticationVM)
            } else {
                LoginView().environmentObject(authenticationVM)
            }
        }
    }
}
