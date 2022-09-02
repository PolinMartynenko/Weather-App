//
//  MyWeatherModule.swift
//  Weather App
//
//  Created by Polina Martynenko on 19.06.2022.
//

import Foundation
import UIKit

struct MyWeatherModule {
    static func build() -> UIViewController {
        let setvice = NetworkServiceImplementation()
        let model = MyWeatherModelImplementation(service: setvice)
        let viewModel = MyWeatherViewModelImplementattion(model: model)
        
        let vc = MyWeatherViewController(viewModel: viewModel)
        viewModel.delegate = vc
        model.delegate = viewModel
        return vc
    }
}
