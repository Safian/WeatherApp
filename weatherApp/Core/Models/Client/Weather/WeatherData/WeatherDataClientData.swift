//
//  WeatherData.swift
//  weatherApp
//
//  Created by Safian Szabolcs on 2022. 01. 26..
//

import Foundation

struct WeatherDataClientData: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
