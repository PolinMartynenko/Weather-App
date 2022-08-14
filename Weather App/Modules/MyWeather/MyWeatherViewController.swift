//
//  ViewController.swift
//  Weather App
//
//  Created by Polina Martynenko on 14.06.2022.
//

import UIKit
import ALProgressView

class MyWeatherViewController: UIViewController {
    
    let stackView = UIStackView()
    let cityLabel = UILabel()
    let stackInStack = UIStackView()
    let temperatureLabel = UILabel()
    let tableView = UITableView()
    let smileCloudCover = UILabel()
    let windSpeedLabel = UILabel()
    let humidityView = HumidityView()
   
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
        setupCityLabel()
        setupTemperatureLabel()
        setUpDetailStackView()
    }
    
    private func setupCityLabel(){
        cityLabel.font = UIFont.boldSystemFont(ofSize: 30)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setupTemperatureLabel(){
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 55)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setUpDetailStackView(){
        stackInStack.axis = .horizontal
        stackInStack.backgroundColor = .green
        stackInStack.spacing = 10
        stackInStack.alignment = .center
        stackInStack.distribution = .equalSpacing
        stackInStack.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(stackInStack)
        
        setUpSmileCloudCover()
        setUpWindSpeedLabel()
        setupHumidityView()
    }
    
    private func setUpSmileCloudCover() {
        smileCloudCover.text = "💩"
        smileCloudCover.font = UIFont.boldSystemFont(ofSize: 60)
        smileCloudCover.translatesAutoresizingMaskIntoConstraints = false
        stackInStack.addArrangedSubview(smileCloudCover)
    }
    
    private func setUpWindSpeedLabel(){
        windSpeedLabel.text = "124"
        windSpeedLabel.font = UIFont.boldSystemFont(ofSize: 25)
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        stackInStack.addArrangedSubview(windSpeedLabel)
    }
    
    private func setupHumidityView(){
        humidityView.translatesAutoresizingMaskIntoConstraints = false
        stackInStack.addArrangedSubview(humidityView)
        NSLayoutConstraint.activate([
            humidityView.heightAnchor.constraint(equalToConstant: 70),
            humidityView.widthAnchor.constraint(equalToConstant: 70)
        ])
    }

    private func setUpTableView(){
        tableView.dataSource = self
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "cell" )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 15
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
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
        temperatureLabel.text = "\(Int(temp.rounded()))"
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func setCurrentCityName(_ city: String) {
        cityLabel.text = " \(city)"
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
    
    func setCurrentHumidity(_ humidity: Double) {
        humidityView.humidityRing.setProgress(Float(humidity)/100, animated: true)
    }
    
}
