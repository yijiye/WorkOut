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
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchJSON<T>(_ request: WeatherEndpoint) -> AnyPublisher<T, NetworkError> where T: Decodable {
        guard let url = request.createURLRequestForGET()?.url else {
            return AnyPublisher(Fail(error: .invalidURL))
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse else {
                    throw NetworkError.httpResponse
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.statusCode(code: httpResponse.statusCode)
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return NetworkError.invalidJSON(String(describing: error))
            }
            .eraseToAnyPublisher()
    }
    
    func fetchImage(_ request: WeatherEndpoint) -> AnyPublisher<Data, NetworkError> {
        guard let url = request.createURLRequestForGET()?.url else {
            return AnyPublisher(Fail(error: .invalidURL))
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse else {
                    throw NetworkError.httpResponse
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.statusCode(code: httpResponse.statusCode)
                }
                return output.data
            }
            .mapError { _ in
                NetworkError.unknown
            }
            .eraseToAnyPublisher()
    }
    
}
