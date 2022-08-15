//
//  WeatherMapModel.swift
//  Weather App
//
//  Created by Polina Martynenko on 15.08.2022.
//

import Foundation
import CoreLocation

protocol WeatherMapModel {
  func checkLocationEnable()
}

protocol WeatherMapModelDelegate: AnyObject {
    func didUpdateLocations(location: CLLocationCoordinate2D)
    
}

class WeatherMapModelImplementation: NSObject, WeatherMapModel {
    weak var delegate : WeatherMapModelDelegate?
    let locationManager = CLLocationManager()
    
    func checkLocationEnable() {
        if CLLocationManager.locationServicesEnabled() {
            setupManager()
            checkAuthorization()
        } else {
//            showAlertLocation(title: "You have turn on geolocation service!", message: "Do you want to turn off?", url: URL(string: UIApplication.openSettingsURLString))
        }
    }
    
    func setupManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
//            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        case .denied:
//            showAlertLocation(title: "You have prohibited geolocation", message: "Do you want change it?", url: URL(string: UIApplication.openSettingsURLString))
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
