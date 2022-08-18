//
//  WeatherPluginView.swift
//  Weather App
//
//  Created by Polina Martynenko on 18.08.2022.
//

import Foundation
import UIKit

class WeatherPluginView: UIView {
    
    
    let informationLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setUpInformationLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpInformationLabel(){
        informationLabel.backgroundColor = .blue
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(informationLabel)
        NSLayoutConstraint.activate([
        ])
    }
    
    
}
