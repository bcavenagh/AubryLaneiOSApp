//
//  ViewController.swift
//  BagTracker
//
//  Created by Developer on 6/6/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var MenuButton: UIBarButtonItem!
    @IBOutlet weak var OptionalButton: UIBarButtonItem!
    
    //Login Information
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var _email: UITextField!
    @IBOutlet weak var _password: UITextField!
    
    //Register Information
    @IBOutlet weak var acceptTCBox: UIButton!
    @IBOutlet weak var _registerEmail: UITextField!
    @IBOutlet weak var _registerUsername: UITextField!
    @IBOutlet weak var _registerPassword: UITextField!
    @IBOutlet weak var _registerPasswordConfirm: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenus()
        customizeNavBar()
    }

    @IBAction func login_Clicked(_ sender: Any) {
        let user = "ben"
        let psw = "purse"
        
        if(_email.text == user && _password.text == psw){
            _email.resignFirstResponder()
            _password.resignFirstResponder()
            loginLabel.text = "Success."
            loginLabel.textColor = UIColor.green
            self.performSegue(withIdentifier: "loginSuccess", sender:self)
        }
        else{
            loginLabel.text = "Invalid credentials. Try again."
            _email.resignFirstResponder()
            _password.resignFirstResponder()
        }
    }
    func toggleTermsAndConditions(){
        if(acceptTCBox.currentImage == #imageLiteral(resourceName: "unchecked")){
            acceptTCBox.setImage(#imageLiteral(resourceName: "checked"), for: UIControlState.normal)
        }
        else{
            acceptTCBox.setImage(#imageLiteral(resourceName: "unchecked"), for: UIControlState.normal)
        }
    }
    
    @IBAction func acceptTCBox_Clicked(_ sender: Any) {
        toggleTermsAndConditions()
    }
    
    @IBAction func acceptTCText_Clicked(_ sender: Any) {
        toggleTermsAndConditions()
    }
    
    func sideMenus() {
        if revealViewController() != nil{
            //Make the Menu Button to the reveal the menu
            MenuButton.target = revealViewController()
            MenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            //Choose how far the view slides to reveal the left menu
            revealViewController().rearViewRevealWidth = 275
            //Choose how far the view slides to reveal the right menu
            revealViewController().rightViewRevealWidth = 160
            
            //MAke the right bar button open the right menu
            //TODO: Determine if we want a right side menu or not. Choose a bag to show on the map?
            OptionalButton.target = revealViewController()
            OptionalButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            //Allow a swipe gesture to open the menu
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    func customizeNavBar(){
        //Change the color of the images
        navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 209/255, green: 151/255, blue: 72/255, alpha: 1)
        //Change the color of the top main bar
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 100/255, green: 5/255, blue: 57/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
    }
    
}
