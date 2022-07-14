//
//  GoogleMapViewController.swift
//  SSRLabTest
//
//  Created by Иван Селюк on 15.07.22.
//

import UIKit
import GoogleMaps
import CoreLocation

class GoogleMapViewController: UIViewController {
    let mapView = GMSMapView()
    let centerView = UIView()
    let locationManager = CLLocationManager()
    private var model: JsonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allSetup()
        getPointOnTheMap()
    }
    
    private func allSetup() {
        setupUI()
        setupMapViewLayout()
        setupCenterViewLayout()
        setupManager()
    }
    
    private func setupUI() {
        view.addSubview(mapView)
        mapView.addSubview(centerView)
        centerView.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        centerView.backgroundColor = UIColor.red
        centerView.layer.cornerRadius = 5
        mapView.settings.zoomGestures = true
        mapView.settings.consumesGesturesInView = true
        mapView.settings.scrollGestures = true
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
    }
    
    private func setupMapViewLayout() {
        view.addConstraints([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupCenterViewLayout() {
        view.addConstraints([
            centerView.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: 0),
            centerView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor, constant: 0),
            centerView.heightAnchor.constraint(equalToConstant: 10),
            centerView.widthAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    private func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func getPointOnTheMap() {
        NetworkManager.shared.getData(onCompletion: { [weak self] modelData in
            self?.model = modelData
            guard let model = self?.model else {return}
            self?.showCurrentLocationOnMap(with: model)
        }, onError: { [weak self] error in
            guard let error = error else { return }
            self?.showAlert(with: error)
        })
    }
    
    private func showAlert(with messageError: String) {
        let alert = UIAlertController(title: "Error", message: messageError, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK!", style: .cancel, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func showCurrentLocationOnMap(with model: JsonModel){
        for data in model {
            let marker = GMSMarker()
            let location = CLLocationCoordinate2D(latitude: data.point.lat, longitude: data.point.lng)
            marker.position = location
            marker.snippet = data.pointName
            marker.map = mapView
        }
    }
}
