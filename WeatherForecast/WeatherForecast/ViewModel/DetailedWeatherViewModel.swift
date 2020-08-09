//
//  DetailedWeatherViewModel.swift
//  WeatherForecast
//
//  Created by Dmytro Mashtaler on 8/9/20.
//  Copyright © 2020 1. All rights reserved.
//

import Foundation
import UIKit

final class DetailedWeatherViewModel {
    
    // MARK: - Properties
    private var cityWeather: CityWeather? {
        didSet {
            shouldUpdateUI?()
        }
    }
    var currentCity = ""
    
    // MARK: Outputs
    var shouldUpdateUI: (() -> Void)?
    var shouldShowError: ((String) -> Void)?
    
    // MARK: Accessors
    var descriptionLabelText: String? {
        return cityWeather?.weather?.first?.weatherDescription
    }
    
    var weatherIcon: UIImage? {
        guard let icon = cityWeather?.weather?.first?.icon else {
            return UIImage()
        }
        
        return UIImage(named: icon)
    }
    
    var minTempretureText: String? {
        guard let minTemp = cityWeather?.temperature?.tempretureMin else {
            return ""
        }
        let tempInCelsium = convertTemp(temp: minTemp, from: .kelvin, to: .celsius)
        return "min temp:" + " " + tempInCelsium
    }
    
    var maxTempretureText: String? {
        guard let maxTemp = cityWeather?.temperature?.tempretureMax else {
            return ""
        }
        let tempInCelsium = convertTemp(temp: maxTemp, from: .kelvin, to: .celsius)
        return "max temp:" + " " + tempInCelsium
    }
    
    var tempretureText: String? {
        guard let temp = cityWeather?.temperature?.tempreture else {
            return ""
        }
        let tempInCelsium = convertTemp(temp: temp, from: .kelvin, to: .celsius)
        return "Tempreture:" + " " + tempInCelsium
    }
    
    // MARK: Private methods
    private func convertTemp(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .providedUnit
        let input = Measurement(value: temp, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        return measurementFormatter.string(from: output)
    }
    
    // MARK: Public methods
    func onViewDidLoad() {
        WeatherManager.shared.getWeatherByCityName(cityName: currentCity) { [weak self] (success, code, error, weather) in
            if success {
                self?.cityWeather = weather
            }
            
            if let error = error {
                self?.shouldShowError?(error)
            }
        }
    }
    
    func loadWeatherIcon(completion: @escaping (UIImage?)->()) {
        guard let icon = cityWeather?.weather?.first?.icon, let imageData = try? Data(contentsOf: URL(string: "http://openweathermap.org/img/w/\(icon).png")!) else {
            return
        }
        
        let image = UIImage(data: imageData)
        DispatchQueue.main.async {
            completion(image)
        }
    }
}
