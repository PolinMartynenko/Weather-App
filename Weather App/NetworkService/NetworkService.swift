//
//  NetworkService.swift
//  Weather App
//
//  Created by Polina Martynenko on 01.09.2022.
//

import Foundation
import CoreLocation

protocol NetworkService {
    func loadCurrentWeather(coordinate: CLLocationCoordinate2D, completion: @escaping (WeatherResponse?) -> Void)
}


class NetworkServiceImplementation: NetworkService {
    
    func loadCurrentWeather(coordinate: CLLocationCoordinate2D, completion: @escaping (WeatherResponse?) -> Void) {
        
        guard let url = URL(string: "https://api.tomorrow.io/v4/timelines?location=\(coordinate.latitude),\(coordinate.longitude)&fields=temperature,humidity,windSpeed,sunsetTime,sunriseTime,cloudCover&timesteps=1h&units=metric&apikey=JzuMxgKxpVehpHfw78SRGDPB5cDoyAnN")else {
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
                    completion(weatherResponse)
                } catch {
                    print("Error2 \(error)")
                    completion(nil)
                }
                
            }
            
        }
        
        task.resume()
    }
    
    
}
