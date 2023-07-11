//
//  HTTPMethod.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/07/05.
//

enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        }
    }
}
