//
//  WeatherApi.swift
//  weatherApp
//
//  Created by Safian Szabolcs on 2022. 01. 26..
//

import Combine
import Foundation

public class WeatherApi: BaseApi, WeatherApiProtocol {

    public func getWeather(with cityName:String) -> AnyPublisher<WeatherClientData, Error> {
        var urlComponents = URLComponents(string: base)!
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: cityName),
            URLQueryItem(name: "appid", value: API_KEY),
            URLQueryItem(name: "units", value: "metric"), //ez is jöhetne locale-ből akár
            URLQueryItem(name: "lang", value: Locale.preferredLanguages.first?.components(separatedBy: "-").first ?? "hu")
        ]
        let request = URLRequest(url: urlComponents.url!)
        return build(with: request).eraseToAnyPublisher()
    }
}
