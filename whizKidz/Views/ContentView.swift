//
//  ContentView.swift
//  whizKidz
//
//  Created by Tina Jureško on 31.12.2024..
//

import SwiftUI
import UIKit

struct ContentView: View {
    @StateObject private var viewModel = GreetingsViewModel()
    @StateObject private var authViewModel = AuthenticationViewModel()

    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack (spacing: 10){
                    HStack {
                        NavigationLink(destination: ProfileView()){
                            Image("profile-settings")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 55, height: 55)
                                .padding(.leading)
                        }
                        
                        NavigationLink(destination: StatisticsView()){
                            Image("award")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 55, height: 55)
                        }
                        
                        Spacer()
                    }
                    
                    
                    ScrollView(.vertical){
                        VStack(spacing: 10) {
                            ForEach(games){ game in
                                NavigationLink(destination: game.view){
                                    ThemeCard(imageName: game.imageName, text: game.text)
                                }
                            }
                        }
                    }.padding()
                    
                    HStack {
                        ZStack {
                            Image("thinkingCloud")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 250)
                
                            Text(viewModel.displayedText)
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .padding(20)
                                .frame(width: 230, height: 230)
                                .foregroundColor(.black)
                                .offset(x: -10,y: -20)
                        }
                        .offset(y: -10)
                        
                        GifImageView(name: "homeBee")
                            .frame(width: 120, height: 120)
                            .padding(.top, 50)
                            .offset(y: 20)
                    }
                }
            }
            .onAppear {
                viewModel.getRandomGreetings()
                authViewModel.printAllUsers()
            }
        }
        
    }
}

#Preview {
    ContentView()
}
