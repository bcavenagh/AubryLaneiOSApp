//
//  ControlsExtensions.swift
//  AubryLane
//
//  Created by day on 28/04/17.
//  Copyright © 2017 day. All rights reserved.
//

import UIKit

//class ControlsExtensions: NSObject {
//
//}



extension String{
    
    func isStringEmpty() -> Bool{
        let data = self as NSString
        return !(data.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).characters.count > 0)
    }
    
}



//extension UIButton{
//    
//    @IBInspectable var cornerRadius : CGFloat?{
//        get{
//            return self.layer.cornerRadius
//        }
//        set(newValue){
//            if let radius = cornerRadius{
//                self.layer.cornerRadius = radius
//                self.clipsToBounds = true
//            }
//        }
//    }
//}
