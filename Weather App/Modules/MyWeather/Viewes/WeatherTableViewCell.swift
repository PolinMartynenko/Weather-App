//
//  WeatherTableViewCell.swift
//  Weather App
//
//  Created by Polina Martynenko on 08.08.2022.
//

import Foundation
import UIKit

class WeatherTableViewCell : UITableViewCell{
    
    let lableStackView = UIStackView()
    let smileLable = UILabel()
    let dateLable = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLableStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpLableStackView(){
        lableStackView.axis = .horizontal
        lableStackView.alignment = .leading
        lableStackView.spacing = 10
        contentView.addSubview(lableStackView)
        lableStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lableStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        
        setUpDateLable()
        setUpSmileLable()
    }
    
    private func setUpDateLable(){
        dateLable.numberOfLines = 0
        lableStackView.addArrangedSubview(dateLable)
        dateLable.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            dateLable.heightAnchor.constraint(equalTo: lableStackView.heightAnchor, constant: 10)
//        ])
    }
    
    private func setUpSmileLable(){
        smileLable.text = "🌈"
        smileLable.numberOfLines = 0
        smileLable.font = UIFont.boldSystemFont(ofSize: 17)
        lableStackView.addArrangedSubview(smileLable)
        smileLable.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            smileLable.heightAnchor.constraint(equalTo: lableStackView.heightAnchor, constant: 10)
//        ])
    }
    
}

