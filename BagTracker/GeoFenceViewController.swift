//
//  GeoFenceViewController.swift
//  BagTracker
//
//  Created by Developer on 7/21/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit
import MapKit
import MessageUI

class GeoFenceViewController: HomeViewController {
    
    @IBOutlet weak var addGeoFenceButton: UIButton!
    var buttonSetting = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGeoFenceButton.layer.cornerRadius = 0.5 * addGeoFenceButton.bounds.size.width
        if(geoFenceIsEnabled()){
            let radius = ALGlobal.sharedInstance.globalDefaults.double(forKey: "geoFenceSize")
            buttonSetting = 1
            toggleButton()
            drawGeoFence(radius: radius)
        }else{ 
            buttonSetting = 0
            toggleButton()
        }
    }

    @IBAction func mapChanged(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            userMapView.mapType = .standard
        default:
            userMapView.mapType = .satellite
        }
    }
    
    @IBAction func addGeoFencePushed(_ sender: Any) {
        if(!geoFenceIsEnabled()){
            let alertController = UIAlertController(title: nil, message: "How large would you like the geofence to be? (It must be larger than 330 feet)", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
                
                alertController.dismiss(animated: true, completion: nil)
                if let field = alertController.textFields?[0] {
                    // store your data
                    ALGlobal.sharedInstance.globalDefaults.set(field.text! as String, forKey: "geoFenceSize")
                    let rad = Double(field.text!)
                    ALGlobal.sharedInstance.geoFenceRadius = rad!
                    self.buttonSetting = 1
                    self.toggleButton()
                    self.drawGeoFence(radius: rad!)
                    self.turnOnFenceText(radius: Int(rad!))
                    
                } else {
                    // user did not fill field
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            
            alertController.addTextField { (textField) in
                textField.placeholder = "Feet"
                textField.keyboardType = .numberPad
            }
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else{
			self.removeGeoFence()
        }
    }
    
    func drawGeoFence(radius: Double){
        let bagList =  ALGlobal.sharedInstance.bagLists
        let bag = bagList?[0]
        let center = CLLocationCoordinate2D(latitude: CLLocationDegrees.init(bag!.latitude), longitude: CLLocationDegrees.init(bag!.longitude))
        let circle = MKCircle(center: center, radius: radius)
        
        userMapView.add(circle)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.fillColor = UIColor.blue.withAlphaComponent(0.1)
        circleRenderer.strokeColor = UIColor.blue
        circleRenderer.lineWidth = 1
        return circleRenderer
    }
    
    func geoFenceIsEnabled() -> Bool{
        return ALGlobal.sharedInstance.globalDefaults.object(forKey: "geoFenceSize") != nil
    }
    
    func toggleButton(){
        if(buttonSetting == 0){
            addGeoFenceButton.backgroundColor = UIColor(red: 100/255, green: 5/255, blue: 57/255, alpha: 1)
            addGeoFenceButton.setImage(#imageLiteral(resourceName: "Add"), for: UIControlState.normal)
        }else{
            addGeoFenceButton.backgroundColor = UIColor.red
            addGeoFenceButton.setImage(#imageLiteral(resourceName: "trashW"), for: UIControlState.normal)
        }
    }
    func removeGeoFence(){
        self.turnOffFenceText()
        ALGlobal.sharedInstance.globalDefaults.removeObject(forKey: "geoFenceSize")
        ALGlobal.sharedInstance.geoFenceRadius = 0
        self.buttonSetting = 0
        
        self.toggleButton()
        self.clearMap()
    }
    func clearMap(){
        let overlays = userMapView.overlays
        userMapView.removeOverlays(overlays)
    }
    
    func turnOnFenceText(radius: Int){
		let radiusConverted = Int(radius / 3)
		var request = URLRequest(url: URL(string: "http://48ec7d6a.ngrok.io/sms")!)
		request.httpMethod = "POST"
		let postString = "To=\(String(describing: (ALGlobal.sharedInstance.globalDefaults.object(forKey: "devicePhoneNumber") as? String)!))&From=13176444325&Body=G1,1,0,\(radiusConverted)M"
		print(postString)
		request.httpBody = postString.data(using: .utf8)
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data, error == nil else {
				// check for fundamental networking error
				print("error=\(String(describing: error))")
				return
			}
			
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
				// check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				print("response = \(String(describing: response))")
			}
			
			let responseString = String(data: data, encoding: .utf8)
			print("responseString = \(String(describing: responseString))")
		}
		task.resume()
        
    }
    
    func turnOffFenceText(){
		var request = URLRequest(url: URL(string: "http://48ec7d6a.ngrok.io/sms")!)
		request.httpMethod = "POST"
		let postString = "To=\(String(describing: (ALGlobal.sharedInstance.globalDefaults.object(forKey: "devicePhoneNumber") as? String)!))&From=13176444325&Body=G1,0"
		print(postString)
		request.httpBody = postString.data(using: .utf8)
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data, error == nil else {
				// check for fundamental networking error
				print("error=\(String(describing: error))")
				return
			}
			
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
				// check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				print("response = \(String(describing: response))")
			}
			
			let responseString = String(data: data, encoding: .utf8)
			print("responseString = \(String(describing: responseString))")
		}
		task.resume()
    }
	
    func showTextMessageWarning(){
        let alert = UIAlertController(title: "Important!", message: "You will be redirected to the Messages app shortly. Please do NOT edit the preset text message. Press the send button and the emergency contact will be added to your device.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ action in
            
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

