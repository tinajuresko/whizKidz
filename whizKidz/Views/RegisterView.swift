//
//  RegisterView.swift
//  whizKidz
//
//  Created by Tina Jureško on 08.04.2025..
//

import SwiftUI

struct RegisterView: View {
    @State private var showLogin = false
    @EnvironmentObject var viewModel: AuthenticationViewModel
        
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Text("Registration")
                .font(.largeTitle.bold())
                .foregroundColor(.gray)
                .padding(.top, 40)
                
            VStack(spacing: 16) {
                TextField("Username", text: $viewModel.username)
                    .textFieldStyle(CustomTextField())
                if viewModel.usernameTaken {
                    Text("Username is already taken.")
                        .foregroundColor(.red)
                        .font(.caption)
                }
                    
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(CustomTextField())
            }
                
            Button(action: viewModel.registerUser) {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.button)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
                
            Button("Already have an account?") {
                showLogin = true
            }
            .foregroundColor(.gray)
                
            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .fullScreenCover(isPresented: $showLogin) {
            LoginView().environmentObject(viewModel)
        }
    }
}



#Preview {
    RegisterView()
}
