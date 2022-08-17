//
//  WeatherMapModel.swift
//  Weather App
//
//  Created by Polina Martynenko on 15.08.2022.
//

import Foundation
import CoreLocation
import UIKit

protocol WeatherMapModel {
  func checkLocationEnable()
}

protocol WeatherMapModelDelegate: AnyObject {
    func didUpdateLocations(location: CLLocationCoordinate2D)
    func errorAlert(title: String, message: String, url: URL?)
    
}

class WeatherMapModelImplementation: NSObject, WeatherMapModel {
    weak var delegate : WeatherMapModelDelegate?
    let locationManager = CLLocationManager()
    
    
    func checkLocationEnable() {
        if CLLocationManager.locationServicesEnabled() {
            setupManager()
            checkAuthorization()
        } else {
            delegate?.errorAlert(title: "Your location is disabled", message: "Do you want turn on?", url: URL(string: UIApplication.openSettingsURLString))
        }
    }
    
    func setupManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        case .denied:
            delegate?.errorAlert(title: "Your location is disabled", message: "Do you want turn on?", url: URL(string: UIApplication.openSettingsURLString))
            break
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
}

extension WeatherMapModelImplementation: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            delegate?.didUpdateLocations(location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorization()
    }
}
