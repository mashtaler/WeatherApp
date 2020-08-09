//
//  CitiesListViewModel.swift
//  WeatherForecast
//
//  Created by Dmytro Mashtaler on 8/9/20.
//  Copyright © 2020 1. All rights reserved.
//

import Foundation

final class CitiesListViewModel {

    // MARK: - Properties
    private var cities: [City] = [] {
        didSet {
            shouldUpdateTableView?()
        }
    }
    var selectedIndex = 0
    
    // MARK: Outputs
    var shouldUpdateTableView: (() -> Void)?
    var shouldShowError: ((String) -> Void)?
    
    // MARK: Accessors
    var numbersOfRows: Int {
        return cities.count
    }
    
    // MARK: Public methods
    func getCityName(by index: Int) -> String {
        return cities[index].name
    }
    
    func onViewDidLoad() {
        if let url = Bundle.main.url(forResource: "cityList", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let cityArray = try decoder.decode([City].self, from: data)
                cities = cityArray

            } catch {
                shouldShowError?(error.localizedDescription)
            }
        }
    }
}
