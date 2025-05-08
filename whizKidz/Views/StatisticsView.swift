//
//  StatisticsView.swift
//  whizKidz
//
//  Created by Tina Jureško on 07.05.2025..
//

import SwiftUI
import Charts

struct StatisticsView: View {
    @StateObject var viewModel = StatisticsViewModel()
    @State private var selectedCategory: Category = .Memory
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image("appBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)

            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        CategoryButton(category: .Memory, selectedCategory: $selectedCategory)
                        CategoryButton(category: .MotorSkills, selectedCategory: $selectedCategory)
                        CategoryButton(category: .LogicalThinking, selectedCategory: $selectedCategory)
                        CategoryButton(category: .LanguageUnderstanding, selectedCategory: $selectedCategory)
                    }
                    .padding()
                }

                ScrollView {
                    VStack {
                        Text("Progress for \(selectedCategory.rawValue.capitalized)")
                            .font(.title)
                            .padding(.top, 20)

                        let delta = viewModel.calculateWeeklyAverageScoreDifference(category: selectedCategory.rawValue)
                        let comment = viewModel.generateProgressComment(delta: delta)

                        Text(comment)
                            .font(.body)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                            .padding()

                        let scores = viewModel.fetchDailyScoresForWeek(category: selectedCategory.rawValue)

                        Chart {
                            ForEach(scores) { score in
                                BarMark(
                                    x: .value("Day", score.date, unit: .day),
                                    y: .value("Score", score.score)
                                )
                                .foregroundStyle(Color.blue.gradient)
                            }
                        }
                        .frame(height: 200)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                    .padding()
                }

                Spacer(minLength: 0)
            }
            .padding(.top, 100)
            
            GifImageView(name: "astronautStatistics")
                .frame(width: 120, height: 120)
                .padding(.bottom, 80)
                .padding(.trailing, 20)
        }
    }
}

struct CategoryButton: View {
    var category: Category
    @Binding var selectedCategory: Category
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                selectedCategory = category
            }
        }) {
            Text(category.rawValue.capitalized)
                .fontWeight(.bold)
                .padding()
                .frame(minWidth: 100, minHeight: 50)
                .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .scaleEffect(selectedCategory == category ? 1.1 : 1.0)
                .animation(.easeInOut, value: selectedCategory)
        }
    }
}

#Preview {
    StatisticsView()
}

