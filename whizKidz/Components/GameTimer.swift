//
//  GameTimer.swift
//  whizKidz
//
//  Created by Tina Jureško on 07.05.2025..
//

import Foundation
import Combine

class GameTimer: ObservableObject {
    @Published var timeRemaining: Int
    @Published var isRunning: Bool = false
    private var timer: AnyCancellable?
    private let totalTime: Int
    private let onFinished: () -> Void

    init(totalTime: Int, onFinished: @escaping () -> Void) {
        self.totalTime = totalTime
        self.timeRemaining = totalTime
        self.onFinished = onFinished
    }

    func start() {
        stop()
        timeRemaining = totalTime
        isRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.stop()
                    self.onFinished()
                }
            }
    }

    func stop() {
        timer?.cancel()
        timer = nil
        isRunning = false
    }

    func reset() {
        stop()
        timeRemaining = totalTime
    }
}
