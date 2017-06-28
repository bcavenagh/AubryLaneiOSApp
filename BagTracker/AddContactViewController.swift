//
//  EmergencyContactViewController.swift
//  BagTracker
//
//  Created by Developer on 6/22/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit
import Firebase

extension String {
    var isNumeric: Bool {
        guard self.characters.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self.characters).isSubset(of: nums)
    }
}

class AddContactViewController: UIViewController {

    @IBOutlet weak var numberErrorLabel: UILabel!
    @IBOutlet weak var contactNumber: UITextField!
    @IBOutlet weak var contactName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberErrorLabel.text = ""
    }
    
    @IBAction func cancelButton_Clicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneButton_Clicked(_ sender: Any) {
        let phoneNumber = contactNumber.text as String!
        
        if(phoneNumber!.characters.count < 10){
            numberErrorLabel.text = "Phone number too short "
            print("Error: Too short")
        }else if(phoneNumber!.characters.count > 10){
            numberErrorLabel.text = "Phone number too long "
            print("Error: Too Long")
        }else if(contactNumber.text?.isNumeric)!{
            //Add purse as a device under the user
            guard let user = FIRAuth.auth()?.currentUser?.uid else{
                return
            }
            let ref = FIRDatabase.database().reference(fromURL: "https://test-database-ba3a2.firebaseio.com/")
            let usersRef = ref.child("users").child(user).child("contacts").child(contactNumber.text!)
            let emergencyContact = ["name": contactName.text, "phone": contactNumber.text]
        
            usersRef.setValue(emergencyContact, withCompletionBlock: { (err, ref) in
                if err != nil{
                    print("Error: %s", err!)
                    return
                }
                //successfull addition
                self.dismiss(animated: true, completion: nil)
                print("Saved contact into firebase DB")
            })
        }else{
            numberErrorLabel.text = "Use numbers only"
            print("Error: Not Numeric")
        }
    }
    

}
