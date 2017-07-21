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
    var latitude = 39.909319
    var longitude = -86.251950
    var zoom : Float! = 50
    var bag = ALGlobal.sharedInstance.bagLists?[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        mapView.isMyLocationEnabled = true
//        self.view = mapView
//        
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
//        marker.title = "Aubry Lane"
//        marker.snippet = "Handbags"
//        marker.map = mapView
    }
    func reloadMap(){
        NSLog("Latitude %f", latitude)
        NSLog("Longitude %f", longitude)
        NSLog("Zoom %f", zoom)
        
    }
    
}
