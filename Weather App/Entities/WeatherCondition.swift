//
//  WeatherCondition.swift
//  Weather App
//
//  Created by Polina Martynenko on 28.08.2022.
//

import Foundation

enum WeatherCondition: Int {
    case rainy
    case cloudly
    case partlyCloudly
    case sunny
    
    init(rawValue: Int) {
        if rawValue >= 96 {
            self = .rainy
        } else if rawValue > 80 {
            self = .cloudly
        } else if rawValue > 40 {
            self = .partlyCloudly
        } else {
            self = .sunny
        }
    }
    
    var emoji: String {
        switch self {
        case .rainy :
            return "🌧"
        case .cloudly :
            return "☁️"
        case .partlyCloudly :
            return "🌤"
        case .sunny :
            return "☀️"
        }
    }
}
