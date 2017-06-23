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
