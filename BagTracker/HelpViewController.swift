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
        
        let items = [FAQItem(question: "Switching the Amulet On and Off", answer: "To turn on the Amulet: press the side call button for 1 second, all the LEDs will flash rapidly. The Amulet can also be turned on automatically by charging via USB or by putting it into the docking station. \n\n**To get initial location, use outdoors or near a window so the Amulet may fix onto the satellites.**"),
                     FAQItem(question: "How do I find my Amulet?", answer: "To find your Amulet click on either the \"Home\" tab or the \"Find My Amulet\" tab. This will display a map of the world and will zoom into where your Amulet is located. See the \"Interacting with the Map\" section for more controls in regards to using the map."),
                     FAQItem(question: "What does the \"History\" page do?", answer: "When you open the History page you will see a table which displays where your Amulet has been and the time that it was there. Along the left-side of the screen you will see the time of the location followed by address on the right side. You can view previous dates as well by clicking the calendar button on the top right of the screen and choosing a date. The table will be reloaded with the times and locations that are equivalent to that day's information."),
                     FAQItem(question: "How do I add emergency contacts?", answer: "To add emergency contacts open the left side menu and click the \"Emergency Contacts\" page. Once the page is opened, if you have not set your Amulet's number in the app before you will be prompted to add your Amulet's phone number to the app. Once this has been done, to add a contact click the \"+\" button on the top right of the screen. You will then be prompted to enter your contacts information. After you enter the information click the \"Done\" button. The app will then give you an informational warning, this is to notify you that the app will need to open your Messages app in order to send a programming text message to your Amulet. Accept the warning and your Messages app will be opened. DO NOT edit the text message to the Amulet as an improper format will result in the Amulet not being able to set the contact and the app will then contain false information. Simply press the send button on the text message and the Amulet will be programmed with the correct emergency contact. Re-open the \"Emergency Contacts\" page once this is completed to view the updated table of emergency contacts. You may only add 5 emergency contacts to your Amulet. You can edit your contacts information by clicking the pencil icon located next to their name and sending the provided text message to your Amulet. To delete a contact, click the trash icon located next to their name and send the provided text message to your Amulet."),
                     FAQItem(question: "How do I set a geo-fence?", answer: "To set a geo-fence open the left side menu by clicking the button on the top left of the screen. Select the \"Geo-Fence\" tab and wait for the map to zoom into your Amulet's location. Confirm that this is where your Amulet is located and if it is an incorrect location then place your Amulet outside or near a window for 5-10 minutes so that a connection to the satellite can be re-established. If the location for the Amulet is correct then click the circular \"+\" button in the bottom right corner of the screen to add a geo-fence. Enter your desired size for the geo-fence (The fence must be at least 330 feet, 100 meters). Once you enter the desired size of the fence click \"Confirm\" you will be presented a warning. This is to notify you that the app will need to open your Messages app in order to send a programming text message to your Amulet. Accept the warning and your Messages app will be opened. DO NOT edit the text message to the Amulet as an improper format will result in the Amulet not being able to set the fence properly and the app will then contain false information. Simply press the send button on the text message and the Amulet will be programmed with the correct geo-fence. The map on the \"Geo-Fence\" page of the app will now display a blue circle around your amulet which represents the where the geo-fence is. Once the fence is set you should notice that the circular \"+\" button as changed to a circular trash button. To remove the geo-fence, click this button and send the preformatted text message that will pop-up. Again, DO NOT edit this text. After you send the text the circle on you map should disappear and the trash button should return to the \"+\"."),
                     FAQItem(question: "How do I set my preferred contact for making calls from the Amulet?", answer: "A preferred contact is the contact that will be called when you press the side button on the Amulet to make a call. (See: \"Making a Phone Call from the Amulet\" for more information.) To set this contact open the left side menu and click the \"Side Phone Button\" tab. Note: You must have your emergency contacts set up before you can continue. To setup your emergency contacts see the \"How do I add emergency contacts?\" section. Once this page is open you should see a list of your emergency contacts. You should see a \"Select\" button located next to each contact. Click Select on your preferred contact and you will be prompted to confirm this choice. Once you confirm you will be presented a warning. This is to notify you that the app will need to open your Messages app in order to send a programming text message to your Amulet. Accept the warning and your Messages app will be opened. DO NOT edit the text message to the Amulet as an improper format will result in the Amulet not being able to set the preferred contact properly and the app will then contain false information. Simply press the send button on the text message and the Amulet will be programmed with the correct preferred contact. You can switch your preferred contact at any point just click Select on your next choice and send the preformatted text and the preference will be updated."),
                     FAQItem(question: "Making a Phone Call from the Amulet", answer: "To make a call, press and hold the side button for 3 seconds and you will hear a beep. The green light will flash rapidly to confirm the request, and then it will dial the second number. To end the call, press the SOS button."),
                     FAQItem(question: "Interacting with the Map", answer: "The map is a standard Apple Map and works the same as your provided Maps app. To zoom in/out pinch the screen. This will allow you to see where your Amulet is located with more clarity. The map also has two different settings, Satellite and Standard. Standard shows a flat map with all the roads labeled and various other information provided by Apple Maps. Satellite shows a satellite view of the world so that you can see a real, bird's eye view of the world. To switch the views use the segmented switcher control located at the bottom of the map."),
                     FAQItem(question: "", answer: "")]
        
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
