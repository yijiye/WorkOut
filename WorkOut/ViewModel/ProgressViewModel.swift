//
//  ProgressViewModel.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/29.
//

import Foundation
import Combine

final class ProgressViewModel {
    private var timer: Cancellable?
    private var workoutTimer: Cancellable?
    private var restTimer: Cancellable?
    
    @Published var timerType: TimerType = .workout
    @Published var workoutTimerLabel: String = ""
    @Published var restTimerLabel: String = ""
    @Published var setCount: String = ""
    
    private var defaultWorkout: String?
    private var defaultRest: String?
    
    private let timerViewModel: TimerViewModel
    private var cancellables = Set<AnyCancellable>()
    
    let countdownLabel = PassthroughSubject<String, Never>()
    let countdownComplete = PassthroughSubject<Void, Never>()
    let isFinished = PassthroughSubject<Void, Never>()
    
    init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
        
        bind()
    }
    
    private func bind() {
        timerViewModel.$workoutTimerLabel
            .sink {[weak self] in
                guard let convertTime = self?.convertToTimeInterval($0) else { return }
                self?.defaultWorkout = convertTime
                self?.workoutTimerLabel = convertTime
            }
            .store(in: &cancellables)
        timerViewModel.$restTimerLabel
            .sink {[weak self] in
                guard let convertTime = self?.convertToTimeInterval($0) else { return }
                self?.defaultRest = convertTime
                self?.restTimerLabel = convertTime
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
    
    private func updateTimerLabel(_ timerLabel: String, _ timer: Cancellable?) -> String? {
        let timeComponents = timerLabel.split(separator: ":")
        
        var hours = 0
        var minutes = 0
        var seconds = 0
        
        if timeComponents.count == 2 {
            minutes = Int(timeComponents[0]) ?? 0
            seconds = Int(timeComponents[1]) ?? 0
        } else if timeComponents.count == 3 {
            hours = Int(timeComponents[0]) ?? 0
            minutes = Int(timeComponents[1]) ?? 0
            seconds = Int(timeComponents[2]) ?? 0
        }
        
        if seconds > 0 {
            seconds -= 1
        } else if minutes > 0 {
            minutes -= 1
            seconds = 59
        } else if hours > 0 {
            hours -= 1
            minutes = 59
            seconds = 59
        } else {
            isFinished.send()
            checkTimerType()
            timer?.cancel()
        }
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    private func checkTimerType() {
        switch timerType {
        case .workout:
            guard let defaultRest else { return }
            restTimerLabel = defaultRest
            timerType = .rest
            startRestTimer()
        case .rest:
            guard let defaultWorkout else { return }
            workoutTimerLabel = defaultWorkout
            timerType = .workout
            checkFinalSet()
        case .setCount:
            return
        }
    }
    
    private func checkFinalSet() {
        if setCount != "0" {
            guard let count = Int(setCount) else { return }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.startWorkoutTimer(count)
            }
        }
    }
    
    private func startWorkoutTimer(_ count: Int) {
        var leftCount = count
        leftCount -= 1
        setCount = String(leftCount)
        
        workoutTimer = Timer.publish(every: 1.0, on: .main, in: .default)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self,
                      let workoutTimerLabel = self.updateTimerLabel(self.workoutTimerLabel, workoutTimer) else { return }
                
                self.workoutTimerLabel = workoutTimerLabel
            }
    }
    
    private func startRestTimer() {
        restTimer = Timer.publish(every: 1.0, on: .main, in: .default)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self,
                      let restTimerLabel = self.updateTimerLabel(self.restTimerLabel, restTimer) else { return }
                
                self.restTimerLabel = restTimerLabel
            }
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
                    self?.timer?.cancel()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self?.countdownComplete.send()
                    }
                }
            }
        
        countdownLabel.send(String(count))
    }
    
    func start() {
        guard let count = Int(setCount) else { return }
        startWorkoutTimer(count)
    }
}
