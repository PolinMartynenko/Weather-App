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
    let tableView = UITableView()

    let viewModel: MyWeatherViewModel
    
    init(viewModel: MyWeatherViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = "Weather"
        self.tabBarItem.image = UIImage(named: "weather")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUpStackView()
        setUpTableView()
        
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
    }
    
    private func setUpLable(){
        listLabel.font = UIFont.boldSystemFont(ofSize: 30)
        stackView.addArrangedSubview(listLabel)
        listLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listLabel.heightAnchor.constraint(equalToConstant: 35)
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
    }
    
    private func setUpLableDatails(){
        deteilsLable.font = UIFont.boldSystemFont(ofSize: 45)
        stackInStack.addArrangedSubview(deteilsLable)
        deteilsLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        deteilsLable.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setUpTableView(){
        tableView.dataSource = self
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "cell" )
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 15
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 150),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
        ])
    }
    
    
}

extension MyWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.intervals.count
    }
    
    // создание ячеек таблицы(источник данных)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        let weather = viewModel.intervals[indexPath.row]
        cell.setupCell(weather: weather)
        return cell
    }
}


extension MyWeatherViewController: MyWeatherViewModelDelegate{
    func setCirrentTemp(_ temp: Double) {
        deteilsLable.text = "\(temp)"
    }
    
    func reloadTable() {
        
        tableView.reloadData()
    }
    
    func setCurrentCityName(_ city: String) {
        listLabel.text = " \(city)"
    }
}
