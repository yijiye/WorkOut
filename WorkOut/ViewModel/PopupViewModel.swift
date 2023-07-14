//
//  PopupViewModel.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/07/04.
//

final class PopupViewModel {
    
    weak var delegate: DataSavable?
    
    let workoutPart: String
    private let coreDataManager = CoreDataManager.shared
    
    init(workoutPart: String) {
        self.workoutPart = workoutPart
    }
    
    func saveData(_ data: TodayWorkout) {
        coreDataManager.create(data)
        
        guard let data = coreDataManager.read(by: data.id) else { return }
        delegate?.saveSubject.send(data)
    }
}
