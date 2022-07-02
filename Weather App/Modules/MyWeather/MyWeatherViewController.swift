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
    let tableView = UITableView()
    
    let viewModel: MyWeatherViewModel
    
    init(viewModel: MyWeatherViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        self.title = "First"
        setUpStackView()
        
        viewModel.onViewDidLoad()
        
        
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
        SetUpDeteilStackView()
        setUpTableView()
        
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
    
    private func SetUpDeteilStackView(){
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
    
    private func setUpTableView(){
        stackView.addSubview(tableView)
        tableView.layer.cornerRadius = 15
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: segmenredControl.bottomAnchor, constant: 10),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
//        ])
    }
    
}

extension MyWeatherViewController: MyWeatherViewModelDelegate{
    func setCirrentTemp(_ temp: Double) {
        deteilsLable.text = "my weather is \(temp)"
    }
    func setCurrentCityName(_ city: String) {
        smileLable.text = " \(city)"
    }
}
