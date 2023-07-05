//
//  NetworkManager.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/07/05.
//

import Foundation
import Combine

struct NetworkManager: Requestable {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func request<T>(_ request: WeatherEndpoint) -> AnyPublisher<T, NetworkError> where T : Decodable {
        guard let url = request.createURLRequestForGET()?.url else {
            return AnyPublisher(
                Fail(error: .invalidURL))
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { output in
                guard output.response is HTTPURLResponse else {
                    throw NetworkError.httpResponse
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError{ error in
                return NetworkError.invalidJSON(String(describing: error))
            }
            .eraseToAnyPublisher()
    }
    
}
