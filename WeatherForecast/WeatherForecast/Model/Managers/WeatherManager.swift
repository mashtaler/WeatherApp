//
//  WeatherManager.swift
//  WeatherForecast
//
//  Created by Dmytro Mashtaler on 8/8/20.
//  Copyright © 2020 1. All rights reserved.
//

import Moya

struct StringConstants {
    static let openWeatherAPIKey = "225e37dcd3fc5733b8d0e39b3b7294f4"
}

class WeatherManager {
    static let shared = WeatherManager()
    private let appProvider = MoyaProvider<WeatherService>()
    
    func getWeatherByCityName(cityName: String, completion: @escaping (Bool, Int, String?, CityWeather?) -> Void) {
        
        appProvider.request(WeatherService.getWeatherByCityName(cityName: cityName)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let decoder = JSONDecoder()
                    
                    let cityWeather = try decoder.decode(CityWeather.self, from: moyaResponse.data)
                    
                    if 200...299 ~= moyaResponse.statusCode {
                        completion(true, moyaResponse.statusCode, nil, cityWeather)
                    } else {
                        completion(false, moyaResponse.statusCode, "Error", nil)
                    }
                } catch let error {
                    completion(false, moyaResponse.statusCode, error.localizedDescription, nil)
                }
                
            case let .failure(error):
                completion(false, 400, error.localizedDescription, nil)
            }
        }
    }
}
