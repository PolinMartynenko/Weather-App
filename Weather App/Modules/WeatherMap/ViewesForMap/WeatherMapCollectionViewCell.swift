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
        self.temperatureLabel.text = weather.values.temperature.toTemperature()
        self.dateLabel.text = weather.startTime.dateFormatter()
        }

    
    private func setupLabelStackView() {
        labelStackView.axis = .horizontal
        labelStackView.alignment = .leading
        labelStackView.spacing = 10
        contentView.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        
        setupDateLabel()
        setupTemperatureLabel()
    }
    
    private func setupDateLabel() {
        dateLabel.text = "ffo"
        dateLabel.numberOfLines = 0
        dateLabel.font = UIFont.monospacedSystemFont(ofSize: 25, weight: UIFont.Weight.medium)
        labelStackView.addArrangedSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
    }
    
    private func setupTemperatureLabel() {
        temperatureLabel.text = "kkk"
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 30)
        labelStackView.addArrangedSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}


extension String {
    func dateFormatter() -> String {
        let stringToDateFormatter = DateFormatter()
        stringToDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = stringToDateFormatter.date(from: self) {
            let dateToStringFormatter = DateFormatter()
            dateToStringFormatter.dateFormat = "EEE, hh a"
            return "\(dateToStringFormatter.string(from: date))"
        }
        return ""
    }
}
