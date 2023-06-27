//
//  PickerViewModel.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/27.
//

import Combine

final class PickerViewModel {
    @Published var inputLabel: String = "00:00:00"
    @Published var isMeasurable: Bool = true
    
    func enterNumber(_ numberButton: String) {
        reset(numberButton)

        if isMeasurable == true {
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
    
    private func reset(_ button: String) {
        if button == NumberPad.reset.description {
            inputLabel = "00:00:00"
            isMeasurable = true
        }
    }
}
