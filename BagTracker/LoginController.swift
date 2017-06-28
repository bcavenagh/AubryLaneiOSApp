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
        guard let email = _email.text, let password = _password.text else{
            print("Invalid Form")
            return
        }
//        guard  loginViewModel.validateLoginValueWith(emailID: email, password: password) != nil else {
//            //Show Progess Bar...
//            loginViewModel.logInUserWith(userName: email, password: password, callBack:{
//                
//                //Hide Progess Bar...
//                if let errorMessage = self.loginViewModel.errorMessage{
//                    //Displays the Error Message...
//                    self.loginLabel.text = errorMessage
//                }
//                else
//                {
//                    print("logged in")
//                    //Refresh App Window After SucessFull Login...
//                    self.performSegue(withIdentifier: "loginSuccess", sender:self)
//                }
//            })
//            return
//        }
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion:{
         (user, error) in
            if error != nil{
                print(error!)
                self.loginLabel.text = "Invalid credentials. Try again."
                return
            }
            self.performSegue(withIdentifier: "loginSuccess", sender:self)
        })
    }

}
