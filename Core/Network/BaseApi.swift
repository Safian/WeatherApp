//
//  BaseApi.swift
//  weatherApp
//
//  Created by Safian Szabolcs on 2022. 01. 26..
//

import Foundation
import Combine

public class BaseApi {

    let base = "http://api.openweathermap.org/data/2.5/weather"
    let session = URLSession.shared
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func build<T: Codable>(with request: URLRequest) -> AnyPublisher<T, Error> {
        return session.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
