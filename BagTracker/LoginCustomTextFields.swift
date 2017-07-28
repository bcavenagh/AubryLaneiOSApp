//
//  LoginCustomTextFields.swift
//  AubryLane
//
//  Created by day on 26/04/17.
//  Copyright © 2017 day. All rights reserved.
//

import UIKit

@IBDesignable class LoginCustomTextFields: UIView {

    @IBOutlet weak var textFieldIconImgView: UIImageView!
    @IBOutlet weak var customTxtField: ALCustomTextField!
    
    @IBInspectable var textFieldIconImage : UIImage?{
        didSet{
            self.textFieldIconImgView.image = textFieldIconImage
        }
    }
    
    @IBInspectable var textFieldPlaceHolder : String?{
        didSet{
            self.customTxtField.placeholder = textFieldPlaceHolder
            self.customTxtField.attributedPlaceholder = NSAttributedString(string: self.customTxtField.placeholder!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        }
    }
    
    //Keys for Setting The TextField Keyboard...
    //0 - Simple Keyboard like username
    //1 - Simple Keyboard like Email
    //2 - Simple Keyboard like Password
    @IBInspectable var textFieldKeyboardType : Int{
        get{
            return self.textFieldKeyboardType
        }
        set(newValue){
            switch newValue {
            case 1:
                self.customTxtField.keyboardType = .emailAddress
            case 2:
                self.customTxtField.isSecureTextEntry = true
            default:
                print(newValue)
            }
        }
    }    
    
    // Our custom view from the XIB file
    var view: UIView!
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LoginCustomTextFields", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
