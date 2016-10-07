//
//  ShopMapViewController.swift
//  BookeeFinalExame
//
//  Created by ycliang on 2016/10/7.
//  Copyright © 2016年 Alex Liang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ShopMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
   
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    var address: String?
    var shopName: String?
    var isFirstLocation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        displayLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayLocation() {
        self.geoCoder.geocodeAddressString(self.address!) { (places:[CLPlacemark]?, err:NSError?) -> Void in
            if places?.count > 0 {
                let placeMark = places?.first
                let coordinate = placeMark!.location!.coordinate
                
                let region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500)
                self.mapView.region = region
                self.mapView.setRegion(region, animated: true)
                self.mapView.setCenterCoordinate(coordinate, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.title = self.shopName
                annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                self.mapView.addAnnotation(annotation)
            }
        }
        
        
    }
}

extension ShopMapViewController: MKMapViewDelegate {}
