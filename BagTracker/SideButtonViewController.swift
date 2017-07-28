//
//  SideButtonViewController.swift
//  BagTracker
//
//  Created by Developer on 7/24/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit
import MessageUI

class SideButtonViewController: ViewController, UITableViewDataSource, UITableViewDelegate, MFMessageComposeViewControllerDelegate {
    
    var messageVC = MFMessageComposeViewController()
    
    @IBOutlet var contactsTable: UITableView!
    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    func loadData(){
        contactsTable.delegate = self
        contactsTable.dataSource = self
        contactsTable.rowHeight = 65
    
        if(ALGlobal.sharedInstance.emergencyContactName.count > 0){
            ALGlobal.sharedInstance.globalDefaults.removeObject(forKey: "emergencyContactName")
            ALGlobal.sharedInstance.globalDefaults.removeObject(forKey: "emergencyContactNumber")
            ALGlobal.sharedInstance.globalDefaults.set(ALGlobal.sharedInstance.emergencyContactName, forKey: "emergencyContactName")
            ALGlobal.sharedInstance.globalDefaults.set(ALGlobal.sharedInstance.emergencyContactNumber, forKey: "emergencyContactNumber")
            ALGlobal.sharedInstance.globalDefaults.synchronize()
        }
        fetchContacts(){
            self.contactsTable.reloadData()
        }
    }
    func fetchContacts(completion: @escaping () -> ()){
        if(ALGlobal.sharedInstance.globalDefaults.object(forKey: "emergencyContactName") != nil){
            let defaultContacts = ALGlobal.sharedInstance.globalDefaults.object(forKey: "emergencyContactName") as! [String]
            var i = 0
            while i < defaultContacts.count{
                let name = ALGlobal.sharedInstance.globalDefaults.array(forKey: "emergencyContactName") as! [String]
                let number = ALGlobal.sharedInstance.globalDefaults.array(forKey: "emergencyContactNumber") as! [String]
                let newContact = Contact()
                newContact.name = name[i]
                newContact.phone = number[i]
                contacts.append(newContact)
                i += 1
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SideButtonContactTableViewCell = self.contactsTable.dequeueReusableCell(withIdentifier: "sideButtonContactCell") as! SideButtonContactTableViewCell
        
        let contactName = contacts[indexPath.row].name as String!
        let phoneNumber = contacts[indexPath.row].phone as String!
        
        if validateNumber(phone: phoneNumber){
            let areaCodeIndex = phoneNumber?.index((phoneNumber?.startIndex)!, offsetBy: 3)
            let areaCode = phoneNumber?.substring(to: areaCodeIndex!) as String!
            
            let middleStart = phoneNumber!.index(phoneNumber!.startIndex, offsetBy: 2)
            let middleEnd = phoneNumber!.index(middleStart, offsetBy: 4)
            let middleRangeIndex = phoneNumber!.index(after: middleStart)..<middleEnd
            let middleRange = phoneNumber?.substring(with: middleRangeIndex)
            
            let endStart = phoneNumber!.index(middleEnd, offsetBy: -1)
            let endEnd = phoneNumber!.index(phoneNumber!.endIndex, offsetBy: 0)
            let endRangeIndex = phoneNumber!.index(after: endStart)..<endEnd
            let endRange = phoneNumber?.substring(with: endRangeIndex)
            
            let formattedPhoneNumber = "(\(areaCode!)) \(middleRange!)-\(endRange!)"
            cell.contactNumberLabel.text = formattedPhoneNumber
        }
        cell.contactLabel.text = contactName
        //cell.contactSelectedImage = nil
        cell.selectContactAction = { [weak self] (cell) in
            self?.selectContact(phone: phoneNumber!, name: contactName!, cell: cell, cellIndex: indexPath.row)
        }
        
        if(ALGlobal.sharedInstance.globalDefaults.object(forKey: "selectedContactIndex") != nil){
            ALGlobal.sharedInstance.setSelectedContact()
        }
        if(indexPath.row == ALGlobal.sharedInstance.selectedContact){
            cell.selectButton.isUserInteractionEnabled = false
            cell.selectButton.setTitle("",for: .normal)
            cell.contactSelectedImage.image = UIImage(named: ("contactCheck"))
        }else{
            cell.selectButton.setTitle("Select",for: .normal)
            cell.selectButton.isUserInteractionEnabled = true
            cell.contactSelectedImage.image = nil
        }
        
        return cell
    }
    func validateNumber(phone: String!) -> Bool{
        if(phone.characters.count == 10){
            return true
        }
        return false
    }
    
    func selectContact(phone: String, name: String, cell: UITableViewCell, cellIndex: Int){
        let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to set \(name) as your emergency contact?", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler:{ action in
            self.showTextMessageWarning(phone: phone, name: name, row: cellIndex)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    func sendSelectText(phone: String, name: String, row: Int){
        messageVC = MFMessageComposeViewController()
        messageVC.body = "X\(row+1)"
        messageVC.recipients = [ALGlobal.sharedInstance.globalDefaults.object(forKey: "devicePhoneNumber") as!
            String]
        messageVC.messageComposeDelegate = self;
        self.present(messageVC, animated: true, completion: nil)
        saveContact(row: row)
    }
    func saveContact(row: Int){
        ALGlobal.sharedInstance.selectedContact = row
        ALGlobal.sharedInstance.globalDefaults.set(row, forKey: "selectedContactIndex")
        contactsTable.reloadData()
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResult.cancelled.rawValue:
            print("Message was cancelled")
            messageVC.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed.rawValue:
            print("Message failed")
            messageVC.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent.rawValue:
            print("Message was sent")
            messageVC.dismiss(animated: true, completion: nil)
            
        default:
            break;
        }
    }
    func showTextMessageWarning(phone: String, name: String, row: Int){
        let alert = UIAlertController(title: "Important!", message: "You will be redirected to the Messages app shortly. Please do NOT edit the preset text message. Press the send button and the emergency contact will be added to your device.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ action in
            self.sendSelectText(phone: phone, name: name, row: row) }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
