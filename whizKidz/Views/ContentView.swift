//
//  ContentView.swift
//  whizKidz
//
//  Created by Tina Jureško on 31.12.2024..
//

import SwiftUI
import UIKit

struct ContentView: View {
    @StateObject private var authViewModel = AuthenticationViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Image("appBackground")
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
                                .frame(width: 35, height: 35)
                                .padding(.top, 100)
                                .padding(.leading)
                        }
                        
                        NavigationLink(destination: LevelsView()){
                            Image("award")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .padding(.top, 100)
                        }
                        
                        NavigationLink(destination: StatisticsView()){
                            Image("statistics")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .padding(.top, 100)
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
                        Spacer()
                        GifImageView(name: "astronautGreetings")
                            .frame(width: 120, height: 120)
                            .padding(.bottom, 24)
                            .offset(y: -20)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
