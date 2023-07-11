//
//  Weekday.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/21.
//

enum Weekday: CaseIterable, CustomStringConvertible {
    case sun, mon, tue, wed, thu, fir, sat
    
    var description: String {
        switch self {
        case .sun:
            return "일"
        case .mon:
            return "월"
        case .tue:
            return "화"
        case .wed:
            return "수"
        case .thu:
            return "목"
        case .fir:
            return "금"
        case .sat:
            return "토"
        }
    }
}
