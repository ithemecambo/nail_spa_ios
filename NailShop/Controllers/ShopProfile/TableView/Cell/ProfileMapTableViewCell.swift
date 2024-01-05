//
//  ProfileMapTableViewCell.swift
//  NailShop
//
//  Created by SENGHORT KHEANG on 11/15/23.
//

import UIKit
import MapKit

class ProfileMapTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var mapView: MKMapView!
    private let locationManager = CLLocationManager()
    
    var profileData = ProfileDetailModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
        self.checkLocationServices()
        self.setupAnnotationOnMap(data: profileData)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension ProfileMapTableViewCell {
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        }
    }
    
    func checkLocationAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        switch authorizationStatus {
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
            case .denied: // Show alert telling users how to turn on permissions
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                mapView.showsUserLocation = true
            case .restricted:
                break
            case .authorizedAlways:
                break
            @unknown default:
                break
        }
    }
    
    func setupAnnotationOnMap(data: ProfileDetailModel) {
        mapView.mapType = .standard
        let location = CLLocationCoordinate2D(latitude: 11.361516, longitude: 76.30274)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = data.shopName
        annotation.subtitle = data.address
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }
}
