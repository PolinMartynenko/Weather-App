//
//  WeatherTableViewCell.swift
//  Weather App
//
//  Created by Polina Martynenko on 08.08.2022.
//

import Foundation
import UIKit

class WeatherTableViewCell : UITableViewCell{
    
    let labelStackView = UIStackView()
    let smileLabel = UILabel()
    let dateLabel = UILabel()
    let temperatureLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLableStackView()
        setUpTemperatureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(weather: WeatherResponse.WeatherData.Timeline.Intervals) {
        let answer = Int(weather.values.temperature.rounded())
        let plusTemperature = answer > 0
        let trueansw = "\(plusTemperature ? "+" : "-" )\(answer)°"
        self.temperatureLabel.text = trueansw
        
        let stringToDateFormatter = DateFormatter()
        stringToDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = stringToDateFormatter.date(from: weather.startTime) {
            let dateToStringFormatter = DateFormatter()
            dateToStringFormatter.dateFormat = "EEE, hh a"
            
            self.dateLabel.text = "\(dateToStringFormatter.string(from: date))"
        }
        
        let cloudCover = weather.values.cloudCover
        if cloudCover >= 96 {
            self.smileLabel.text = "🌧"
        } else if cloudCover > 80 {
            self.smileLabel.text = "☁️"
        } else if cloudCover > 40 {
            self.smileLabel.text = "🌤"
        } else {
            self.smileLabel.text = "☀️"
        }
    }
    
    private func setUpLableStackView() {
        labelStackView.axis = .horizontal
        labelStackView.alignment = .leading
        labelStackView.spacing = 10
        contentView.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        
        setUpDateLable()
        setUpSmileLable()
    }
    
    private func setUpTemperatureLabel() {
        temperatureLabel.font = UIFont.systemFont(ofSize: 30)
        contentView.addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setUpDateLable() {
        dateLabel.font = UIFont.monospacedSystemFont(ofSize: 20, weight: UIFont.Weight.medium)
        dateLabel.numberOfLines = 0
        labelStackView.addArrangedSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpSmileLable() {
        smileLabel.text = "🌈"
        smileLabel.numberOfLines = 0
        smileLabel.font = UIFont.boldSystemFont(ofSize: 30)
        labelStackView.addArrangedSubview(smileLabel)
        smileLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

