//
//  WeatherResponse.swift
//  Weather App
//
//  Created by Polina Martynenko on 24.06.2022.
//

import Foundation


struct WeatherResponse: Codable {
    struct WeatherData: Codable {
        struct Timeline: Codable {
            struct Intervals: Codable {
                let values: Weather
            }
            let intervals: [Intervals]
        }
        let timelines: [Timeline]
    }
    
    let data : WeatherData
    
}

struct Weather: Codable {
    let temperature: Double
}
