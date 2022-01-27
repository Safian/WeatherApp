//
//  WeatherModel.swift
//  weatherApp
//
//  Created by Safian Szabolcs on 2022. 01. 26..
//

import Foundation

public struct WeatherClientData: Codable {
    let coord: CoordClientData
    let base: String
    let weather: [WeatherDataClientData]
    let main: MainClientData
    let visibility: Int
    let wind: WindClientData
    let clouds: CloudsClientData
    let dt: Int
    let sys: SysClientData
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}
