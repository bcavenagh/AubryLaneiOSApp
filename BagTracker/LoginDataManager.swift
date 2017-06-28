//
//  LoginDataManager.swift
//  AubryLane
//
//  Created by day on 01/05/17.
//  Copyright © 2017 day. All rights reserved.
//

import UIKit
import Alamofire

class LoginDataManager: NSObject {

    func loginUserWith(parameter : String, callBack :@escaping ((_ bearerToken : String?, _ bearerTokenType : String?, _ userName : String?, _ errorMessage : String?) -> ())){
        
        BaseDataManager.makePostRequestWith(URL: ALDataManager.getLoginAPIURL(), parameters: parameter, callBack: {(data, error ) in
            
            if let reterievedError = error {
                callBack(nil, nil, nil, reterievedError.errorMessage)
            }
            else{
                if let reterievedData = data, let accessToken = reterievedData["access_token"] as? String, let accessTokenType = reterievedData["token_type"] as? String{
                    callBack(accessToken, accessTokenType, "\(reterievedData["FirstName"] ?? "") \(reterievedData["LastName"] ?? "")", nil)
                }
                else if let reterievedData = data, let _ = reterievedData["error"] as? String, let errorDescription = reterievedData["error_description"] as? String{
                    callBack(nil, nil, nil, errorDescription)
                }
            }
        })
    }
}

