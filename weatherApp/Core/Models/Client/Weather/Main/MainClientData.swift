//
//  MainData.swift
//  weatherApp
//
//  Created by Safian Szabolcs on 2022. 01. 26..
//

import Foundation

struct MainClientData: Codable {
    let temp: Float
    let feelsLike: Float
    let tempMin: Float
    let tempMax: Float
    let pressure: Int
    let humidity: Int
}
