//
//  ManagerAssembly.swift
//  weatherApp
//
//  Created by Safian Szabolcs on 2022. 01. 26..
//

import Swinject

class ManagerAssembly: Assembly {

    func assemble(container: Container) {

        container.register(NavigationManager.self) { _ in
            NavigationManager()
        }.inObjectScope(.container)
    }
}
