//
//  LoginController.swift
//  BagTracker
//
//  Created by Developer on 6/19/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {

    
    //Login Information
    @IBOutlet weak var emailTextField: LoginCustomTextFields!
    @IBOutlet weak var passwordTextField: LoginCustomTextFields!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var _email: UITextField!
    @IBOutlet weak var _password: UITextField!
    
    
    let loginViewModel = LoginViewModel()
    let loginDataManager = LoginDataManager()

    //unwinds the forgot password form back to the login
    @IBAction func forgotPasswordBackButton_Clicked(segue:UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
    
    @IBAction func login_Clicked(_ sender: Any) {
        
        guard let email = emailTextField.customTxtField.text, let password = passwordTextField.customTxtField.text else{
            print("Invalid Form")
            return
        }
        guard  loginViewModel.validateLoginValueWith(emailID: email, password: password) != nil else {
            loginViewModel.logInUserWith(userName: email, password: password, callBack:{
                
                if let errorMessage = self.loginViewModel.errorMessage{
                    //Displays the Error Message...
                    self.loginLabel.text = errorMessage
                }
                else
                {
                    print("logged in")
                    //Refresh App Window After SucessFull Login...
                    self.performSegue(withIdentifier: "loginSuccess", sender:self)
                }
            })
            return
        }
    }

}
