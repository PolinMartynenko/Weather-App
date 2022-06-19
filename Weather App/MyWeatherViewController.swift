//
//  ViewController.swift
//  Weather App
//
//  Created by Polina Martynenko on 14.06.2022.
//

import UIKit


class MyWeatherViewController: UIViewController {
    
    let stackView = UIStackView()
    let listLabel = UILabel()
    let stackInStack = UIStackView()
    let deteilsLable = UILabel()
    let smileLable = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        self.title = "First"
        setUpStackView()
        
    }
    
    private func setUpStackView(){
        stackView.axis = .vertical
        stackView.backgroundColor = .yellow
        stackView.spacing = 10
        stackView.alignment = .center
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
           
            
        ])
        setUpLable()
        deteilStackView()
        
    }
    
    private func setUpLable(){
//        listLabel.text = entry.text
        listLabel.text = "kjkjj"
        listLabel.numberOfLines = 0
        listLabel.font = UIFont.boldSystemFont(ofSize: 17)
        stackView.addArrangedSubview(listLabel)
        listLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        listLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func deteilStackView(){
        stackInStack.axis = .horizontal
        stackInStack.backgroundColor = .green
        stackInStack.spacing = 10
//        stackInStack.alignment = .center
        stackInStack.distribution = .fill
        stackView.addArrangedSubview(stackInStack)
        stackInStack.translatesAutoresizingMaskIntoConstraints = false
        
        setUpLableDatails()
        setUpSmileLable()
    }
    
    private func setUpLableDatails(){
        deteilsLable.text = "iiiiooo"
        deteilsLable.numberOfLines = 0
        deteilsLable.font = UIFont.boldSystemFont(ofSize: 17)
        stackInStack.addArrangedSubview(deteilsLable)
        deteilsLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        deteilsLable.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setUpSmileLable(){
        smileLable.text = "💖"
        smileLable.numberOfLines = 0
        smileLable.font = UIFont.boldSystemFont(ofSize: 17)
        stackInStack.addArrangedSubview(smileLable)
        smileLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        smileLable.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    

}
