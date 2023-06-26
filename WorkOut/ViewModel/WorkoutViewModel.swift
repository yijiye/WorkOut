//
//  WorkoutViewModel.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/26.
//

import Foundation

final class WorkoutViewModel {
    lazy var sortedWorkoutDictionary = workoutDictionary.sorted { $0.key > $1.key }
    private let workoutDictionary: [String: String] = [
        Body.shoulder.systemImage: Body.shoulder.description,
        Body.back.systemImage: Body.back.description,
        Body.chest.systemImage: Body.chest.description,
        Body.arm.systemImage: Body.arm.description,
        Body.abs.systemImage: Body.abs.description,
        Body.leg.systemImage: Body.leg.description,
        Body.hamstrings.systemImage: Body.hamstrings.description,
        Body.calves.systemImage: Body.calves.description,
        Body.waist.systemImage: Body.waist.description
    ]
}
