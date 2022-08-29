//
//  File.swift
//  Weather App
//
//  Created by Polina Martynenko on 10.08.2022.
//

import Foundation
import UIKit
import MapKit

class WeatherMapViewController: UIViewController, UIGestureRecognizerDelegate {
    let viewModel: WeatherMapViewModel
    
    let mapView = MKMapView()
    let informationView = WeatherPluginView()
    var topConstraint = NSLayoutConstraint()
    
    
    init(viewModel: WeatherMapViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = "Map"
        self.tabBarItem.image = UIImage(named: "location")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setUpInformationView()
        informationView.collectionView.dataSource = self
        informationView.collectionView.delegate = self
        
        
        let oLongTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTapGesture(gestureRecognizer:)))
        
        self.mapView.addGestureRecognizer(oLongTapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onViewDidAppear()
    }
        
    private func setUpInformationView(){
        informationView.backgroundColor = .darkblueLabel
        informationView.layer.cornerRadius = 15
        informationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(informationView)
        let topConstraint = informationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: -300)
        self.topConstraint = topConstraint
        NSLayoutConstraint.activate([
            informationView.heightAnchor.constraint(equalToConstant: 150),
            informationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            informationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            topConstraint
        ])
    }
    
    @objc func handleLongTapGesture(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizer.State.ended {
            let touchLocation = gestureRecognizer.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            
            print("Tapped at latitude: \(locationCoordinate.latitude), longitude: \(locationCoordinate.longitude)")
            
            let pinOnMap = MKPointAnnotation()
            pinOnMap.coordinate = locationCoordinate
            
            pinOnMap.title = "Tapped at latitude: \(locationCoordinate.latitude), longitude: \(locationCoordinate.longitude)"
            
            let allAnnotations = self.mapView.annotations
            self.mapView.removeAnnotations(allAnnotations)
            
            mapView.addAnnotation(pinOnMap)
            
            viewModel.onMapTouch(coordinates: locationCoordinate)
        }
        
        
        if gestureRecognizer.state != UITapGestureRecognizer.State.began {
            return
        }
    }
    
    private func setupMapView() {
        mapView.showsUserLocation = true
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func showAlertLocation(title: String, message: String?, url: URL?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let settings = UIAlertAction(title: "Setting", style: .default) { (alert) in
           if let url = url {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(settings)
        alert.addAction(cancelAction)
        
        present(alert,animated: true, completion: nil)
    }
    
}


extension WeatherMapViewController: WeatherMapViewModelDelegate {
    func reloadCollectionView() {
        informationView.collectionView.reloadData()
        self.topConstraint.constant = 10
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func setCurrentWeather(weather: Weather) {
        self.informationView.informationLabel.text = weather.temperature.toTemperature()
        
        let weatherCondition = WeatherCondition(rawValue: Int(weather.cloudCover))
        informationView.emojiWeatherLabel.text = weatherCondition.emoji
        
        informationView.humidityRingOnMap.humidityRing.setProgress(Float(weather.humidity)/100, animated: true)
        
     
        
    }
    
    func errorAlert(title: String, message: String, url: URL?) {
        showAlertLocation(title: title, message: message, url: url)
    }
    
    func didUpdateLocations(location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000 )
        mapView.setRegion(region, animated: true)
    }

}

extension WeatherMapViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.intervals.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? WeatherMapCollectioonViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .lightBlueTabel
        let weather = viewModel.intervals[indexPath.row]
        cell.setupCell(weather: weather)
        
        return cell
    }
   
}

extension WeatherMapViewController: UICollectionViewDelegate {
    
}

extension WeatherMapViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
    
