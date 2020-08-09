//
//  CitiesListViewController.swift
//  WeatherForecast
//
//  Created by Dmytro Mashtaler on 8/8/20.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

final class CitiesListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var citiesWeatherTableView: UITableView!
    
    // MARK: - Properties
    private lazy var viewModel = CitiesListViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        citiesWeatherTableView.delegate = self
        citiesWeatherTableView.dataSource = self
        viewModel.onViewDidLoad()
    }
    
    private func bindViewModel() {
        viewModel.shouldUpdateTableView = { [weak self] in
            self?.citiesWeatherTableView.reloadData()
        }
        
        viewModel.shouldShowError = { [weak self] error in
            self?.showAlert(message: error, title: "Error")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? DetailedWeatherViewController {
            destinationVC.viewModel.currentCity = viewModel.getCityName(by: viewModel.selectedIndex)
        }
    }

}

extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbersOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.getCityName(by: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectedIndex = indexPath.row
        performSegue(withIdentifier: "ShowDetailedWeatherViewController", sender: self)
    }
    
}
