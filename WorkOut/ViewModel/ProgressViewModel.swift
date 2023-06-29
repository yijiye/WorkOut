//
//  ProgressViewModel.swift
//  WorkOut
//
//  Created by jiye Yi on 2023/06/29.
//

import Foundation
import Combine

final class ProgressViewModel {
    private var timer: Cancellable?
    
    @Published var workoutTimer: String = "00:00:00"
    @Published var restTimer: String = "00:00:00"
    @Published var setCount: String = "1"
    
    private let timerViewModel: TimerViewModel
    private var cancellables = Set<AnyCancellable>()
    
    let countdownLabel = PassthroughSubject<String, Never>()
    let countdownComplete = PassthroughSubject<Void, Never>()
    
    init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
        
        bind()
    }
    
    private func bind() {
        timerViewModel.$workoutTimerLabel
            .sink {[weak self] in
                guard let convertTime = self?.convertToTimeInterval($0) else { return }
                self?.workoutTimer = convertTime
            }
            .store(in: &cancellables)
        timerViewModel.$restTimerLabel
            .sink {[weak self] in
                guard let convertTime = self?.convertToTimeInterval($0) else { return }
                self?.restTimer = convertTime
            }
            .store(in: &cancellables)
        timerViewModel.$setCountLabel
            .assign(to: \.setCount, on: self)
            .store(in: &cancellables)
    }
    
    private func convertToTimeInterval(_ time: String) -> String {
        var convertTime = time
        let components = convertTime.components(separatedBy: ":")
        
        let hours = components[0]
        
        if hours == "00" {
            convertTime = String(convertTime.dropFirst(3))
        }
        
        return convertTime
    }
    
    deinit {
        timer?.cancel()
    }
}

extension ProgressViewModel {
    
    func countDown() {
        var count = 3
        countdownLabel.send(String(count))
        
        timer = Timer.publish(every: 1.0, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                if count >= 1 {
                    count -= 1
                    self?.countdownLabel.send(String(count))
                } else {
                    let letsGo = "GO!"
                    self?.countdownLabel.send(letsGo)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self?.countdownComplete.send()
                    }
                }
            }
        
        countdownLabel.send(String(count))
    }
}
