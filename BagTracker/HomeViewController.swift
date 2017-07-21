//
//  MapViewController.swift
//  BagTracker
//
//  Created by Developer on 6/30/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}

class HomeViewController: ViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    let homeViewModel = HomeViewModel()
    
    @IBOutlet weak var mapTypeSwitcher: UISegmentedControl!
    @IBOutlet weak var userMapView: MKMapView!
    let locationManager = CLLocationManager()
    var mapAnnotationsList = Dictionary<String, Any>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapTypeSwitcher.layer.cornerRadius = 4.0
        mapTypeSwitcher.backgroundColor = .white
        userMapView.delegate = self
        getBagList()
    }
    
    @IBAction func mapTypeChanged(_ sender: UISegmentedControl!) {
        switch (sender.selectedSegmentIndex) {
            case 0:
                userMapView.mapType = .standard
            default:
                userMapView.mapType = .satellite
        }
    }
    
    func getBagList(){
        //Show Progess Bar...
        //self.showProgressBar()
        self.homeViewModel.getBagListWith(parameter: nil, callBack: {
            //Hide Progess Bar...
            //self.hideProgressBar()
            if let errorMessage = self.homeViewModel.errorMessage{
                //Displays the Error Message...
                ALConstantMethods.showAlertWith(message: errorMessage, parentController: self, okButtonCallback: nil)
            }
            else
            {
                //Place the bag data on the map...
                self.locateBagsOnMap()
            }
        })
    }
    func locateBagsOnMap(){
        if let bagList =  ALGlobal.sharedInstance.bagLists{
            
            for bag in bagList{
                
                let annotation = CustomPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D.init(latitude: CLLocationDegrees.init(bag.latitude), longitude: CLLocationDegrees.init(bag.longitude))
                annotation.title = bag.carNumber
                annotation.imageName = "placeholder"
                self.userMapView.addAnnotation(annotation)
                self.mapAnnotationsList[String("\(bag.latitude)\(bag.longitude)")] = annotation
                
                let span = MKCoordinateSpanMake(0.02, 0.02)
                let region = MKCoordinateRegion(center: CLLocationCoordinate2D.init(latitude: CLLocationDegrees.init(bag.latitude), longitude: CLLocationDegrees.init(bag.longitude)), span: span)
                self.userMapView.setRegion(region, animated: true)
                
                ReverseGeoCodeDataManager.getReverseGeoCodeNameWith(referenceObject: bag , latitude : "\(bag.latitude)", longitude : "\(bag.longitude)", callBack: {[weak self](bag, formattedAddress , errorMesage) in
                    if let bagData = bag as? BagModel, let weakSelf = self, let annotation = weakSelf.mapAnnotationsList[String("\(bagData.latitude)\(bagData.longitude)")] as? MKPointAnnotation{
                        annotation.subtitle = formattedAddress
                        bagData.locationName = formattedAddress
                    }
                })
            }
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        let reuseAnnotationId = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseAnnotationId)
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseAnnotationId)
            annotationView?.canShowCallout = true
        }
        else
        {
            annotationView?.annotation = annotation
        }
        let customAnnotationView = annotation as! CustomPointAnnotation
        annotationView?.image = UIImage.init(named: customAnnotationView.imageName)
        return annotationView
    }

}
