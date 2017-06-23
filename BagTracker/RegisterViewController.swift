//
//  RegisterViewController.swift
//  BagTracker
//
//  Created by Developer on 6/12/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    //Register Information
    @IBOutlet weak var createAccount: UIButton!
    @IBOutlet weak var acceptTCBox: UIButton!
    @IBOutlet weak var _registerEmail: UITextField!
    @IBOutlet weak var _registerFirstName: UITextField!
    @IBOutlet weak var _registerLastName: UITextField!
    @IBOutlet weak var _registerPassword: UITextField!
    @IBOutlet weak var _registerPasswordConfirm: UITextField!
    var acceptedTC: Bool = false
    
    //unwinds the register form back to the login
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func toggleTermsAndConditions(){
        if(acceptTCBox.currentImage == #imageLiteral(resourceName: "unchecked")){
            acceptTCBox.setImage(#imageLiteral(resourceName: "checked"), for: UIControlState.normal)
            acceptedTC = true
        }
        else{
            acceptTCBox.setImage(#imageLiteral(resourceName: "unchecked"), for: UIControlState.normal)
            acceptedTC = false
        }
    }
    
    @IBAction func acceptTCBox_Clicked(_ sender: Any) {
        toggleTermsAndConditions()
    }
    
    @IBAction func acceptTCText_Clicked(_ sender: Any) {
        toggleTermsAndConditions()
    }
    func verifyPassword()-> Bool{
        let psw = _registerPassword.text
        let confirm = _registerPasswordConfirm.text
        if(psw == confirm){
            return true
        }
        return false
    }
    @IBAction func createAccount_Clicked(_ sender: Any) {
        guard let email = _registerEmail.text, let password = _registerPassword.text, let firstName = _registerFirstName.text, let lastName = _registerLastName.text else{
            return
        }
        if(verifyPassword() && acceptedTC == true){
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {(user: FIRUser?, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                guard let uid = user?.uid else{
                    return
                }
                
                //successfully authenticated
                let ref = FIRDatabase.database().reference(fromURL: "https://test-database-ba3a2.firebaseio.com/")
                let usersRef = ref.child("users").child(uid)
                let values = ["email": email, "firstName": firstName, "lastName": lastName]
                
                usersRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if err != nil{
                        print(err!)
                        return
                    }
                    
                    //successfull addition
                    self.dismiss(animated: true, completion: nil)
                })
            })
            
        }
        
        
    }

}
