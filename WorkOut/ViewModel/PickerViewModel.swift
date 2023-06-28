//
//  PickerViewModel.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/27.
//

import Combine
import Foundation

final class PickerViewModel {
    @Published var inputLabel: String = "00:00:00"
    @Published var isMeasurable: Bool = true
    let timerSubject = PassthroughSubject<(String, TimerType), Never>()
    var type: TimerType = .workout {
        didSet {
            switch type {
            case .setCount:
                inputLabel = "1"
            default:
                inputLabel = "00:00:00"
            }
        }
    }
    
    private func update(_ numberButton: String) {
        switch type {
        case .setCount:
            updateSetCount(numberButton)
        default:
            updateInput(numberButton)
        }
    }
    
    private func updateInput(_ numberButton: String) {
        guard let number = Int(numberButton) else { return }
        var components = inputLabel.components(separatedBy: ":").joined()
        let initialValue = "000000"
        
        if components != initialValue {
            components += numberButton
            checkTime(components)
            guard let componentsInt = Int(components) else { return }
            inputLabel = splitTime(componentsInt)
        } else {
            inputLabel = splitTime(number)
        }
    }
    
    private func updateSetCount(_ numberButton: String) {
        if inputLabel == NumberPad.one.description {
            inputLabel = ""
            inputLabel += numberButton
        } else {
            inputLabel += numberButton
        }
    }
    
    private func splitTime(_ time: Int) -> String {
        let seconds = time % 100
        let minutes = (time / 100) % 100
        let hours = time / 10000
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    private func checkTime(_ time: String) {
        let zeroCount = time.filter { String($0) == NumberPad.zero.description }.count
        if zeroCount == 1 {
            isMeasurable = false
        }
    }
    
    private func reset() {
        switch type {
        case .setCount:
            inputLabel = "1"
        default:
            inputLabel = "00:00:00"
        }
        isMeasurable = true
    }
    
    private func delete(_ button: String) {
        switch type {
        case .setCount:
            deleteCount(button)
        default:
            deleteTimer(button)
        }
    }
    
    private func deleteTimer(_ button: String) {
        let components = inputLabel.components(separatedBy: ":").joined()
        guard let componentsInt = Int(components) else { return }
        inputLabel = splitTime(componentsInt / 10)
        isMeasurable = true
    }
    
    private func deleteCount(_ button: String) {
        let result = String(inputLabel.dropLast())
        inputLabel = result
    }
    
    private func saveTimer(_ type: TimerType) {
        let components = inputLabel.components(separatedBy: ":")
        guard var seconds = Int(components[2]),
              var minutes = Int(components[1]),
              var hours = Int(components[0]) else { return }
        
        if seconds > 60 {
            let sec = seconds % 60
            let min = seconds / 60
            seconds = sec
            minutes += min
        } else if minutes > 60 {
            let min = minutes % 60
            let hour = minutes / 60
            minutes = min
            hours += hour
        }
        reset()
        
        let timer = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        timerSubject.send((timer, type))
    }
    
    private func saveCount() {
        timerSubject.send((inputLabel, .setCount))
    }
}

extension PickerViewModel {
    func enterNumber(_ numberButton: String) {
        if numberButton == NumberPad.reset.description {
            reset()
        } else if numberButton == NumberPad.delete.description {
            delete(numberButton)
        } else if isMeasurable == true {
            update(numberButton)
        }
    }
    
    func saveLabel(_ type: TimerType) {
        switch type {
        case .setCount:
            saveCount()
        default:
            saveTimer(type)
        }
    }
}
