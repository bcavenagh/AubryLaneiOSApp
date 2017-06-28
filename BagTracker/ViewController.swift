//
//  ViewController.swift
//  BagTracker
//
//  Created by Developer on 6/6/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit
import Firebase

class BagModel {
    
    var alarm : String?
    var bagID : String?
    var batteryStatus : NSNumber?
    var carNumber : String?
    var bagDirection : NSNumber?
    var gpsTime : NSDate?
    var input : String?
    var isOnline : NSNumber?
    var latitude : CGFloat
    var longitude : CGFloat
    var machineNumber : NSNumber?
    var mileage : NSNumber?
    var simNumber : NSNumber?
    var speed : NSNumber?
    var locationName : String = ""
    
    init(bagData : NSDictionary) {
        alarm = bagData.value(forKey: "alarm") as? String ?? ""
        bagID = bagData.value(forKey: "bagId") as? String ?? ""
        batteryStatus = bagData.value(forKey: "batterystatus") as? NSNumber ?? NSNumber.init(value: 0)
        carNumber = bagData.value(forKey: "carNO") as? String ?? ""
        bagDirection = bagData.value(forKey: "direction") as? NSNumber ?? NSNumber.init(value: 0)
        gpsTime = bagData.value(forKey: "gpsTime") as? NSDate ?? nil
        input = bagData.value(forKey: "input4") as? String ?? ""
        isOnline = bagData.value(forKey: "isonline") as? NSNumber ?? NSNumber.init(value: 0)
        latitude = bagData.value(forKey: "la") as? CGFloat ?? CGFloat.init(0.0)
        longitude = bagData.value(forKey: "lo") as? CGFloat ?? CGFloat.init(0.0)
        machineNumber = bagData.value(forKey: "machineNO") as? NSNumber ?? NSNumber.init(value: 0)
        mileage = bagData.value(forKey: "mileage") as? NSNumber ?? NSNumber.init(value: 0.0)
        simNumber = bagData.value(forKey: "simNO") as? NSNumber ?? NSNumber.init(value: 0)
        speed = bagData.value(forKey: "speed") as? NSNumber ?? NSNumber.init(value: 0)
        
    }
    
    
    //    func getUserLocationName(callBack : @escaping ((Void) -> (Void))){
    //        let geoCoder = CLGeocoder()
    //        geoCoder.reverseGeocodeLocation(CLLocation.init(latitude: CLLocationDegrees.init(self.latitude), longitude: CLLocationDegrees.init(self.longitude)), completionHandler: {(placeMark, error) in
    //            if let firstPlaceMark = placeMark?.first{
    //                self.locationName = "\(firstPlaceMark.name ?? "") \(firstPlaceMark.subThoroughfare ?? "") \(firstPlaceMark.locality ?? "") \(firstPlaceMark.administrativeArea ?? "") \(firstPlaceMark.subAdministrativeArea ?? "") \(firstPlaceMark.isoCountryCode ?? "")"
    //                callBack()
    //            }
    //        })
    //    }
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var MenuButton: UIBarButtonItem!
    @IBOutlet weak var OptionalButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        customizeNavBar()
        checkIfUserLoggedIn()
    }

    func checkIfUserLoggedIn(){
        let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "loginView")
        if FIRAuth.auth()?.currentUser?.uid == nil{
            present(vc as! UIViewController, animated: true, completion: nil)
        }
    }
    
    
    func sideMenus() {
        if revealViewController() != nil{
            
            //Create menu button
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: .plain, target: revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))

            //Choose how far the view slides to reveal the left menu
            revealViewController().rearViewRevealWidth = 275
            //Choose how far the view slides to reveal the right menu
            revealViewController().rightViewRevealWidth = 160
            
            //Create purse button
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Purse"), style: .plain, target: revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)))

            //Allow a swipe gesture to open the menu
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func customizeNavBar(){
        //Change the color of the images red: 209/255, green: 151/255, blue: 72/255, alpha: 1
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor(red: 209/255, green: 151/255, blue: 72/255, alpha: 1)
        //Change the color of the top main bar
        navigationController?.navigationBar.barTintColor = UIColor(red: 100/255, green: 5/255, blue: 57/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
    }
    
}
