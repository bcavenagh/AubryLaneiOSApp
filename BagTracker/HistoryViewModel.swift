//
//  HistoryViewModel.swift
//  AubryLane
//
//  Created by Dhruv on 10/05/17.
//  Copyright © 2017 day. All rights reserved.
//

import UIKit

class HistoryModel {
    
    var gpsTime : String
    var latitude : CGFloat
    var longitude : CGFloat
    var speed : NSNumber
    var placeName  = ""
    var isLocationCallMade = false
    
    init(historyData : NSDictionary) {
        
        gpsTime = "\(historyData["gpsTime"] as? Date ?? Date())"
        let dateTry = historyData["gpsTime"] as! String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss"
        let date = dateFormatter.date(from: dateTry)!
        /////
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: date)
        
        let hour = components.hour!
        let minute = components.minute!
        
        let timeString = "\(String(describing: hour)):\(String(describing: minute))"
        /////
        print(timeString)
        print("formatted Date: \(date)")
        print("gps time: \(gpsTime)")

        gpsTime = timeString
        latitude = historyData["la"] as? CGFloat ?? CGFloat(0.0)
        longitude = historyData["lo"] as? CGFloat ?? CGFloat(0.0)
        speed = historyData["speed"] as? NSNumber ?? NSNumber.init(value: 0)
        
        
        ReverseGeoCodeDataManager.getReverseGeoCodeNameWith(referenceObject: self, latitude: "\(self.latitude)", longitude: "\(self.longitude)", callBack: {[weak self](referenceObject , formattedAddress, errorMessage) in
            
            if let weakSelf = self{
                
                if let _ = errorMessage{
                    weakSelf.placeName = "No Data Available"
                }
                else
                {
                    weakSelf.placeName = formattedAddress
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RefreshHistoryTable"), object: nil)
        })
    }
}



class HistoryViewModel: NSObject {
    
    var historyDataManager = HistoryDataManager()
    
    var currentSelectedDate = Date()
    
    var historyListData : [HistoryModel]?
    var errorMessage : String?
    
    var getNextDateFromSelectedDate : String{
        get{
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: currentSelectedDate)
            return self.getDateInServerFormat(date: tomorrow!)
        }
    }
    
    var historyDataList : [Any] = [Any]()
    
    func getSelectedDate() -> String{
        return self.getDateInServerFormat(date: currentSelectedDate)
    }
    
    func loadHistoryData(callBack : @escaping (() -> ())){
        
        if let bagId = ALGlobal.sharedInstance.bagLists?[ALGlobal.sharedInstance.currentSelectedDeviceIndex].bagID!{
            
            let parameters = "bagId=\(bagId)&fromdate=\(self.getSelectedDate())&todate=\(self.getNextDateFromSelectedDate)"
            
            //let parameters = "bagId=\(bagId)&fromdate=09-MAY-2017&todate=10-MAY-2017"
            
            historyDataManager.fetchHistoryData(parameter: parameters, callBack: {
                (historyDataList, errorMessage) in
                self.historyListData = historyDataList
                self.errorMessage = errorMessage
                callBack()
            })
        }
        else
        {
            self.errorMessage = "Currently there is no device selected. Please select a device then proceed further."
            callBack()
        }
    }
    
    
    
    private func getDateInServerFormat(date :Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-YYYY"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}
