//
//  dataSavable.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/07/12.
//

import Combine

protocol DataSavable: AnyObject {
    var saveSubject: PassthroughSubject<WorkoutEntity, Never> { get set }
}
