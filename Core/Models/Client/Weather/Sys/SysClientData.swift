//
//  SysData.swift
//  weatherApp
//
//  Created by Safian Szabolcs on 2022. 01. 26..
//

import Foundation

struct SysClientData: Codable {
    let type: Int?
    let id: Int?
    let message: Float?
    let country: String
    let sunrise: Int
    let sunset: Int
}
