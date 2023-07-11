//
//  NetworkError.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/07/05.
//

enum NetworkError: Error {
    case invalidURL
    case httpResponse
    case invalidJSON(_ error: String)
    case statusCode(code: Int)
    case unknown
}
