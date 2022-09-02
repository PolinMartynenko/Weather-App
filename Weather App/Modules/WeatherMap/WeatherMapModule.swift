//
//  WeatherMapModule.swift
//  Weather App
//
//  Created by Polina Martynenko on 15.08.2022.
//

import Foundation
import UIKit

struct WeatherMapModule {
    static func build() -> UIViewController {
        let service = NetworkServiceImplementation()
        let model = WeatherMapModelImplementation(service: service)
        let viewModel = WeatherMapViewModelImplementattion(model: model)
        
        let vc = WeatherMapViewController(viewModel: viewModel)
        viewModel.delegate = vc
        model.delegate = viewModel
        return vc
    }
    
}
