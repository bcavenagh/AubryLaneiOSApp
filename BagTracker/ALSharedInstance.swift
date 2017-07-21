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
    let globalDefaults = UserDefaults()
    
    var bagLists : [BagModel]?
    
    var isDeviceListExpanded = true
    
    var currentSelectedDeviceIndex = 0
    
    var contactList = [Contact]()
    var devicePhoneNumber = ""
    var emergencyContactName = [String]()
    var emergencyContactNumber = [String]()
    
    var geoFenceRadius = 0.0
    
    func populateArrays(){
        emergencyContactName = []
        emergencyContactNumber = []
        if(ALGlobal.sharedInstance.globalDefaults.object(forKey: "emergencyContactName") != nil){
            let defaultContacts = ALGlobal.sharedInstance.globalDefaults.object(forKey: "emergencyContactName") as! [String]
            var i = 0
            while i < defaultContacts.count{
                let name = ALGlobal.sharedInstance.globalDefaults.array(forKey: "emergencyContactName") as! [String]
                let number = ALGlobal.sharedInstance.globalDefaults.array(forKey: "emergencyContactNumber") as! [String]
                let newContact = Contact()
                newContact.name = name[i]
                newContact.phone = number[i]
                emergencyContactName.append(newContact.name!)
                emergencyContactNumber.append(newContact.phone!)
                i += 1
            }
        }
    }
    
    func deviceNumberSet() -> Bool {
        return globalDefaults.object(forKey: "devicePhoneNumber") != nil
    }
    func contactsExist() -> Bool{
        return globalDefaults.object(forKey: "emergencyContactName") != nil   
    }
    
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
