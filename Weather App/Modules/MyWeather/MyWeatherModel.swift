//
//  MyWheatherModel.swift
//  Weather App
//
//  Created by Polina Martynenko on 23.06.2022.
//

import Foundation
import CoreLocation

protocol MyWeatherModel {
    func loadCurrentWeather()
    func loadCurrentCityName()
}

protocol MyWeatherModelDelegate: AnyObject {
    func didLoadCurrentWeather(_ weather: Weather)
    func didLoadCurrentCityName(_ city: String)
    func didLoadAllWeather(_ allWeather: [WeatherResponse.WeatherData.Timeline.Intervals])
}

class MyWeatherModelImplementation: NSObject, MyWeatherModel {
    weak var delegate : MyWeatherModelDelegate?
    var networkService: NetworkService
    private let locationManager = CLLocationManager()
    
     init(service: NetworkService) {
        self.networkService = service
         super.init()
        
        
        locationManager.delegate = self
    }
    
    func loadCurrentWeather() {
        
        guard locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse else {
            locationManager.requestWhenInUseAuthorization()
            return
            
        }
        guard let currentLocation = locationManager.location else { return }
        networkService.loadCurrentWeather(coordinate: currentLocation.coordinate) { weatherResponse in
            guard let weatherResponse = weatherResponse else {
                return
            }
            if let weather = weatherResponse.data.timelines.first?.intervals.first?.values {
                DispatchQueue.main.async {
                    self.delegate?.didLoadCurrentWeather(weather)
                }
            }
            let intervals = weatherResponse.data.timelines.flatMap { timeline in
                return timeline.intervals
            }
            DispatchQueue.main.async {
                self.delegate?.didLoadAllWeather(intervals)
            }
        }
    }
    
    func loadCurrentCityName() {
        let geoCoder = CLGeocoder()
        
        guard locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse else {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        guard let currentLocation = locationManager.location else { return }
        

        geoCoder.reverseGeocodeLocation(currentLocation, completionHandler: { (placemarks, _) -> Void in

            placemarks?.forEach { (placemark) in

                if let city = placemark.locality {
                    print(city)
                    self.delegate?.didLoadCurrentCityName(city)
                }
            }
        })
    }
    
}

extension MyWeatherModelImplementation: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways :
            self.loadCurrentWeather()
            self.loadCurrentCityName()
        default:
            print("Permission error")
        }
    }
}
