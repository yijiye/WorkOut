//
//  WeatherInformation.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/07/05.
//

struct WeatherInformation: Decodable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let date: Double
    let system: System
    let timezone, id: Int
    let name: String
    let cod: Int
    
    private enum CodingKeys: String, CodingKey {
        case coord, weather, base, main, visibility, wind, clouds
        case date = "dt"
        case system = "sys"
        case timezone, id, name, cod
    }
}

// MARK: - Coord
struct Coord: Decodable {
    let longitude: Double
    let latitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let weatherState, description, icon: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case weatherState = "main"
        case description, icon
    }
}

// MARK: - Main
struct Main: Decodable {
    let temperature, feelsLike, temperatureMinimun, temperatureMaximum: Double
    let pressure, humidity: Int

    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case temperatureMinimun = "temp_min"
        case temperatureMaximum = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double
    let degrees: Int
    let gust: Double
    
    private enum CodingKeys: String, CodingKey {
        case speed
        case degrees = "deg"
        case gust
    }
}

// MARK: - Clouds
struct Clouds: Decodable {
    let all: Int
}

// MARK: - System
struct System: Decodable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Double
}
