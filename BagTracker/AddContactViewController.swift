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
class AddContactViewController: UIViewController, MFMessageComposeViewControllerDelegate {

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
            numberErrorLabel.text = "Phone number too short "
            print("Error: Too short")
        }else if(phoneNumber!.characters.count > 10){
            numberErrorLabel.text = "Phone number too long "
            print("Error: Too Long")
        }else if(contactNumber.text?.isNumeric)!{

            let alert = UIAlertController(title: "Important!", message: "You will be redirected to the Messages app shortly. Please do NOT edit the preset text message. Press the send button and the emergency contact will be added to your device.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ action in
                self.addContact() }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }else{
            numberErrorLabel.text = "Use numbers only"
            print("Error: Not Numeric")
        }
        
    }
    func addContact(){
        let phoneNumber = contactNumber.text as String!
        let name = contactName.text as String!
        let newContact = Contact()
        
        //save the contect to a local array for now and send a text message
        contactIndex = 1
        if(ALGlobal.sharedInstance.contactsExist()){
            let filledDefaultsArray = ALGlobal.sharedInstance.globalDefaults.array(forKey: "emergencyContactName") as! [String]
            contactIndex = filledDefaultsArray.count + 1
        }
        
        messageVC.body = "a\(contactIndex),\(phoneNumber!)";
        messageVC.recipients = [ALGlobal.sharedInstance.globalDefaults.object(forKey: "devicePhoneNumber") as!
            String]
        messageVC.messageComposeDelegate = self;
        self.present(messageVC, animated: true, completion: nil)
        
        newContact.name = name
        newContact.phone = phoneNumber
        ALGlobal.sharedInstance.contactList.append(newContact)
        ALGlobal.sharedInstance.populateArrays()
        ALGlobal.sharedInstance.emergencyContactName.append(newContact.name!)
        ALGlobal.sharedInstance.emergencyContactNumber.append(newContact.phone!)
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResult.cancelled.rawValue:
            print("Message was cancelled")
            ALGlobal.sharedInstance.emergencyContactName.remove(at: ALGlobal.sharedInstance.emergencyContactName.count-1)
            ALGlobal.sharedInstance.emergencyContactNumber.remove(at: ALGlobal.sharedInstance.emergencyContactName.count-1)
            messageVC.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed.rawValue:
            print("Message failed")
            ALGlobal.sharedInstance.emergencyContactName.remove(at: ALGlobal.sharedInstance.emergencyContactName.count-1)
            ALGlobal.sharedInstance.emergencyContactNumber.remove(at: ALGlobal.sharedInstance.emergencyContactName.count-1)
            messageVC.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent.rawValue:
            print("Message was sent")
            messageVC.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        default:
            break;
        }
    }
    
}
