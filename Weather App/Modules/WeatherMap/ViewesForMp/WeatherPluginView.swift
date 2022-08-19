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
    let informationStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupInformationStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupInformationStackView() {
        informationStackView.axis = .horizontal
        informationStackView.backgroundColor = .green
        informationStackView.spacing = 10
        informationStackView.alignment = .center
        informationStackView.distribution = .equalSpacing
        informationStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(informationStackView)
        NSLayoutConstraint.activate([
            informationStackView.topAnchor.constraint(equalTo: self.topAnchor,
                                                      constant: 10),
            informationStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                          constant: 10),
            informationStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor
                                                            , constant: -10)
            
        ])
        
        setUpInformationLabel()
    }
    
    private func setUpInformationLabel() {
        informationLabel.font = UIFont.boldSystemFont(ofSize: 25)
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        informationStackView.addArrangedSubview(informationLabel)
        NSLayoutConstraint.activate([
        ])
    }
    
    
}
