//
//  WorkoutViewModel.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/26.
//

import Foundation

final class WorkoutViewModel {
    private let shoulder = "figure.strengthtraining.traditional"
    private let back = "figure.rower"
    private let chest = "figure.mind.and.body"
    private let arm = "figure.play"
    private let abs = "figure.core.training"
    private let hamstrings = "figure.strengthtraining.functional"
    private let calves =  "figure.highintensity.intervaltraining"
    private let waist = "figure.cooldown"
    private let leg = "figure.cross.training"
    
    lazy var workoutDictionary: [String: String] = [shoulder: Body.shoulder.description,
                                                    back: Body.back.description,
                                                    chest: Body.chest.description,
                                                    arm: Body.arm.description,
                                                    abs: Body.abs.description,
                                                    leg: Body.leg.description,
                                                    hamstrings: Body.hamstrings.description,
                                                    calves: Body.calves.description,
                                                    waist: Body.waist.description]
}
