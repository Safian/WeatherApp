//
//  WeatherDetailsViewModel.swift
//  weatherApp
//
//  Created by Safian Szabolcs on 2022. 01. 26..
//

import Foundation
import Combine
import UIKit

class WeatherDetailsViewModel {

    // MARK: - Disposables
    var disposables = Set<AnyCancellable>()
    
    // MARK: - NavigationData
    var navigationData: WeatherDetailsNavigationData?

    // MARK: - Inject
    @Injected private var weatherAPI: WeatherApiProtocol

    // MARK: - Published
    @Published var detailsModels: DetailsViewModel? = nil
    @Published var icon: UIImage? = nil
    @Published var error: String? = nil

    // MARK: - public Functions

    func getData() {
        guard let cityName = navigationData?.citiyName else { return }
        weatherAPI.getWeather(with: cityName)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case let .failure(error): self?.presentError(error)
            default: break
            }
        }, receiveValue: { [weak self] (data) in
            self?.createModel(with: data)
        }).store(in: &disposables)
    }
    
    // MARK: Private functions

    private func createModel(with data: WeatherClientData) {
        guard let weather = data.weather.first else { return }
        detailsModels = DetailsViewModel(temperature: "\(data.main.temp) C°",
                                         temperatureMax: "\(data.main.tempMax) C°",
                                         temperatureMin: "\(data.main.tempMin) C°",
                                         description: weather.description,
                                         iconUrl: "http://openweathermap.org/img/wn/\(weather.icon)@2x.png")
    }

    private func presentError(_ error: Error) {
        self.error = error.localizedDescription
    }
}
