//
//  EmergencyContactViewController.swift
//  BagTracker
//
//  Created by Developer on 6/22/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

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
    var messageVC = MFMessageComposeViewController()
    var contactIndex = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        numberErrorLabel.text = ""
        contactNumber.keyboardType = .numberPad
    }
    
    @IBAction func cancelButton_Clicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneButton_Clicked(_ sender: Any) {
        let phoneNumber = contactNumber.text as String!
        if(phoneNumber!.characters.count < 10){
            numberErrorLabel.text = "Phone number too short"
            print("Error: Too short")
        }else if(phoneNumber!.characters.count > 10){
            numberErrorLabel.text = "Phone number too long"
            print("Error: Too Long")
        }else if(contactNumber.text?.isNumeric)!{
			self.addContact()
        }else{
            numberErrorLabel.text = "Use numbers only"
            print("Error: Not Numeric")
        }
        
    }
    func addContact(){
        let phoneNumber = contactNumber.text as String!
        let name = contactName.text as String!
        let newContact = Contact()
        
        //save the contact to a local array for now and send a text message
        contactIndex = 1
        if(ALGlobal.sharedInstance.contactsExist()){
            let filledDefaultsArray = ALGlobal.sharedInstance.globalDefaults.array(forKey: "emergencyContactName") as! [String]
            contactIndex = filledDefaultsArray.count + 1
        }
		 var request = URLRequest(url: URL(string: "http://132.148.89.30:5000/sms")!)
		request.httpMethod = "POST"
		let postString = "To=\(String(describing: (ALGlobal.sharedInstance.globalDefaults.object(forKey: "devicePhoneNumber") as? String)!))&From=13176444325&Body=a\(contactIndex),\(phoneNumber!)"
		print(postString)
		request.httpBody = postString.data(using: .utf8)
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data, error == nil else {
				// check for fundamental networking error
				print("error=\(String(describing: error))")
				return
			}
			
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
				// check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				print("response = \(String(describing: response))")
			}
			
			let responseString = String(data: data, encoding: .utf8)
			print("responseString = \(String(describing: responseString))")
		}
		task.resume()
        
        newContact.name = name
        newContact.phone = phoneNumber
        ALGlobal.sharedInstance.contactList.append(newContact)
        ALGlobal.sharedInstance.populateArrays()
        ALGlobal.sharedInstance.emergencyContactName.append(newContact.name!)
        ALGlobal.sharedInstance.emergencyContactNumber.append(newContact.phone!)
		self.dismiss(animated: true, completion: nil)
    }
    
}
