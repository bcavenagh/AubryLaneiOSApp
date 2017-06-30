//
//  BaseDataManager.swift
//  AubryLane
//
//  Created by day on 01/05/17.
//  Copyright © 2017 day. All rights reserved.
//

import UIKit
import Alamofire

struct ALDataManager {
    
    static let serverURL = "http://132.148.89.30/"
    
    struct WebServiceKeys{
        static let LoginAPIKey = "token"
        static let BagsListAPIKey = "api/v1/bags"
        static let HistoryListAPIKey = "api/v1/runningData"
    }
    
    static func getLoginAPIURL() -> URL{
        return URL.init(string: ALDataManager.serverURL + ALDataManager.WebServiceKeys.LoginAPIKey)!
    }
    static func getBagsListAPIURL() -> URL{
        return URL.init(string: ALDataManager.serverURL + ALDataManager.WebServiceKeys.BagsListAPIKey)!
    }
    static func getHistoryListAPIURL() -> URL{
        return URL.init(string: ALDataManager.serverURL + ALDataManager.WebServiceKeys.HistoryListAPIKey)!
    }
}

class ALCustomError {
    
    var errorCode : String
    var errorMessage : String
    
    init(errorMessage : String) {
        self.errorCode = "0"
        self.errorMessage = errorMessage
    }
    
    init(error : NSError) {
        self.errorCode = "\(error.code)"
        self.errorMessage = error.localizedDescription
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




class BaseDataManager {
    
    class func makePostRequestWith(URL : URL, parameters : String, callBack :@escaping ((_ data : [String:Any]?, _ error : ALCustomError?) -> ())) {
        
        var request = URLRequest(url: URL)
        
        let data = parameters.data(using: String.Encoding.ascii, allowLossyConversion: true)
        
        request.httpMethod = HTTPMethod.post.rawValue
        
        if let accessToken =  UserDefaults.standard.value(forKey: ALConstantsStrings.UserDefaultKeys.userAccessTokenKey), let accessTokenType =  UserDefaults.standard.value(forKey: ALConstantsStrings.UserDefaultKeys.userAccessTokenTypeKey){
            request.setValue("\(accessTokenType) \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        else
        {
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        }
        
        request.httpBody = data
        
        Alamofire.request(request).responseJSON {
            (response) in
            
            //Parse The Response Data From The Web Service Call...
            do {
                if let error = response.error as? NSError{
                    //Send The Response Error From The Web Service Call...
                    callBack(nil, ALCustomError.init(error: error))
                }
               else if let data = response.data{
                    let decoded = try JSONSerialization.jsonObject(with: data, options: [])
                    let currentConditions = decoded as! [String:Any]
                    //Send The Response Data From The Web Service Call...
                    callBack(currentConditions, nil)
                }
            } catch {
                    //Send The Response Error From The Web Service Call...
                    callBack(nil, ALCustomError.init(error: (error as NSError?)!))
              }
        }
    }
    
    
    class func makeGetRequestWith(URL : URL, parameters : String?, callBack :@escaping ((_ data : [String:Any]?, _ error : ALCustomError?) -> ())) {
        
        var request = URLRequest(url: URL)
        
        if let postData = parameters{
            let data = postData.data(using: String.Encoding.ascii, allowLossyConversion: true)
            request.httpBody = data
        }
        
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        if let accessToken =  UserDefaults.standard.value(forKey: ALConstantsStrings.UserDefaultKeys.userAccessTokenKey), let accessTokenType =  UserDefaults.standard.value(forKey: ALConstantsStrings.UserDefaultKeys.userAccessTokenTypeKey){
            request.setValue("\(accessTokenType) \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        Alamofire.request(request).responseJSON {
            (response) in
            
            //Parse The Response Data From The Web Service Call...
            do {
                if let error = response.error as? NSError{
                    //Send The Response Error From The Web Service Call...
                    callBack(nil, ALCustomError.init(error: error))
                }
                else if let data = response.data{
                    let decoded = try JSONSerialization.jsonObject(with: data, options: [])
                    let currentConditions = decoded as! [String:Any]
                    //Send The Response Data From The Web Service Call...
                    callBack(currentConditions, nil)
                }
            } catch {
                //Send The Response Error From The Web Service Call...
                callBack(nil, ALCustomError.init(error: (error as NSError?)!))
            }
        }
    }
    
    class func makeSimpleGetRequestWith(URL : URL, parameters : String?, callBack :@escaping ((_ data : NSDictionary?, _ error : ALCustomError?) -> ())) {
        
        var request = URLRequest(url: URL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        Alamofire.request(request).responseJSON {
            (response) in
            
            //Parse The Response Data From The Web Service Call...
            do {
                if let error = response.error as? NSError{
                    //Send The Response Error From The Web Service Call...
                    callBack(nil, ALCustomError.init(error: error))
                }
                else if let data = response.data{
                    let decoded = try JSONSerialization.jsonObject(with: data, options: [])
                    let currentConditions = decoded as! NSDictionary
                    //Send The Response Data From The Web Service Call...
                    callBack(currentConditions, nil)
                }
            } catch {
                //Send The Response Error From The Web Service Call...
                callBack(nil, ALCustomError.init(error: (error as NSError?)!))
            }
        }
    }
    
}
