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
        let viewModel = MyWeatherViewModelImplementattion()
        let vc = MyWeatherViewController(viewModel: viewModel)
        viewModel.delegate = vc
        return vc
    }
}
