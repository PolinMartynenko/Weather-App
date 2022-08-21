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
    let emojiWeatherLabel = UILabel()
    let humidityRingOnMap = HumidityView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupInformationStackView()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupInformationStackView() {
        informationStackView.axis = .horizontal
        informationStackView.backgroundColor = .green
        informationStackView.spacing = 10
        informationStackView.layer.cornerRadius = 15
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
        setupEmojiWeatherView()
        setupHumidityView()
    }
    
    private func setUpInformationLabel() {
        informationLabel.font = UIFont.boldSystemFont(ofSize: 45)
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        informationStackView.addArrangedSubview(informationLabel)
        NSLayoutConstraint.activate([
        ])
    }
    
    private func setupEmojiWeatherView() {
        emojiWeatherLabel.font = UIFont.boldSystemFont(ofSize: 60)
        emojiWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        informationStackView.addArrangedSubview(emojiWeatherLabel)
    }

    private func setupHumidityView(){
        humidityRingOnMap.translatesAutoresizingMaskIntoConstraints = false
        informationStackView.addArrangedSubview(humidityRingOnMap)
        NSLayoutConstraint.activate([
            humidityRingOnMap.heightAnchor.constraint(equalToConstant: 70),
            humidityRingOnMap.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .brown
        collectionView.collectionViewLayout = layout
        collectionView.layer.cornerRadius = 10
        collectionView.register(WeatherMapCollectioonViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: informationStackView.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
}
