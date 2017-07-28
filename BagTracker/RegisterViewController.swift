//
//  RegisterViewController.swift
//  BagTracker
//
//  Created by Developer on 6/12/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    //Register Information
	@IBOutlet weak var registerWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
		let url = NSURL (string: "http://132.148.89.30/register");
		let requestObj = NSURLRequest(url: url! as URL);
		registerWebView.loadRequest(requestObj as URLRequest);
    }
    
	@IBAction func backButton_Clicked(segue:UIStoryboardSegue) {
	}
}
