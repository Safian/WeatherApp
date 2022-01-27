//
//  ViewModelAssembly.swift
//  weatherApp
//
//  Created by Safian Szabolcs on 2022. 01. 26..
//

import Swinject

class ViewModelAssembly: Assembly {

    func assemble(container: Container) {

        container.register(MainViewModel.self) { _ in
            MainViewModel()
        }

        container.register(WeatherDetailsViewModel.self) { _ in
            WeatherDetailsViewModel()
        }
    }
}
