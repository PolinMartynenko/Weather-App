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
    let detailsLable = UILabel()
    let tableView = UITableView()
    let smileCloudCover = UILabel()
    let windSpeedLabel = UILabel()

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
        setUpWindSpeedLabel()
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
        setUpDetailStackView()
        setUpSmileCloudCover()
    }
    
    private func setUpLable(){
        listLabel.font = UIFont.boldSystemFont(ofSize: 30)
        stackView.addArrangedSubview(listLabel)
        listLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setUpSmileCloudCover() {
        smileCloudCover.text = "💩"
        smileCloudCover.numberOfLines = 0
        smileCloudCover.font = UIFont.boldSystemFont(ofSize: 100)
        stackView.addArrangedSubview(smileCloudCover)
        smileCloudCover.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setUpDetailStackView(){
        stackInStack.axis = .horizontal
        stackInStack.backgroundColor = .green
        stackInStack.spacing = 10
        stackInStack.distribution = .fill
        stackView.addArrangedSubview(stackInStack)
        stackInStack.translatesAutoresizingMaskIntoConstraints = false
        
        setUpLableDetails()
    }
    
    private func setUpWindSpeedLabel(){
        windSpeedLabel.text = "Wind speed"
        windSpeedLabel.font = UIFont.boldSystemFont(ofSize: 25)
        view.addSubview(windSpeedLabel)
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            windSpeedLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10 ),
//            windSpeedLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor)
        ])
    }
    
    private func setUpLableDetails(){
        detailsLable.font = UIFont.boldSystemFont(ofSize: 45)
        stackInStack.addArrangedSubview(detailsLable)
        detailsLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        detailsLable.heightAnchor.constraint(equalToConstant: 50)
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
    func setCurrentTemp(_ temp: Double) {
        detailsLable.text = "\(Int(temp.rounded()))"
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func setCurrentCityName(_ city: String) {
        listLabel.text = " \(city)"
    }
    
    func setSmileCurrentWeather(_ cloudCover: Double) {
        if cloudCover >= 96 {
            self.smileCloudCover.text = "🌧"
        } else if cloudCover > 80 {
            self.smileCloudCover.text = "☁️"
        } else if cloudCover > 40 {
            self.smileCloudCover.text = "🌤"
        } else {
            self.smileCloudCover.text = "☀️"
        }
    }
    
}
