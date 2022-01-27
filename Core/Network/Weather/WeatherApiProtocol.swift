//
//  WeatherApiProtocol.swift
//  weatherApp
//
//  Created by Safian Szabolcs on 2022. 01. 26..
//

import Foundation
import Combine

let API_KEY = "46bd73f32d5f3a3df602df4ad94cbddb"

public protocol WeatherApiProtocol {

    func getWeather(with cityName:String) -> AnyPublisher<WeatherClientData, Error>

}

