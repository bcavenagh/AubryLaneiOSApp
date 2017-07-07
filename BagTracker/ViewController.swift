//
//  ViewController.swift
//  BagTracker
//
//  Created by Developer on 6/6/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import CoreLocation
import FAQView

class ViewController: UIViewController {
    
    @IBOutlet weak var MenuButton: UIBarButtonItem!
    @IBOutlet weak var OptionalButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        customizeNavBar()
        //getBagList()
        
        //GET USER'S CURRENT LOCATION AND CALL getBagList WHEN THEY SELECT A BAG FROM MENU
        //getUserLocation()
        
    }
    
    func sideMenus() {
        if revealViewController() != nil{
            
            //Create menu button
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: .plain, target: revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))

            //Choose how far the view slides to reveal the left menu
            revealViewController().rearViewRevealWidth = 275
            //Choose how far the view slides to reveal the right menu
            revealViewController().rightViewRevealWidth = 160
            
            //Create purse button
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Purse"), style: .plain, target: revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)))

            //Allow a swipe gesture to open the menu
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
    
    func customizeNavBar(){
        //Change the color of the images red: 209/255, green: 151/255, blue: 72/255, alpha: 1
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor(red: 209/255, green: 151/255, blue: 72/255, alpha: 1)
        //Change the color of the top main bar
        navigationController?.navigationBar.barTintColor = UIColor(red: 100/255, green: 5/255, blue: 57/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
    }
    
}
