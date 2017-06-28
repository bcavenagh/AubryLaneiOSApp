//
//  ALSharedInstance.swift
//  AubryLane
//
//  Created by Dhruv on 02/05/17.
//  Copyright © 2017 day. All rights reserved.
//

import UIKit

class ALGlobal: NSObject {
    
    static let sharedInstance = ALGlobal()
    
    var bagLists : [BagModel]?
    
    var isDeviceListExpanded = true
    
    var currentSelectedDeviceIndex = 0
    
    
    var getBagsCount : Int{
        get{
            if let bagsData = ALGlobal.sharedInstance.bagLists, bagsData.count > 0{
                return 1
            }
            return 0
        }
    }
    
    var isCurrentUserLoggedIn : Bool{
        get{
            print("isCurrentUserLoggedIn = \(UserDefaults.standard.bool(forKey: ALConstantsStrings.UserDefaultKeys.userLoggedInKey))")
            return UserDefaults.standard.bool(forKey: ALConstantsStrings.UserDefaultKeys.userLoggedInKey)
        }
    }
}
