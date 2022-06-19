//
//  MyWeatherViewModel.swift
//  Weather App
//
//  Created by Polina Martynenko on 19.06.2022.
//

import Foundation

protocol MyWeatherViewModel {
    func onViewDidLoad()
    
}

protocol MyWeatherViewModelDelegate{
    func setCirrentTemp(_ temp: Int)
}

class MyWeatherViewModelImplementattion : MyWeatherViewModel {
    var delegate : MyWeatherViewModelDelegate?
    
    func onViewDidLoad() {
        print("View did load")
        delegate?.setCirrentTemp(8)
    }
    
    
}
