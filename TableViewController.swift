//
//  TableViewController.swift
//  BagTracker
//
//  Created by Developer on 6/6/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit

struct cellData {
    let cell: Int!
    let text: String!
    let image: UIImage!
}

class TableViewController: UITableViewController {
    
    var arrayOfCellData = [cellData]()
    
    override func viewDidLoad() {
        arrayOfCellData = [cellData(cell : 1, text : "Ben Cavenagh", image : #imageLiteral(resourceName: "BlankUserW")),
                           cellData(cell : 2, text : "Home", image : #imageLiteral(resourceName: "HomeW")),
                           cellData(cell : 2, text : "History", image : #imageLiteral(resourceName: "HistoryW")),
                           cellData(cell : 2, text : "Favorite", image : #imageLiteral(resourceName: "FavoriteW")),
                           cellData(cell : 2, text : "Find My Purse", image : #imageLiteral(resourceName: "PurseW")),
                           cellData(cell : 2, text : "Geo Fence", image : #imageLiteral(resourceName: "GeoFenceW")),
                           cellData(cell : 2, text : "Battery", image : #imageLiteral(resourceName: "BatteryW")),
                           //Empty cell for spacing
                           cellData(cell : 3, text : "", image : nil),
                           cellData(cell : 2, text : "Help", image : #imageLiteral(resourceName: "HelpW")),
                           cellData(cell : 2, text : "Settings", image : #imageLiteral(resourceName: "SettingsW")),
                           cellData(cell : 2, text : "Logout", image : #imageLiteral(resourceName: "LogoutW"))]
        
        self.tableView.backgroundColor = UIColor(colorLiteralRed: 139/255, green: 37/255, blue: 72/255, alpha: 1)
        
        tableView.separatorStyle = .none
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //count how many cells are in the array 
        return arrayOfCellData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //if the cell is type 1 (TableViewCellUser.xib)
        if arrayOfCellData[indexPath.row].cell == 1{
            let cell = Bundle.main.loadNibNamed("TableViewCellUser", owner: self, options: nil)?.first as! TableViewCellUser
            
            //Grabbing the image and text from array of cell data and setting up the Nib file
            cell.userImageView.image = arrayOfCellData[indexPath.row].image
            cell.userLabel.text = arrayOfCellData[indexPath.row].text
            
            
            //Setting color of the cell and the label text
            cell.backgroundColor = UIColor(colorLiteralRed: 139/255, green: 37/255, blue: 72/255, alpha: 1)
            cell.userLabel.textColor = UIColor.white
            
            //Set the color of the selected menu item
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor(red: 148/255, green: 55/255, blue: 86/255, alpha: 1)
            cell.selectedBackgroundView = bgColorView
            
            return cell
        }
            
        //if the cell is type 2 (TableViewCellTab.xib)
        else if arrayOfCellData[indexPath.row].cell == 2{
            let cell = Bundle.main.loadNibNamed("TableViewCellTab", owner: self, options: nil)?.first as! TableViewCellTab
            
            //Grabbing the image and text from array of cell data and setting up the Nib file
            cell.mainImageView.image = arrayOfCellData[indexPath.row].image
            cell.mainLabel.text = arrayOfCellData[indexPath.row].text
            
            //Setting color of the cell and the label text
            cell.backgroundColor = UIColor(colorLiteralRed: 139/255, green: 37/255, blue: 72/255, alpha: 1)
            cell.mainLabel.textColor = UIColor.white
            
            //Set the color of the selected menu item
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor(red: 148/255, green: 55/255, blue: 86/255, alpha: 1)
            cell.selectedBackgroundView = bgColorView
            
            return cell
        }
        else{
            let cell = Bundle.main.loadNibNamed("TableViewCellTab", owner: self, options: nil)?.first as! TableViewCellTab
            
            cell.isUserInteractionEnabled = false
            cell.mainLabel.text = ""
            //Setting color of the cell and the label text
            cell.backgroundColor = UIColor(colorLiteralRed: 139/255, green: 37/255, blue: 72/255, alpha: 1)
            cell.mainLabel.textColor = UIColor.white
            
            //Set the color of the selected menu item
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor(red: 148/255, green: 55/255, blue: 86/255, alpha: 1)
            cell.selectedBackgroundView = bgColorView
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrayOfCellData[indexPath.row].cell == 1{
            //Height of the user profile cell
            return 155
        }
        else if arrayOfCellData[indexPath.row].cell == 2{
            //Height of the menu button cells
           return 50
        }
        else{
            //Height of the empty button cells
            return 30
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        switch indexPath.row {
            case 0: //For User Profile
                performSegue(withIdentifier: "userSegue", sender: nil)
            case 1: //For Home
                performSegue(withIdentifier: "mapSegue", sender: nil)
            case 2: //For History
                performSegue(withIdentifier: "historySegue", sender: nil)
            case 3: //For Favorite
                performSegue(withIdentifier: "favoriteSegue", sender: nil)
            case 4: //For Find My Purse
                performSegue(withIdentifier: "mapSegue", sender: nil)
            case 5: //For Geo Fence
                performSegue(withIdentifier: "mapSegue", sender: nil)
            case 6: //For Battery Status
                performSegue(withIdentifier: "batterySegue", sender: nil)
            //NO 7 BECAUSE THATS EMPTY ROW
            case 8: //For Help
                performSegue(withIdentifier: "helpSegue", sender: nil)
            case 9: //For Settings
                performSegue(withIdentifier: "settingsSegue", sender: nil)
            default: //For Logout
                performSegue(withIdentifier: "mapSegue", sender: nil)
        }

    }
    
}
