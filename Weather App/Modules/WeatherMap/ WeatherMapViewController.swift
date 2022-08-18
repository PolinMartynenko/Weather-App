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
    let locationManager = CLLocationManager()
    let informationLable = WeatherPluginView()

    
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
        setUpInformationLabel()
        
        let oLongTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTapGesture(gestureRecognizer:)))
        
        self.mapView.addGestureRecognizer(oLongTapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onViewDidAppear()
    }
    
    private func setUpInformationLabel(){
        informationLable.backgroundColor = .blue
        informationLable.layer.cornerRadius = 15
        informationLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(informationLable)
        NSLayoutConstraint.activate([
            informationLable.heightAnchor.constraint(equalToConstant: 150),
            informationLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 10),
            informationLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            informationLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
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
    func setCurrentTemp(_ temp: Double) {
       
    }
    
    func errorAlert(title: String, message: String, url: URL?) {
        showAlertLocation(title: title, message: message, url: url)
    }
    
    func didUpdateLocations(location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(region, animated: true)
    }

}
