//
//  ContactsTableViewController.swift
//  BagTracker
//
//  Created by Developer on 6/22/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit
import Firebase

class ContactsTableViewController: UITableViewController {

    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchContacts() {
            self.createArray()
            //self.tableView.reloadData()
        }
        print(contacts.count)
    }
    
    func sideMenus() {
        //Create menu button
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: .plain, target: revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        //Handle the changing of the purse button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Add"), style: .plain, target: self, action: #selector(addContact))
    }
    func addContact(){
        performSegue(withIdentifier: "addContactSegue", sender: nil)
    }
    func fetchContacts(completion: @escaping () -> ()){
        
        let ref = FIRDatabase.database().reference(fromURL: "https://test-database-ba3a2.firebaseio.com/")
        let user = (FIRAuth.auth()?.currentUser?.uid)!
        let userRef = ref.child("users").child(user).child("contacts")
        
        userRef.observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let contact = Contact()
                contact.setValuesForKeys(dictionary)
                print(contact)
                self.contacts.append(contact)
                
            }
            completion()
        }, withCancel: nil)
        
    }
    func createArray(){
        //rightArrayOfCellData = [rightCellData(cell : 2, text : "Add Purse", image : #imageLiteral(resourceName: "Add"))]
        var i = 0
        while i < 111{ //count the array
            //rightArrayOfCellData.append(rightCellData(cell : 1, text : purses[i].deviceName, image : #imageLiteral(resourceName: "PurseW")))
            i += 1
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)

        cell.backgroundColor = UIColor(red: 23/255, green: 222/255, blue: 0/255, alpha: 1)

        return cell
    }

}
