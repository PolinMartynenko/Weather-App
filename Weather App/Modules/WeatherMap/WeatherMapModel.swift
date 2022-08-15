//
//  WeatherMapModel.swift
//  Weather App
//
//  Created by Polina Martynenko on 15.08.2022.
//

import Foundation

protocol WeatherMapModel {
  
}

protocol WeatherMapModelDelegate: AnyObject {
    
}

class WeatherMapModelImplementation: NSObject, WeatherMapModel {
    weak var delegate : WeatherMapModelDelegate?
    
}

