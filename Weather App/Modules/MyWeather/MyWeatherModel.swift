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
}

protocol MyWeatherModelDelegate: AnyObject {
    func didLoadCurrentWeather(_ weather: Weather)
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
                } catch {
                    print("Error2 \(error)")
                }
                
            }
        }
        
        task.resume()
    }

}

extension MyWeatherModelImplementation: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways :
            self.loadCurrentWeather()
        default:
            print("Permission error")
        }
    }
}
