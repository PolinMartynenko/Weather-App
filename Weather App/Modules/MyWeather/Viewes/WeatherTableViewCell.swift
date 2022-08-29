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
    let temperatureHotLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLableStackView()
        setUpTemperatureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(weather: WeatherResponse.WeatherData.Timeline.Intervals) {
        self.temperatureLabel.text = weather.values.temperature.toTemperature()
        self.dateLabel.text = weather.startTime.dateFormatter()
        
        let weatherCondition = WeatherCondition(rawValue: Int(weather.values.cloudCover))
        smileLabel.text = weatherCondition.emoji
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
    
    private func setuplettTemperatureHotLabel() {
        temperatureHotLabel.backgroundColor = .red
        
    }
    
    private func setUpSmileLable() {
        smileLabel.text = "🌈"
        smileLabel.numberOfLines = 0
        smileLabel.font = UIFont.boldSystemFont(ofSize: 30)
        labelStackView.addArrangedSubview(smileLabel)
        smileLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    }

