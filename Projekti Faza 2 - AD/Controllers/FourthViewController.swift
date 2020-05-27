//
//  FourthViewController.swift
//  Projekti Faza 2 - AD
//
//  Created by Cacttus Education 04 on 4/18/20.
//  Copyright © 2020 CacttusEducation. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FourthViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate, MKMapViewDelegate {

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var mapTextField: UITextField!
    var showMapRoute = false
    var route: MKRoute?
    var navigationStarted = false
    
     override func viewDidLoad() {
           super.viewDidLoad()
        
           checkLocationServices()
           mapView.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        mapTextField.resignFirstResponder()
    }
    
    @IBAction func mapButtonTapped(_ sender: Any) {
        guard let text = mapTextField.text else { return }
        showMapRoute = true
        mapTextField.endEditing(true)
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(text) { (placemarks, error)  in
            if error != nil {
               let alertController = UIAlertController(title:
                "Provoni nje lokacion tjeter", message:
                "Aktualisht nuk ka filiale ne kete qytet", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title:
                    "Cancel", style:
                              .default))
               self.present(alertController, animated: true, completion: nil)
                return
            }
            guard let placemarks = placemarks,
                let placemark = placemarks.first,
                let location = placemark.location
            else {return }
            let destinationCoordinate = location.coordinate
            self.mapRoute(destinationCoordinate: destinationCoordinate)
            
        }
    }
        
        func mapRoute(destinationCoordinate: CLLocationCoordinate2D) {
            guard let sourceCoordinate = locationManager.location?.coordinate else { return }
            
            let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
            let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
            
            let sourceItem = MKMapItem(placemark: sourcePlacemark)
            let destinationItem = MKMapItem(placemark: destinationPlacemark)
            
            let routeRequest = MKDirections.Request()
            routeRequest.source = sourceItem
            routeRequest.destination = destinationItem
            routeRequest.transportType = .automobile
            
            let directions = MKDirections(request: routeRequest)
            directions.calculate { (response, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
                guard let response = response, let route = response.routes.first else { return }
                
                self.route = route
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), animated: true)
            }
        }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = .systemBlue
        return renderer
        }
    
    
     func setupLocationManager() {
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
       }
       
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
        }
    }
    
       func checkLocationAuthorization() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
                centerViewOnUserLocation()
                locationManager.startUpdatingLocation()
                break
            case .denied:
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                break
            case .authorizedAlways:
                break
            @unknown default:
                break
            }
        }

     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: 100000, longitudinalMeters: 100000)
            mapView.setRegion(region, animated: true)
        }
        
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            checkLocationAuthorization()
        }
    }
