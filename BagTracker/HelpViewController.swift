//
//  HelpViewController.swift
//  BagTracker
//
//  Created by Developer on 6/12/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit
import FAQView

class HelpViewController: ViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
        
        let items = [FAQItem(question: "Switching the Device On and Off", answer: "    To turn on the device: press the side power button for 1 second, all the LEDs will flash rapidly. Device can also be turned on automatically by chargins via USB or put it into the docking station. \n\n**To get initial location, use outdoors or near a window so the device may fix onto the satellites.**"),
                     FAQItem(question: "Activating an SOS Alarm", answer: "    Press and hold the the SOS button for 3 seconds until the device vibrates - the green light will start to flash rapidly to confirm the request. After that, an SOS alarm \"Help me!\" will be sent to all authorized phone numbers and to the platform. It will also dial the 5 authorized numbers in sequence. If the tracker fails to connect to the first number, it will call the second number after a delay of 10 seconds. (In this time the user can prevent a possible false alarm by pressing the SOS button). In case the second number fails to be connected as well, the system will connect to the third number, etc. Between each call it will have a 10 second delay where the user can press the SOS button to stop the call to the next number. \n\n    To end the call and sequence the user can press SOS button or the receiver of the call can press 1 on their mobile to stop it."),
                     FAQItem(question: "Making a Phone Call", answer: "    To make a call, press and hold the side button for 3 seconds and you will hear a beep. The green light will flash rapidly to confirm the request, and then it will dial the second number. To end the call, press the SOS button."),
                     FAQItem(question: "To Set Number for Side Button", answer: "Command: X1 / X2 / X3 / X4 / X5 \n\nExample: Text \"X1\" to the device \n\n    Side button can be configured to call whichever number. Setting the device to X1 means it will call number A1 or your first emergency contact. Default setting is X2, which means it will call your second emergency contact."),
                     FAQItem(question: "What do the lights mean?", answer: "Power Status LED")]
        
        let faqViewer = FAQView(frame: view.frame, items: items)
        view.addSubview(faqViewer)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
    
}
