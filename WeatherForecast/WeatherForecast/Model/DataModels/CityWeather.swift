//
//  CityWeather.swift
//  WeatherForecast
//
//  Created by Dmytro Mashtaler on 8/9/20.
//  Copyright © 2020 1. All rights reserved.
//

import Foundation

struct CityWeather: Codable {
    var id: Int?
    var name: String?
    var temperature: Temperature?
    var weather: [Weather]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case temperature = "main"
        case weather
    }
}

struct Temperature: Codable {
    var tempreture: Double?
    var tempretureMin: Double?
    var tempretureMax: Double?
    
    enum CodingKeys: String, CodingKey {
        case tempreture = "temp"
        case tempretureMin = "temp_min"
        case tempretureMax = "temp_max"
    }
}

struct Weather: Codable {
    var weatherDescription: String?
    var icon: String?
    
    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
        case icon
    }
}
