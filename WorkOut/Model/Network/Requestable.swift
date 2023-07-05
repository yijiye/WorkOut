//
//  Requestable.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/07/05.
//

import Combine

protocol Requestable {
    func request<T: Decodable>(_ request: WeatherEndpoint) -> AnyPublisher<T, NetworkError>
}
