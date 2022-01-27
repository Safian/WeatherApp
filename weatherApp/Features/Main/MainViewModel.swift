//
//  MainViewModel.swift
//  weatherApp
//
//  Created by Safian Szabolcs on 2022. 01. 26..
//

import Foundation
import Combine

class MainViewModel {

    // MARK: - Disposables

    var disposables = Set<AnyCancellable>()

    // MARK: - Inject

    @Injected private var weatherAPI: WeatherApiProtocol

    // MARK: - Published

    @Published var cellModels: [CityCellModel] = []

    // MARK: - Properties

    var cities: [CityData] = [
        CityData(name: "Budapest", country: "Pest"),
        CityData(name: "Debrecen", country: "Hajdú-Bihar"),
        CityData(name: "Tata", country: "Tata"),
        CityData(name: "Város", country: "Megye")]

    // MARK: - Functions

    func getCities() {
        createCellModels()
    }

    // MARK: - Private Functions

    private func createCellModels() {
        cellModels = cities.map { city in
            return CityCellModel(name: city.name, country: city.country)
        }
    }
}
