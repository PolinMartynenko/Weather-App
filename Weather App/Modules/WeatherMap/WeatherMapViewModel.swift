//
//  WeatherMapViewController.swift
//  Weather App
//
//  Created by Polina Martynenko on 15.08.2022.
//

import Foundation

protocol WeatherMapViewModel {
    func onViewDidLoad()
    
}

protocol WeatherMapViewModelDelegate: AnyObject {
    
}

class WeatherMapViewModelImplementattion: WeatherMapViewModel {
    private let model: WeatherMapModel
    weak var delegate : WeatherMapViewModelDelegate?
    
    init(model: WeatherMapModel) {
        self.model = model
    }
    
    func onViewDidLoad() {
        
    }
}

extension WeatherMapViewModelImplementattion: WeatherMapModelDelegate {
    
}
