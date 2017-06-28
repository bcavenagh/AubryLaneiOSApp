//
//  UserProfileTableViewCell.swift
//  AubryLane
//
//  Created by Dhruv on 02/05/17.
//  Copyright © 2017 day. All rights reserved.
//

import UIKit

class UserProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userProfileImgView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    
    var profileEditBtnPressedCallBack : ((Void) -> (Void))?
    
    @IBAction func editProfileBtnPressed(_ sender: UIButton) {
        if let callBack = self.profileEditBtnPressedCallBack{
            callBack()
        }
    }
    
    func setUserProfileDataWith(name : String, profileURL : String?) {
        self.userNameLbl.text = name
        self.userProfileImgView.image = UIImage.init(named: "profile_image")
        let when = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.userProfileImgView.layer.cornerRadius =  self.userProfileImgView.frame.size.width / 2
            self.userProfileImgView.layer.borderColor = UIColor.lightGray.cgColor
            self.userProfileImgView.layer.masksToBounds = true
            self.userProfileImgView.layer.borderWidth = 0.5
            self.userProfileImgView.clipsToBounds = true
            // Your code with delay
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
