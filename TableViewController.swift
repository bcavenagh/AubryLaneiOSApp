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
        arrayOfCellData = [cellData(cell : 1, text : "Ben Cavenagh", image : #imageLiteral(resourceName: "BlankUser")),
                           cellData(cell : 2, text : "Home", image : #imageLiteral(resourceName: "Home")),
                           cellData(cell : 2, text : "History", image : #imageLiteral(resourceName: "History")),
                           cellData(cell : 2, text : "Favorite", image : #imageLiteral(resourceName: "Favorite")),
                           cellData(cell : 2, text : "Find My Purse", image : #imageLiteral(resourceName: "Purse")),
                           cellData(cell : 2, text : "Geo Fence", image : #imageLiteral(resourceName: "GeoFence")),
                           cellData(cell : 2, text : "Battery", image : #imageLiteral(resourceName: "Battery"))]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCellData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if arrayOfCellData[indexPath.row].cell == 1{
            
            let cell = Bundle.main.loadNibNamed("TableViewCellUser", owner: self, options: nil)?.first as! TableViewCellUser
            
            //Grabbing the image and text from array of cell data and setting up the Nib file
            cell.userImageView.image = arrayOfCellData[indexPath.row].image
            cell.userLabel.text = arrayOfCellData[indexPath.row].text
            
            return cell
        }
        else if arrayOfCellData[indexPath.row].cell == 2{
            let cell = Bundle.main.loadNibNamed("TableViewCellTab", owner: self, options: nil)?.first as! TableViewCellTab
            
            //Grabbing the image and text from array of cell data and setting up the Nib file
            cell.mainImageView.image = arrayOfCellData[indexPath.row].image
            cell.mainLabel.text = arrayOfCellData[indexPath.row].text
            
            return cell
        }
        else{
            let cell = Bundle.main.loadNibNamed("TableViewCellTab", owner: self, options: nil)?.first as! TableViewCellTab
            
            //Grabbing the image and text from array of cell data and setting up the Nib file
            cell.mainImageView.image = arrayOfCellData[indexPath.row].image
            cell.mainLabel.text = arrayOfCellData[indexPath.row].text
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrayOfCellData[indexPath.row].cell == 1{
            return 155
        }
        else if arrayOfCellData[indexPath.row].cell == 2{
           return 50
        }
        else{
            return 50
        }
    }
    
}
