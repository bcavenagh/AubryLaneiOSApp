//
//  SideButtonContactTableViewCell.swift
//  BagTracker
//
//  Created by Developer on 7/24/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit

class SideButtonContactTableViewCell: UITableViewCell {

    @IBOutlet weak var contactNumberLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    var selectContactAction: ((UITableViewCell) -> Void)?
    
    @IBAction func selectedContactPressed(_ sender: Any) {
        selectContactAction?(self)
    }


}
