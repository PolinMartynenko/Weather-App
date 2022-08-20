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
    func onMapTouch(coordinates: CLLocationCoordinate2D)
}

protocol WeatherMapModelDelegate: AnyObject {
    func didUpdateLocations(location: CLLocationCoordinate2D)
    func errorAlert(title: String, message: String, url: URL?)
    func didLoadCurrentWeather(_ weather: Weather)
    func didLoadAllWeather(_ allWeather: [WeatherResponse.WeatherData.Timeline.Intervals])
    
    
}

class WeatherMapModelImplementation: NSObject, WeatherMapModel {
    
    var oldLocation: CLLocationCoordinate2D?
    
    func onMapTouch(coordinates: CLLocationCoordinate2D) {
        // 1 создание ссылки
        guard let url = URL(string: "https://api.tomorrow.io/v4/timelines?location=\(coordinates.latitude),\(coordinates.longitude)&fields=temperature,humidity,windSpeed,sunsetTime,sunriseTime,cloudCover&timesteps=1h&units=metric&apikey=JzuMxgKxpVehpHfw78SRGDPB5cDoyAnN")else {
            return
        }
        
        // 2 сооздание таска загрузки данных, который принимает url и клажуру, которая вызывается при ответе сервера
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error \(error)")
                return
            }
            // 3 декодим данные
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    // 4 проверка с помощью do catch - так как может быть ошибка от сервера, поэтому с помощую try можем сгенерировать ошибку.
                    let weatherResponse =  try decoder.decode(WeatherResponse.self, from: data)
                    // 5 избавление от опционала
                    if let weather = weatherResponse.data.timelines.first?.intervals.first?.values {
                        //6 перебрасывание данных на главный поток
                        DispatchQueue.main.async {
                            //7 передача данных во viewModel с помощью делегата
                            self.delegate?.didLoadCurrentWeather(weather)
                            
                        }
                    }
                    // 8 данные о timeline преобразовываем в массив с помощью метода flatMap
                    let intervals = weatherResponse.data.timelines.flatMap { timeline in
                        return timeline.intervals
                    }
                    // 9 передача данных на главный поток
                    DispatchQueue.main.async {
                            self.delegate?.didLoadAllWeather(intervals)
                        
                    }
                } catch {
                    print("Error2 \(error)")
                }
                
            }
            
        }
        
        // 10 запуск таска 
        task.resume()
        }
    
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
        if let location = locations.last?.coordinate, oldLocation != location {
            delegate?.didUpdateLocations(location: location)
            oldLocation = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorization()
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
