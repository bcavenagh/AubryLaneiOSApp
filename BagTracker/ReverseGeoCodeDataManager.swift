//
//  ReverseGeoCodeDataManager.swift
//  AubryLane
//
//  Created by Dhruv on 09/05/17.
//  Copyright © 2017 day. All rights reserved.
//

import UIKit

class ReverseGeoCodeDataManager: NSObject {
    
    class func getReverseGeoCodeNameWith(referenceObject : Any, latitude : String, longitude : String, callBack : @escaping ((Any, String, String?) -> ())){
        
        let urlString = "http://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&sensor=false"
        
        BaseDataManager.makeSimpleGetRequestWith(URL: NSURL.init(string: urlString)! as URL, parameters: nil, callBack:{(data : NSDictionary?, error) in
            
            if let reterievedData = data, let status = reterievedData.value(forKey: "status") as? String, status == "OK", let resultsData = reterievedData.value(forKey: "results") as? NSArray, resultsData.count > 0, let addressData = resultsData[0] as? NSDictionary, let formattedAddress = addressData.value(forKey: "formatted_address") as? String{
                print(formattedAddress)
                callBack(referenceObject, formattedAddress, nil)
            }
            else
            {
                callBack(referenceObject, "", nil)
            }
        })
        
    }
}
