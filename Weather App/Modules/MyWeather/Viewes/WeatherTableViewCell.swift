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
        self.temperatureLabel.text = "\(weather.values.temperature)"
        let date = weather.startTime
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd.MM.yy HH:mm"
        self.dateLabel.text = "\(date)"
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
        contentView.addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setUpDateLable() {
        dateLabel.numberOfLines = 0
        labelStackView.addArrangedSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            dateLable.heightAnchor.constraint(equalTo: lableStackView.heightAnchor, constant: 10)
//        ])
    }
    
    private func setUpSmileLable() {
        smileLabel.text = "🌈"
        smileLabel.numberOfLines = 0
        smileLabel.font = UIFont.boldSystemFont(ofSize: 30)
        labelStackView.addArrangedSubview(smileLabel)
        smileLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            smileLable.heightAnchor.constraint(equalTo: lableStackView.heightAnchor, constant: 10)
//        ])
    }
    
}

