//
//  SettingsViewController.swift
//  BagTracker
//
//  Created by Developer on 6/12/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit

class SettingsViewController: ViewController, UIPickerViewDelegate, UIPickerViewDataSource {

	@IBOutlet weak var changTimezoneButton: UIButton!
	//var timezonePickerView : UIPickerView = UIPickerView()
	@IBOutlet weak var timezonePicker: UIPickerView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		self.timezonePicker.isHidden = true
		self.timezonePicker.dataSource = self
		self.timezonePicker.delegate = self
		//self.timezonePickerView.frame = CGRect(x: 100, y: 100, width: 100, height: 162)
		//self.timezonePickerView.backgroundColor = UIColor.black
		//self.timezonePickerView.layer.borderColor = UIColor.white.cgColor
		//self.timezonePickerView.layer.borderWidth = 1
		
		//self.view.addSubview(timezonePickerView)
    }
	@IBAction func changeTimezone_Pressed(_ sender: Any) {
		timezonePicker.isHidden = false
	}
	
	func numberOfComponents(in: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_: UIPickerView, numberOfRowsInComponent: Int) -> Int {
		return 2
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return "Timezone" as String
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		
	}
	
	func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
		return 36.0
	}
	
	func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
		return 36.0
	}

}
