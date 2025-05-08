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
    private let ageRange = Array(3...12)
    
    init() {
        let username = UserDefaults.standard.string(forKey: KeysManager.userDefaultsKey) ?? "default"
        _selectedAvatar = AppStorage(wrappedValue: "penguin", "selectedAvatar_\(username)")
    }

    var body: some View {
        ZStack {
            Image("appBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Spacer().frame(height: 40)
                
                Image(selectedAvatar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .onTapGesture { showingAvatarPicker = true }
                
                Text("Tap the Avatar to change it")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(username.isEmpty ? "No Username" : username)
                    .font(.title.bold())
                    .foregroundColor(.gray)
                    .padding(.bottom, 12)
                
                VStack(spacing: 16) {
                    Text("Select Your Age")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(ageRange, id: \.self) { age in
                                Text("\(age)")
                                    .font(.headline)
                                    .frame(width: 50, height: 50)
                                    .background(selectedAge == age ? Color.blue : Color.gray.opacity(0.3))
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle().stroke(Color.white, lineWidth: selectedAge == age ? 3 : 0)
                                    )
                                    .onTapGesture {
                                        selectedAge = age
                                        saveAge()
                                    }
                                    .animation(.easeInOut, value: selectedAge)
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.85))
                .cornerRadius(20)
                .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Spacer()
                    GifImageView(name: "astronautProfile")
                        .frame(width: 100, height: 100)
                        .padding(.trailing, 20)
                        .padding(.bottom, 10)
                }
                
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
                .padding(.bottom, 100)
            }
            .sheet(isPresented: $showingAvatarPicker){
                AvatarSelectionView(selectedAvatar: $selectedAvatar)
            }
            .padding(.top, 100)
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
