//
//  HistoryViewController.swift
//  BagTracker
//
//  Created by Developer on 6/12/17.
//  Copyright © 2017 Aubry Lane. All rights reserved.
//

import UIKit

class HistoryViewController: ViewController {

    @IBOutlet weak var dateTxtField: ALCustomTextField!
    @IBOutlet weak var selectedDateLbl: UILabel!
    @IBOutlet weak var historyDataTblView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var currentDeviceUserNameLbl: UILabel!
    
    let historyViewModel = HistoryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "History"
        self.historyDataTblView.estimatedRowHeight = 100
        self.refreshHistoryViewData()
        
        self.loadHistoryData()
        
        self.historyDataTblView.register(UINib.init(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "historyCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "calendar"), style: .plain, target: self, action: #selector(HistoryViewController.dateChangeButtonPressed))
        
        self.setDatePicker()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.historyDataChanged),
            name: NSNotification.Name(rawValue: "RefreshHistoryTable"),
            object: nil)
    }
    
    func historyDataChanged(){
        
        self.historyDataTblView.reloadData()
    }
    
    
    private func setDatePicker(){
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        datePickerView.addTarget(self, action: #selector(HistoryViewController.DatePickerValueChanged(sender:)), for: .valueChanged)
        datePickerView.maximumDate = Date()
        self.dateTxtField.inputView = datePickerView
        
        // Creates the toolbar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adds the buttons
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(HistoryViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        // Adds the toolbar to the view
        self.dateTxtField.inputAccessoryView = toolBar
        
    }
    
    func doneClick() {
        self.dateTxtField.resignFirstResponder()
        self.loadHistoryData()
    }
    
    
    func DatePickerValueChanged(sender : UIDatePicker){
        self.historyViewModel.currentSelectedDate = sender.date
        self.refreshHistoryViewData()
    }
    
    
    func dateChangeButtonPressed(){
        self.dateTxtField.becomeFirstResponder()
    }
    
    
    func loadHistoryData(){
        
        //self.showProgressBar()
        
        self.historyViewModel.loadHistoryData(callBack: {
            //self.hideProgressBar()
            
            if let errorMessage = self.historyViewModel.errorMessage{
                //Displays the Error Message...
                ALConstantMethods.showAlertWith(message: errorMessage, parentController: self, okButtonCallback: nil)
            }
            self.refreshHistoryViewData()
        })
    }
    
    
    private func refreshHistoryViewData(){
        if let bagsList = ALGlobal.sharedInstance.bagLists {
            let selectedBag = bagsList[ALGlobal.sharedInstance.currentSelectedDeviceIndex]
            self.currentDeviceUserNameLbl.text = selectedBag.carNumber ?? ""
        }
        else
        {
            self.currentDeviceUserNameLbl.text = "No Device Selected"
        }
        
        self.selectedDateLbl.text = "Filter results for date : \(self.historyViewModel.getSelectedDate())"
        let dataCount = self.historyViewModel.historyListData?.count ?? 0
        self.historyDataTblView.isHidden = (dataCount == 0)
        self.noDataLabel.isHidden = (dataCount != 0)
        self.historyDataTblView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.historyViewModel.historyListData?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let historyCell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        
        if let historyDataList = self.historyViewModel.historyListData{
            
            let historyData = historyDataList[indexPath.row]
            
            historyCell.setHistoryDataWith(date: "\(historyData.gpsTime)", placeName: historyData.placeName)
            
            //                if historyData.placeName.characters.count == 0 && !historyData.isLocationCallMade {
            //
            //                historyData.isLocationCallMade = true
            //
            //                ReverseGeoCodeDataManager.getReverseGeoCodeNameWith(referenceObject: historyData, latitude: "\(historyData.latitude)", longitude: "\(historyData.longitude)", callBack: {
            //                    (referenceObject , formattedAddress, errorMessage) in
            //                    if errorMessage == nil,  let historyObject = referenceObject as? HistoryModel{
            //                        historyObject.placeName = formattedAddress
            //                        self.historyDataTblView.reloadData()
            //                    }
            //                })
            //            }
        }
        
        return historyCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
