//
//  ProgressView.swift
//  whizKidz
//
//  Created by Tina Jureško on 23.02.2025..
//

import SwiftUI

struct CustomProgressView: View {
    @Binding var progress: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.7))
                        .frame(width: geometry.size.width)
                        .shadow(radius: 5)
                
                Path { path in
                    let startX: CGFloat = 50
                    let endX: CGFloat = geometry.size.width - 100
                    let y: CGFloat = 30
                    
                    path.move(to: CGPoint(x: startX, y: y))
                    path.addLine(to: CGPoint(x: startX + CGFloat(progress) * (endX - startX), y: y))
                }
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.blue.opacity(0.5), Color.clear]),
                        startPoint: .leading,
                        endPoint: .trailing),
                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                )
                .animation(.easeInOut(duration: 0.5), value: progress)
                
                
                HStack {
                    Image("butterfly")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .offset(x: CGFloat(progress) * (geometry.size.width - 100))
                        .animation(.easeInOut(duration: 0.5), value: progress)
                    
                    Spacer()

                    Image("rose")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                .frame(width: geometry.size.width)
            }
        }
        .frame(height: 60)
    }
}


#Preview {
    CustomProgressView(progress: .constant(0.0))
}
