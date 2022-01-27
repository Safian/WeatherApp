//
//  NetworkAssembly.swift
//  weatherApp
//
//  Created by Safian Szabolcs on 2022. 01. 26..
//

import Swinject
import Foundation

class NetworkAssembly: Assembly {

    func assemble(container: Container) {

        container.register(WeatherApiProtocol.self) { _ in
            WeatherApi()
        }.inObjectScope(.container)

    }
}

