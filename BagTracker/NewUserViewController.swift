//
//  NewUserViewController.swift
//  BagTracker
//
//  Created by Developer on 6/30/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit

class NewUserViewController: ViewController, UINavigationControllerDelegate {

    @IBOutlet weak var termsConditionLabel: UILabel!
    @IBOutlet weak var termsConditionCheckBox: UIButton!
    var acceptedTC: Bool = false
    
    @IBOutlet weak var userNameCustomView: LoginCustomTextFields!
    @IBOutlet weak var rePasswordCustomView: LoginCustomTextFields!
    @IBOutlet weak var passwordCustomView: LoginCustomTextFields!
    @IBOutlet weak var emailCustomView: LoginCustomTextFields!
    
    let registerUserViewModel = RegisterUserViewModel()
    @IBAction func tcBackButton_Clicked(segue:UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self
        
        termsConditionLabel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(NewUserViewController.handleTapOnLabel(tapGesture:))))
        
        self.assignKeyBoardShowHideBlock()
        
        // Do any additional setup after loading the view.
    }
    
    
    func assignKeyBoardShowHideBlock() {
        
        self.userNameCustomView.customTxtField.keyBoardShownWithFrame = {(frame, isShown) in
            ALConstantMethods.shiftKeyBoardFor(textFieldFrame: self.userNameCustomView.frame, keyboardHeight: frame, isKeyBoardShown: isShown, parentView : self.view)
        };
        
        self.emailCustomView.customTxtField.keyBoardShownWithFrame = {(frame, isShown) in
            ALConstantMethods.shiftKeyBoardFor(textFieldFrame: self.emailCustomView.frame, keyboardHeight: frame, isKeyBoardShown: isShown, parentView : self.view)
        };
        
        self.passwordCustomView.customTxtField.keyBoardShownWithFrame = {(frame, isShown) in
            ALConstantMethods.shiftKeyBoardFor(textFieldFrame: self.passwordCustomView.frame, keyboardHeight: frame, isKeyBoardShown: isShown, parentView : self.view)
        };
        
        self.rePasswordCustomView.customTxtField.keyBoardShownWithFrame = {(frame, isShown) in
            ALConstantMethods.shiftKeyBoardFor(textFieldFrame: self.rePasswordCustomView.frame, keyboardHeight: frame, isKeyBoardShown: isShown, parentView : self.view)
        };
    }
    
    
    @IBAction func registerButtonPressed(_ sender: ALCustomButton) {
        
        
        guard let errorMessage = registerUserViewModel.validateRegisterUserWith(userName: self.userNameCustomView.customTxtField.text, emailID: self.emailCustomView.customTxtField.text, password: self.passwordCustomView.customTxtField.text, rePassWord: self.rePasswordCustomView.customTxtField.text, acceptedTC: acceptedTC) else{
            
            //Make the Server Call...
            //ALConstantMethods.showProgressHUD(parentView: self.view)
            return
            
        }
        
        //Displays the Error Message...
        ALConstantMethods.showAlertWith(message: errorMessage, parentController: self, okButtonCallback: nil)
        
    }
    
    func handleTapOnLabel(tapGesture : UITapGestureRecognizer){
        self.performSegue(withIdentifier: "showTermsScreen", sender: self)
    }
    
    @IBAction func termsConditionCheckBoxButtonPressed(_ sender: UIButton) {
        toggleTermsAndConditions()
        //self.termsConditionCheckBox.isSelected = !self.termsConditionCheckBox.isSelected
    }
    
    func toggleTermsAndConditions(){
        if(termsConditionCheckBox.currentImage == #imageLiteral(resourceName: "uncheckedW")){
            termsConditionCheckBox.setImage(#imageLiteral(resourceName: "checkedW"), for: UIControlState.normal)
            acceptedTC = true
        }
        else{
            termsConditionCheckBox.setImage(#imageLiteral(resourceName: "uncheckedW"), for: UIControlState.normal)
            acceptedTC = false
        }
    }

}
