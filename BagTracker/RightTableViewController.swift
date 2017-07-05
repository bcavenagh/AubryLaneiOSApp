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
    var cells = [UITableViewCell]()
    
    override func viewDidLoad() {
        
        self.tableView.backgroundColor = UIColor(red: 100/255, green: 5/255, blue: 57/255, alpha: 1)
            
        tableView.separatorStyle = .none
//        fetchPurse (){
//            self.createArray()
//            self.tableView.reloadData()
//        }
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
//        rightArrayOfCellData = [rightCellData(cell : 2, text : "Add Purse", image : #imageLiteral(resourceName: "Add"))]
//        var i = 0
//        while i < purses.count{
//            rightArrayOfCellData.append(rightCellData(cell : 1, text : purses[i].deviceName, image : #imageLiteral(resourceName: "PurseW")))
//            i += 1
//        }
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //count how many cells are in the array
//        return rightArrayOfCellData.count
        print(ALGlobal.sharedInstance.getBagsCount)
        return ALGlobal.sharedInstance.getBagsCount + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var cell = UITableViewCell() as! PurseTableViewCell
        let cellAdded = Bundle.main.loadNibNamed("PurseTableViewCell", owner: self, options: nil)?.first as! PurseTableViewCell
        
        if indexPath.row == 0{
            cellAdded.PurseImageView.image = #imageLiteral(resourceName: "Add")
            cellAdded.PurseLabel.text = "Add Purse"
            //Setting color of the cell and the label text
            cellAdded.backgroundColor = UIColor(red: 209/255, green: 151/255, blue: 72/255, alpha: 1)
            cellAdded.PurseLabel.textColor = UIColor.white
            
            //Set the color of the selected menu item
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor(red: 158/255, green: 122/255, blue: 31/255, alpha: 1)
            cellAdded.selectedBackgroundView = bgColorView
            cells.append(cellAdded)
        }
        else{
            cellAdded.PurseImageView.image = #imageLiteral(resourceName: "PurseW")
            cellAdded.PurseLabel.text = ALGlobal.sharedInstance.bagLists?[(indexPath.row) - 1].carNumber
            cellAdded.backgroundColor = UIColor(red: 100/255, green: 5/255, blue: 57/255, alpha: 1)
            cellAdded.PurseLabel.textColor = UIColor.white
            
            //Set the color of the selected menu item
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor(red: 148/255, green: 55/255, blue: 86/255, alpha: 1)
            cellAdded.selectedBackgroundView = bgColorView
            cells.append(cellAdded)
        }
            
           return cellAdded
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

