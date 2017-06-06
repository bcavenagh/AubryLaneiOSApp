//
//  MapController.swift
//  BagTracker
//
//  Created by Developer on 6/6/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import Foundation
import GoogleMaps
import UIKit

class MapController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let camera = GMSCameraPosition.camera(withLatitude: 39.909319, longitude: -86.251950, zoom: 17)
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(39.909319, -86.251950)
        marker.title = "Aubry Lane"
        marker.snippet = "Handbags"
        marker.map = mapView
    }
}
