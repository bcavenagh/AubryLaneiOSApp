//
//  RightTableViewController.swift
//  BagTracker
//
//  Created by Developer on 6/6/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase

struct rightCellData {
    let cell: Int!
    let text: String!
    let image: UIImage!
}
class RightTableViewController: UITableViewController {
    
    var rightArrayOfCellData = [rightCellData]()
    let mapViewController = MapController()
    var purses = [Purse]()
    
    override func viewDidLoad() {
        
        self.tableView.backgroundColor = UIColor(red: 100/255, green: 5/255, blue: 57/255, alpha: 1)
            
        tableView.separatorStyle = .none
        fetchPurse (){
            self.createArray()
            self.tableView.reloadData()
        }
    }
    
    func fetchPurse(completion: @escaping () -> ()){
        
        let ref = FIRDatabase.database().reference(fromURL: "https://test-database-ba3a2.firebaseio.com/")
        let user = (FIRAuth.auth()?.currentUser?.uid)!
        let userRef = ref.child("users").child(user).child("devices")
        
        userRef.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let purse = Purse()
                purse.setValuesForKeys(dictionary)
                self.purses.append(purse)
                
            }
            completion()
        }, withCancel: nil)
        
    }
    func createArray(){
        rightArrayOfCellData = [rightCellData(cell : 2, text : "Add Purse", image : #imageLiteral(resourceName: "Add"))]
        var i = 0
        while i < purses.count{
            rightArrayOfCellData.append(rightCellData(cell : 1, text : purses[i].deviceName, image : #imageLiteral(resourceName: "PurseW")))
            i += 1
        }
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //count how many cells are in the array
        return rightArrayOfCellData.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if rightArrayOfCellData[indexPath.row].cell == 1{
            let cell = Bundle.main.loadNibNamed("PurseTableViewCell", owner: self, options: nil)?.first as! PurseTableViewCell
                
            //Grabbing the image and text from array of cell data and setting up the Nib file
            cell.PurseImageView.image = rightArrayOfCellData[indexPath.row].image
            cell.PurseLabel.text = rightArrayOfCellData[indexPath.row].text
                
                
            //Setting color of the cell and the label text
            cell.backgroundColor = UIColor(red: 100/255, green: 5/255, blue: 57/255, alpha: 1)
            cell.PurseLabel.textColor = UIColor.white
                
            //Set the color of the selected menu item
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor(red: 148/255, green: 55/255, blue: 86/255, alpha: 1)
            cell.selectedBackgroundView = bgColorView
            
            return cell
        }
        else{
            let cell = Bundle.main.loadNibNamed("PurseTableViewCell", owner: self, options: nil)?.first as! PurseTableViewCell
            
            cell.PurseImageView.image = rightArrayOfCellData[indexPath.row].image
            cell.PurseLabel.text = rightArrayOfCellData[indexPath.row].text

            //Setting color of the cell and the label text
            cell.backgroundColor = UIColor(red: 209/255, green: 151/255, blue: 72/255, alpha: 1)
            cell.PurseLabel.textColor = UIColor.white
            
            //Set the color of the selected menu item
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor(red: 158/255, green: 122/255, blue: 31/255, alpha: 1)
            cell.selectedBackgroundView = bgColorView
            
            return cell
        }
        
    }
    
    
    //TODO: Figure out how to update the map when a purse is selected and close the purse menu
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if(indexPath.row == 0){
            performSegue(withIdentifier: "addPurseSegue", sender: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Height of the purse cell
        return 50
    }
        
}

