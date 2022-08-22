//
//  WeatherMapCollectionViewCell.swift
//  Weather App
//
//  Created by Polina Martynenko on 20.08.2022.
//

import Foundation
import UIKit

class WeatherMapCollectioonViewCell : UICollectionViewCell {
    
    let labelStackView = UIStackView()
    let dateLabel = UILabel()
    let temperatureLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setupLabelStackView()
    } 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupCell(weather: WeatherResponse.WeatherData.Timeline.Intervals ) {
        self.temperatureLabel.text = "\(weather.values.temperature)"
        
        let stringToDateFormatter = DateFormatter()
        stringToDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = stringToDateFormatter.date(from: weather.startTime) {
            let dateToStringFormatter = DateFormatter()
            dateToStringFormatter.dateFormat = "EEE, hh a"
            
            self.dateLabel.text = "\(dateToStringFormatter.string(from: date))"
        }
    }
    
    private func setupLabelStackView() {
        labelStackView.axis = .vertical
        labelStackView.alignment = .leading
        labelStackView.spacing = 10
        contentView.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        setupDateLabel()
        setupTemperatureLabel()
    }
    
    private func setupDateLabel() {
        dateLabel.numberOfLines = 0
        dateLabel.backgroundColor = .purple
        labelStackView.addArrangedSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupTemperatureLabel() {
        temperatureLabel.backgroundColor = .yellow
        labelStackView.addArrangedSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureLabel.trailingAnchor.constraint(equalTo: labelStackView.trailingAnchor, constant: -2)
        ])
    }
}


