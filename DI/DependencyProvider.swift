//
//  DependencyProvider.swift
//  weatherApp
//
//  Created by Safian Szabolcs on 2022. 01. 26..
//

import Swinject

class DependencyProvider {

    static let shared = DependencyProvider()

    private let container = Container()
    let assembler: Assembler

    private init() {
        assembler = Assembler(
            [
                NetworkAssembly(),
                ManagerAssembly(),
                ViewModelAssembly()
            ],
            container: container
        )
    }
}

