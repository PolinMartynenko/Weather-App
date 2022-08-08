//
//  MyWeatherViewModel.swift
//  Weather App
//
//  Created by Polina Martynenko on 19.06.2022.
//

import Foundation

protocol MyWeatherViewModel {
    func onViewDidLoad()
    var intervals: [WeatherResponse.WeatherData.Timeline.Intervals] {get}
}

protocol MyWeatherViewModelDelegate : AnyObject{
    func setCirrentTemp(_ temp: Double)
    func setCurrentCityName (_ city: String)
    func reloadTable()
}

class MyWeatherViewModelImplementattion : MyWeatherViewModel {
    var model: MyWeatherModel
   weak var delegate : MyWeatherViewModelDelegate?
    var intervals: [WeatherResponse.WeatherData.Timeline.Intervals] = []
    
    init(model:MyWeatherModel){
        self.model = model
    }
    
    func onViewDidLoad() {
        model.loadCurrentWeather()
        model.loadCurrentCityName()
    }
    
    
}
extension MyWeatherViewModelImplementattion: MyWeatherModelDelegate {
    func didLoadCurrentWeather(_ weather: Weather) {
        delegate?.setCirrentTemp(weather.temperature)
    }
    
    func didLoadAllWeather(_ allWeather: [WeatherResponse.WeatherData.Timeline.Intervals]) {
        intervals = allWeather
        delegate?.reloadTable()
        
    }
    
    func didLoadCurrentCityName(_ city: String) {
        delegate?.setCurrentCityName(city)
    }
    
    
}

//GET --url \
//'https://api.tomorrow.io/v4/timelines?location=-73.98529171943665,40.75872069597532&fields=temperature,humidity,windSpeed,sunsetTime,sunriseTime&timesteps=1h&units=metric&apikey=JzuMxgKxpVehpHfw78SRGDPB5cDoyAnN'
