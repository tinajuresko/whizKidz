//
//  ProfileView.swift
//  whizKidz
//
//  Created by Tina Jureško on 06.03.2025..
//

import SwiftUI

struct ProfileView: View {
    
    @State private var profileImage: Image? = Image(systemName: "person.circle.fill")
    @AppStorage("savedUsername") private var username: String = ""
    @EnvironmentObject var authenticationVM: AuthenticationViewModel
    @AppStorage var selectedAvatar: String
    @State private var showingAvatarPicker = false
    
    @State private var selectedAge: Int = 5
    private let ageRange = Array(3...18)

    
    init() {
        let username = UserDefaults.standard.string(forKey: KeysManager.userDefaultsKey) ?? "default" //AppStorage gore definiran nije jos spreman da bi se koristio u initu
        _selectedAvatar = AppStorage(wrappedValue: "penguin", "selectedAvatar_\(username)") //backing storage zbog dinamickog appstoragea selectedAvatar
    }

    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(selectedAvatar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .onTapGesture {
                        showingAvatarPicker = true
                    }
                    .padding()
                Text("Click on the Avatar to change it!")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                
                Text(username.isEmpty ? "No Username" : username)
                    .font(.title)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Your Age:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                                        
                    Picker("Age", selection: $selectedAge) {
                            ForEach(ageRange, id: \.self) { age in
                                Text("\(age) years").tag(age)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 100)
                        .clipped()
                        .onChange(of: selectedAge) { _ in
                            saveAge()
                        }
                }
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.horizontal)
                
                Spacer()
                Button(action: logOut) {
                    Label("Log out", systemImage: "arrow.right.square.fill")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            .sheet(isPresented: $showingAvatarPicker){
                AvatarSelectionView(selectedAvatar: $selectedAvatar)
            }
        }
        .onAppear {
            loadUserAge()
        }
    }
    
    func loadUserAge() {
        do {
            if let user = try DBManager.shared.fetchUser(username: username),
            let userAge = user.age {
                selectedAge = userAge
            }
        } catch {
            print("Error loading user age: \(error.localizedDescription)")
        }
    }
    
    func logOut() {
        authenticationVM.logOut()
    }
    
    func saveAge() {
        do {
            if var user = try DBManager.shared.fetchUser(username: username) {
                user.age = selectedAge
                try DBManager.shared.saveUser(user)
            }
        } catch {
            print("error saving age: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ProfileView().environmentObject(AuthenticationViewModel())
}
