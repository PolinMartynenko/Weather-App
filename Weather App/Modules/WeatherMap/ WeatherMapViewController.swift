//
//  File.swift
//  Weather App
//
//  Created by Polina Martynenko on 10.08.2022.
//

import Foundation
import UIKit
import MapKit

class WeatherMapViewController: UIViewController {
    
    let viewModel: WeatherMapViewModel
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onViewDidAppear()
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
    func didUpdateLocations(location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(region, animated: true)
    }
}
