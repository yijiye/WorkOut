//
//  NumberPad.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/27.
//

enum NumberPad: CustomStringConvertible {
    case zero, one, two, three, four, five, six, seven, eight, nine, reset, delete
    
    var description: String {
        switch self {
        case .zero:
            return "0"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .reset:
            return "C"
        case .delete:
            return "DEL"
        }
    }
}
