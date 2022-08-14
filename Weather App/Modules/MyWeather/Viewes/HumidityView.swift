//
//  humidityView.swift
//  Weather App
//
//  Created by Polina Martynenko on 14.08.2022.
//

import Foundation
import UIKit
import ALProgressView

class HumidityView : UIView {
    
    let humidityRing = ALProgressRing()
    let dropImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupHumidityRing()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHumidityRing(){
        humidityRing.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(humidityRing)
        NSLayoutConstraint.activate([
            humidityRing.heightAnchor.constraint(equalTo: self.heightAnchor),
            humidityRing.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        humidityRing.startColor = .cyan
        humidityRing.endColor = .blue
        setupDropImage()
    }
    
    private func setupDropImage(){
        dropImage.image = UIImage(named: "drop")
        dropImage.translatesAutoresizingMaskIntoConstraints = false
        humidityRing.addSubview(dropImage)
        NSLayoutConstraint.activate([
            dropImage.centerYAnchor.constraint(equalTo: humidityRing.centerYAnchor),
            dropImage.centerXAnchor.constraint(equalTo: humidityRing.centerXAnchor)
        ])
    }
}
