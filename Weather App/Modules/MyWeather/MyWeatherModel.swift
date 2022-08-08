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
    
    private let locationManager = CLLocationManager()
    override init() {
        super.init()
        
        locationManager.delegate = self
    }
    
    func loadCurrentWeather() {
        
        guard locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse else {
            locationManager.requestWhenInUseAuthorization()
            return
            
        }
        guard let currentLocation = locationManager.location else { return }
        
        guard let url = URL(string: "https://api.tomorrow.io/v4/timelines?location=\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)&fields=temperature,humidity,windSpeed,sunsetTime,sunriseTime&timesteps=1h&units=metric&apikey=JzuMxgKxpVehpHfw78SRGDPB5cDoyAnN") else {
                return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error \(error)")
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let weatherResponse =  try decoder.decode(WeatherResponse.self, from: data)
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
                } catch {
                    print("Error2 \(error)")
                }
                
            }
            
        }
        
        task.resume()
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
