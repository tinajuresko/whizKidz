//
//  LoginView.swift
//  whizKidz
//
//  Created by Tina Jureško on 08.04.2025..
//

import SwiftUI

struct LoginView: View {
    @State private var showRegister = false
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Text("Login")
                .font(.largeTitle.bold())
                .foregroundColor(.gray)
                .padding(.top, 40)
            
            VStack(spacing: 16) {
                TextField("Username", text: $viewModel.username)
                    .textFieldStyle(CustomTextField())
                    .autocapitalization(.none)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(CustomTextField())
                    .autocapitalization(.none)
            }
            if viewModel.showError {  
                Text("Username or password is incorrect")
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(.top, 4)
            }
            
            Button(action: viewModel.loginUser) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.button)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            
            Button("Don't have an account?") {
                showRegister = true
            }
            .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .fullScreenCover(isPresented: $showRegister) {
            RegisterView().environmentObject(viewModel)
        }
    }
}


#Preview {
    LoginView()
}
