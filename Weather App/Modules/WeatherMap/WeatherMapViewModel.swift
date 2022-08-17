//
//  WeatherMapViewController.swift
//  Weather App
//
//  Created by Polina Martynenko on 15.08.2022.
//

import Foundation
import CoreLocation
import UIKit

protocol WeatherMapViewModel {
    func onViewDidAppear()
    func onMapTouch(coordinates: CLLocationCoordinate2D)
}

protocol WeatherMapViewModelDelegate: AnyObject {
    func didUpdateLocations(location: CLLocationCoordinate2D)
    func errorAlert(title: String, message: String, url: URL?)
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
    
    func onMapTouch(coordinates: CLLocationCoordinate2D) {
        model.onMapTouch(coordinates: coordinates)
    }
    
}

extension WeatherMapViewModelImplementattion: WeatherMapModelDelegate {
    func errorAlert(title: String, message: String, url: URL?) {
        delegate?.errorAlert(title: "Your location is disabled", message: "Do you want turn on?", url: URL(string: UIApplication.openSettingsURLString))
    }
    
    func didUpdateLocations(location: CLLocationCoordinate2D) {
        delegate?.didUpdateLocations(location: location)
       
    }
}
