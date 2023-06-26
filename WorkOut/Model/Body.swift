//
//  Body.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/26.
//

enum Body: CaseIterable, CustomStringConvertible {
    case shoulder
    case back
    case chest
    case abs
    case arm
    case waist
    case hamstrings
    case calves
    case leg
    
    var description: String {
        switch self {
        case .shoulder:
            return "어깨"
        case .back:
            return "등"
        case .chest:
            return "가슴"
        case .abs:
            return "복근"
        case .arm:
            return "팔"
        case .waist:
            return "허리"
        case .hamstrings:
            return "허벅지"
        case .calves:
            return "종아리"
        case .leg:
            return "다리"
        }
    }
}
