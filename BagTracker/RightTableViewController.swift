//
//  RightTableViewController.swift
//  BagTracker
//
//  Created by Developer on 6/6/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit
import GoogleMaps

struct rightCellData {
    let cell: Int!
    let text: String!
    let image: UIImage!
    let latitude: Double!
    let longitude: Double!
    let zoom: Float!
    let mapMarker: GMSMarker!
}
class RightTableViewController: UITableViewController {
    
    var rightArrayOfCellData = [rightCellData]()
    
    let mapViewController = MapController()
        
    override func viewDidLoad() {
        rightArrayOfCellData = [rightCellData(cell : 2, text : "", image : nil, latitude : 0, longitude : 0, zoom : 0, mapMarker : GMSMarker()),
                                rightCellData(cell : 1, text : "Purse 1", image : #imageLiteral(resourceName: "PurseW"), latitude : 40, longitude : -87, zoom : 17, mapMarker : GMSMarker()),
                                rightCellData(cell : 1, text : "Purse 2", image : #imageLiteral(resourceName: "PurseW"), latitude : 39, longitude : -86, zoom : 17, mapMarker : GMSMarker()),
                                rightCellData(cell : 1, text : "Purse 3", image : #imageLiteral(resourceName: "PurseW"), latitude : 38, longitude : -85, zoom : 17, mapMarker : GMSMarker())]
            
        self.tableView.backgroundColor = UIColor(colorLiteralRed: 139/255, green: 37/255, blue: 72/255, alpha: 1)
            
        tableView.separatorStyle = .none
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
            cell.backgroundColor = UIColor(colorLiteralRed: 139/255, green: 37/255, blue: 72/255, alpha: 1)
            cell.PurseLabel.textColor = UIColor.white
                
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
    //TODO: Figure out how to update the map when a purse is selected and close the purse menu
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mapViewController.latitude = rightArrayOfCellData[indexPath.row].latitude
        mapViewController.longitude = rightArrayOfCellData[indexPath.row].longitude
        mapViewController.zoom = rightArrayOfCellData[indexPath.row].zoom
        NSLog("Map Update")
        mapViewController.reloadMap()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Height of the purse cell
        return 50
    }
        
}

