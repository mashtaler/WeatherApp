//
//  WeatherService.swift
//  WeatherForecast
//
//  Created by Dmytro Mashtaler on 8/8/20.
//  Copyright © 2020 1. All rights reserved.
//


import Moya

enum WeatherService {
    case getWeatherByCityName(cityName: String)
}

extension WeatherService: TargetType {
    
    var baseURL: URL {
        return URL(string:"https://api.openweathermap.org/data/2.5")!
        
    }
    
    var path: String {
        switch self {
        case .getWeatherByCityName:
            return "/weather"
        }
    }
    
    var method: Method {
        switch self {
        case .getWeatherByCityName:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        
        case .getWeatherByCityName(let cityName):
            return .requestParameters(parameters: ["q": cityName, "appid": StringConstants.openWeatherAPIKey], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        let headers = ["Content-type": "application/json"]
        return headers
    }
    
    var sampleData: Data {
        return Data()
    }
}
