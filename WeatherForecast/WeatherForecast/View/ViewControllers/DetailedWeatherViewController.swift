//
//  DetailedWeatherViewController.swift
//  WeatherForecast
//
//  Created by Dmytro Mashtaler on 8/8/20.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

final class DetailedWeatherViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tempretureLabel: UILabel!
    @IBOutlet weak var minTempretureLabel: UILabel!
    @IBOutlet weak var maxTempretureLabel: UILabel!
    
    // MARK: - Properties
    lazy var viewModel = DetailedWeatherViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.onViewDidLoad()
    }
}

// MARK: Private methods
private extension DetailedWeatherViewController {
    
    func bindViewModel() {
        viewModel.shouldUpdateUI = { [weak self] in
            self?.setupUI()
        }
        
        viewModel.shouldShowError = { [weak self] error in
            self?.showAlert(message: error, title: "Error")
        }
    }
    
    func setupUI() {
        title = viewModel.currentCity
        viewModel.loadWeatherIcon { (image) in
            self.weatherIconImageView.image = image
        }
        weatherDescriptionLabel.text = viewModel.descriptionLabelText
        tempretureLabel.text = viewModel.tempretureText
        minTempretureLabel.text = viewModel.minTempretureText
        maxTempretureLabel.text = viewModel.maxTempretureText
    }
}
