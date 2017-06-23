//
//  EmergencyContactViewController.swift
//  BagTracker
//
//  Created by Developer on 6/22/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit
import Firebase

class AddContactViewController: UIViewController {

    @IBOutlet weak var contactNumber: UITextField!
    @IBOutlet weak var contactName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButton_Clicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButton_Clicked(_ sender: Any) {
        //Add purse as a device under the user
        guard let user = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference(fromURL: "https://test-database-ba3a2.firebaseio.com/")
        let usersRef = ref.child("users").child(user).child("contacts").child(contactNumber.text!)
        let emergencyContact = ["name": contactName.text, "phone": contactNumber.text]
        
        usersRef.setValue(emergencyContact, withCompletionBlock: { (err, ref) in
            if err != nil{
                print("ERROR!!!!!!!!!!! %s", err!)
                return
            }
            //successfull addition
            self.dismiss(animated: true, completion: nil)
            print("Saved contact into firebase DB")
        })
    }
    

}