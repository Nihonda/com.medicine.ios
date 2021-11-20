//
//  MapViewModel.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 20/11/21.
//

import MapKit
import Combine

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 42.8834816, longitude: 74.5865216) // CLLocationCoordinate2D(latitude: 40.0575553, longitude: 70.788302)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
}

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    
    let dataService = Api.shared
    @Published var placeList = [DrugPlaceModel]()
    var cancellable: AnyCancellable?
    
    func checkIfLocationServicesEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.delegate = self
        } else {
            print("Show alert letting know it is off and to go to turn it on")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }

        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted due to some reason")
        case .denied:
            print("You denied user location. Go to Settings to allow it")
        case .authorizedAlways, .authorizedWhenInUse:
            guard let location = locationManager.location else { return }
            region = MKCoordinateRegion(center: location.coordinate, span: MapDetails.defaultSpan)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func downloadData(lat: Double, long: Double, dist: Double) {
        dataService.downloadDrugPlaceData(lat: lat, long: long, dist: dist)
        addSubscribers()
    }
    
    private func addSubscribers() {
        cancellable = dataService.$drugPlaceList
            .sink { [weak self] (returnedPlaceList) in
                guard let self = self else { return }
                self.placeList = returnedPlaceList
                self.cancellable?.cancel()
            }
    }
}
