//
//  ViewController.swift
//  Quest
//
//  Created by Andi Setiyadi on 1/11/19.
//  Copyright © 2019 devhubs. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MapView!
    @IBOutlet weak var controlView: UIView!
    
    private let locationService = LocationService()
    
    private lazy var locationAlert: UIAlertController = {
        let alertController = UIAlertController(title: "Location Authorization", message: "Quest can provide the points of interest based on your current location. To change the location permission please update your Privacy setting.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let settingAction = UIAlertAction(title: "Update Setting", style: .default, handler: { (_) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        
        alertController.addAction(okAction)
        alertController.addAction(settingAction)
        
        return alertController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationService.delegate = self
        
        controlView.layer.cornerRadius = 10.0
    }


    // MARK: - IBAction
    
    @IBAction func didTapUserLocation(_ sender: UIButton) {
        centerToUserLocation()
    }
    
    
    // MARK: - Private Function
    
    private func centerToUserLocation() {
        let mapRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        DispatchQueue.main.async { [weak self] in
            self?.mapView.setRegion(mapRegion, animated: true)
        }
    }
}


// MARK: LocationServiceDelegate

extension MapViewController: LocationServiceDelegate {
    func setMapRegion(center: CLLocation) {
        let mapRegion = MKCoordinateRegion(center: center.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        DispatchQueue.main.async { [weak self] in
            self?.mapView.setRegion(mapRegion, animated: true)
        }
    }
    
    func authorizationDenied() {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            
            weakSelf.present(weakSelf.locationAlert, animated: true, completion: nil)
        }
    }
    
    
}
