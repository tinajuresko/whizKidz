//
//  Array+Extensions.swift
//  whizKidz
//
//  Created by Tina Jureško on 07.05.2025..
//

import Foundation

extension Array where Element == Double {
    func average() -> Double {
        guard !isEmpty else { return 0 }
        return reduce(0, +) / Double(count)
    }
}
