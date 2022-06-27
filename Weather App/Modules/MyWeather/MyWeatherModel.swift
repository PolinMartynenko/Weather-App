//
//  MyWheatherModel.swift
//  Weather App
//
//  Created by Polina Martynenko on 23.06.2022.
//

import Foundation

protocol MyWeatherModel {
    func loadCurrentWeather()
}

protocol MyWeatherModelDelegate: AnyObject {
    func didLoadCurrentWeather(_ weather: Weather)
}

class MyWeatherModelImplementation: MyWeatherModel {
    weak var delegate : MyWeatherModelDelegate?
    
    func loadCurrentWeather() {
        guard let url = URL(string: "https://api.tomorrow.io/v4/timelines?location=-73.98529171943665,40.75872069597532&fields=temperature,humidity,windSpeed,sunsetTime,sunriseTime&timesteps=1h&units=metric&apikey=JzuMxgKxpVehpHfw78SRGDPB5cDoyAnN") else {
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
