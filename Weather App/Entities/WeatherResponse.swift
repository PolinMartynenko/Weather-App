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
            let timestep: String
            let endTime: String
            let startTime: String
            
        }
        let timelines: [Timeline]
    }
    
    let data : WeatherData
    
}

struct Weather: Codable {
    let temperature: Double
    let humidity: Double
    let sunriseTime: String
    let sunsetTime: String
    let windSpeed: Double
}
