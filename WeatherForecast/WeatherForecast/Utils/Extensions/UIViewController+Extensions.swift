//
//  UIViewController+Extensions.swift
//  WeatherForecast
//
//  Created by Dmytro Mashtaler on 8/10/20.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(message: String, title: String = "") {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }  
}
