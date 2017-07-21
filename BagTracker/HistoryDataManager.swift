//
//  HistoryDataManager.swift
//  AubryLane
//
//  Created by Dhruv on 10/05/17.
//  Copyright © 2017 day. All rights reserved.
//

import UIKit

class HistoryDataManager: NSObject {
    
    func fetchHistoryData(parameter : String, callBack : @escaping ((_ HistoryData :[HistoryModel]? , _ errorMessage : String?) -> ())){
        
        BaseDataManager.makePostRequestWith(URL: ALDataManager.getHistoryListAPIURL(), parameters: parameter, callBack: {(data, error) in
            if let reterievedError = error {
                callBack(nil, reterievedError.errorMessage)
            }
            else{
                if let reterievedData = data, let status = reterievedData["status"] as? Bool, let bagsList = reterievedData["bags"] as? NSArray{
                    
                    if status{
                        var historyList = [HistoryModel]()
                        print(data)
                        for data in bagsList{
                            historyList.append(HistoryModel.init(historyData: data as! NSDictionary))
                        }
                        callBack(historyList, nil)
                    }
                    else
                    {
                        callBack(nil, reterievedData["message"] as? String ?? "Some error occured. Please try again later.")
                    }
                }
                else if let reterievedData = data, let _ = reterievedData["error"] as? String, let errorDescription = reterievedData["error_description"] as? String{
                    callBack(nil, errorDescription)
                }
                else if let reterievedData = data, let status = reterievedData["status"] as? Bool, !status, let errorMessage = reterievedData["message"] as? String{
                    callBack(nil, errorMessage)
                }
                else{
                    callBack(nil, "Some error occured. Please try again later.")
                }
            }
        })
    }
}
