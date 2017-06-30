//
//  HomeViewModel.swift
//  AubryLane
//
//  Created by Dhruv on 08/05/17.
//  Copyright © 2017 day. All rights reserved.
//

import UIKit
import CoreLocation

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


class HomeViewModel: NSObject {
    
    //var bagsList : [BagModel]?
    var errorMessage : String?
    
    func getBagListWith(parameter : String?, callBack :@escaping ((Void) -> (Void))){
        
        BaseDataManager.makeGetRequestWith(URL: ALDataManager.getBagsListAPIURL(), parameters: nil, callBack: {(data, error ) in
            
            ALGlobal.sharedInstance.bagLists?.removeAll()
            self.errorMessage = nil
            
            if let reterievedError = error {
                self.errorMessage = reterievedError.errorMessage
                callBack()
            }
            else{
                ALGlobal.sharedInstance.bagLists?.removeAll()
                
                if let reterievedData = data, let status = reterievedData["status"] as? NSNumber, status.intValue == 1, let bagsList = reterievedData["bags"] as? NSArray{
                    if ALGlobal.sharedInstance.bagLists == nil{
                        ALGlobal.sharedInstance.bagLists = [BagModel]()
                    }
                    for data in bagsList{
                        ALGlobal.sharedInstance.bagLists?.append(BagModel.init(bagData: data as! NSDictionary))
                    }
                    callBack()
                }
                else if let reterievedData = data, let _ = reterievedData["error"] as? String, let errorDescription = reterievedData["error_description"] as? String{
                    self.errorMessage = errorDescription
                    callBack()
                }
            }
        })
    }
}
