//
//  SettingsViewController.swift
//  BagTracker
//
//  Created by Developer on 6/12/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeNavBar()
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            let revealController = self.revealViewController() as? RevealViewController
            revealController?.settingsController = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func customizeNavBar(){
        //Change the color of the images
        navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 209/255, green: 151/255, blue: 72/255, alpha: 1)
        //Change the color of the top main bar
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 100/255, green: 5/255, blue: 57/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
