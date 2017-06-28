//
//  ContactCell.swift
//  BagTracker
//
//  Created by Developer on 6/26/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import Foundation
import UIKit
class ContactCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    var tapTrashAction: ((UITableViewCell) -> Void)?
    var tapEditAction: ((UITableViewCell) -> Void)?
    
    @IBOutlet weak var trashContact: UIButton!
    @IBAction func trashClicked(_ sender: Any) {
        tapTrashAction?(self)
    }
    @IBOutlet weak var editContact: UIButton!
    @IBAction func editClicked(_ sender: Any) {
        tapEditAction?(self)
    }
}
