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
   
    private let pickerViewModel: PickerViewModel
    let workoutPart: String
    private var cancellables = Set<AnyCancellable>()
  
    init(pickerViewModel: PickerViewModel, workoutPart: String) {
        self.pickerViewModel = pickerViewModel
        self.workoutPart = workoutPart
        
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
    }
}
