//
//  Emoji.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/07/12.
//

enum Emoji: CustomStringConvertible {
    case bad, notBad, good, veryGood, excellent
    
    var description: String {
        switch self {
        case .bad:
            return "😢"
        case .notBad:
            return "😞"
        case .good:
            return "🙂"
        case .veryGood:
            return "😆"
        case .excellent:
            return "😎"
        }
    }
}
