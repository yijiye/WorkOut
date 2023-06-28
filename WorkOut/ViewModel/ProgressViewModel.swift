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
    let countdownLabel = PassthroughSubject<String, Never>()
    let countdownComplete = PassthroughSubject<Void, Never>()
    
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
    
    deinit {
        timer?.cancel()
    }
}
