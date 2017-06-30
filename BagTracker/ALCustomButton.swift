//
//  ALCustomButton.swift
//  AubryLane
//
//  Created by day on 28/04/17.
//  Copyright © 2017 day. All rights reserved.
//

import UIKit

@IBDesignable class ALCustomButton: UIButton {
    
    @IBInspectable var cornerRadius : CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
