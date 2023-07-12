//
//  PopupViewModel.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/07/04.
//

final class PopupViewModel {
    
    let workoutPart: String
    private let coreDataManager = CoreDataManager.shared
    
    init(workoutPart: String) {
        self.workoutPart = workoutPart
    }
    
    func saveData(_ data: TodayWorkout) {
        coreDataManager.create(data)
    }
}
