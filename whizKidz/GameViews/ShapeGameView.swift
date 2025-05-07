//
//  ShapeGameView.swift
//  whizKidz
//
//  Created by Tina Jureško on 24.02.2025..
//

import SwiftUI
import SpriteKit

struct ShapeGameView: View {
    var scene: SKScene {
        let scene = ShapeGameScene()
        scene.size = CGSize(width: 390, height: 844)
        scene.scaleMode = .fill
        return scene
    }
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}

#Preview {
    ShapeGameView()
}
