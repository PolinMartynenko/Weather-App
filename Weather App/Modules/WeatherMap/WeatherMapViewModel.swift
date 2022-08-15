//
//  WeatherMapViewController.swift
//  Weather App
//
//  Created by Polina Martynenko on 15.08.2022.
//

import Foundation
import CoreLocation

protocol WeatherMapViewModel {
    func onViewDidAppear()
    
}

protocol WeatherMapViewModelDelegate: AnyObject {
    func didUpdateLocations(location: CLLocationCoordinate2D)
}

class WeatherMapViewModelImplementattion: WeatherMapViewModel {
    private let model: WeatherMapModel
    weak var delegate : WeatherMapViewModelDelegate?
    
    init(model: WeatherMapModel) {
        self.model = model
    }
    
    func onViewDidAppear() {
        model.checkLocationEnable()
    }
    
}

extension WeatherMapViewModelImplementattion: WeatherMapModelDelegate {
    func didUpdateLocations(location: CLLocationCoordinate2D) {
        delegate?.didUpdateLocations(location: location)
    }
}
