//
//  LevelsView.swift
//  whizKidz
//
//  Created by Tina Jureško on 08.05.2025..
//

import SwiftUI

struct LevelsView: View {
    @StateObject private var viewModel = LevelsViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image("appBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
           
            VStack(spacing: 20) {
                    Text("Your Current Level")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white.opacity(0.25))
                            .frame(maxWidth: .infinity)
                            .shadow(radius: 5)
                        
                        VStack(spacing: 15) {
                            
                            Image(viewModel.currentLevel.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                            
                            Text(viewModel.currentLevel.name)
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                            
                            Text(viewModel.currentLevel.text)
                                .font(.body)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            if viewModel.progressToNextLevel > 0 {
                                VStack(spacing: 8) {
                                    ProgressView(value: viewModel.progressToNextLevel / 100.0) 
                                        .progressViewStyle(LinearProgressViewStyle(tint: .white))
                                        .frame(height: 10)
                                        .background(Color.white.opacity(0.2))
                                        .clipShape(Capsule())
                                    
                                    Text("\(Int(viewModel.progressToNextLevel))% to next level")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal)
                                .padding(.top, 50)
                            }

                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    
                    Spacer()
            }
            .padding(.top, 80)
            
            
            GifImageView(name: "astronautAwards")
                .frame(width: 120, height: 120)
                .padding(.bottom, 80)
                .padding(.trailing, 20)
        }
        .onAppear {
            viewModel.calculateUserLevel()
        }
    }
}


#Preview {
    LevelsView()
}
