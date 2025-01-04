//
//  ColorModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 04.01.2025..
//

import Foundation

enum ColorChoice: String, CaseIterable {
    case red, blue, green, yellow, orange, purple, pink
}

struct MemoryCard: Identifiable {
    let id = UUID()
    var color: ColorChoice
    var isFlipped: Bool = false
}
