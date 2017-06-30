//
//  ALCustomTextField.swift
//  AubryLane
//
//  Created by day on 26/04/17.
//  Copyright © 2017 day. All rights reserved.
//

import UIKit

class ALCustomTextField: UITextField, UITextFieldDelegate {
    
    var keyBoardShownWithFrame :((CGFloat, Bool) -> (Void))?
    
    
    // MARK: - UITextField LifeCycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(ALCustomTextField.keyboardWillShow(notification:)) , name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ALCustomTextField.keyboardWillHide) , name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - KeyBoard Notification Methods
    
    func keyboardWillShow(notification:NSNotification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardHeight = keyboardFrame.cgRectValue.height
        if let keyBoardShown = self.keyBoardShownWithFrame{
            keyBoardShown(keyboardHeight, true)
        }
    }
    
    func keyboardWillHide(){
        if let keyBoardShown = self.keyBoardShownWithFrame{
            keyBoardShown(CGFloat(0), false)
        }
    }
    
    
    // MARK: - UITextField Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
