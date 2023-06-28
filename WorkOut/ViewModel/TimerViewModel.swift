//
//  TimerViewModel.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/27.
//

import Combine
import Foundation

final class TimerViewModel {
    @Published var workoutTimerLabel: String = "00:00:00"
    @Published var restTimerLabel: String = "00:00:00"
    @Published var setCountLabel: String = "1"
    let countdownLabel = PassthroughSubject<String, Never>()
    
    private let pickerViewModel: PickerViewModel
    private var cancellables = Set<AnyCancellable>()
    private var timer: Cancellable?
    
    init(pickerViewModel: PickerViewModel) {
        self.pickerViewModel = pickerViewModel
        
        bind()
    }
    
    private func bind() {
        pickerViewModel.timerSubject
            .filter { (_, timerType) in
                timerType == .workout
            }
            .sink { [weak self] (label, _) in
                self?.workoutTimerLabel = label
            }
            .store(in: &cancellables)
        pickerViewModel.timerSubject
            .filter { (_, timerType) in
                timerType == .rest
            }
            .sink { [weak self] (label, _) in
                self?.restTimerLabel = label
            }
            .store(in: &cancellables)
        pickerViewModel.timerSubject
            .filter { (_, timerType) in
                timerType == .setCount
            }
            .sink { [weak self] (label, _) in
                self?.setCountLabel = label
            }
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        timer?.cancel()
    }
}

extension TimerViewModel {
    
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
                }
            }
        
        countdownLabel.send(String(count))
    }
}
