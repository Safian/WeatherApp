//
//  NavigationManager.swift
//  weatherApp
//
//  Created by Safian Szabolcs on 2022. 01. 26..
//

import UIKit

class NavigationManager {

    func navigateToWeatherDetail(with data: WeatherDetailsNavigationData, navigationController: UINavigationController?) {
        if let viewController = WeatherDetailsViewController.createViewController(data) {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
