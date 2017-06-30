//
//  LoginViewModel.swift
//  AubryLane
//
//  Created by day on 28/04/17.
//  Copyright © 2017 day. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {
    
    let loginDataManager = LoginDataManager()
    
    var errorMessage : String?
    
    func validateLoginValueWith(emailID : String?, password : String?) -> String?{
        
        if let emailID = emailID, let password = password{
            
            if emailID.characters.count == 0 {
                return "Please enter your mail Id."
            }
            else if password.characters.count == 0{
                return "Please enter your password."
            }
            else if password.characters.count < 8{
                return "Pasword must contain 8 digits with letters and numbers."
            }
            else if !ALConstantMethods.isValidEmailWith(emailID: emailID){
                return "Please enter valid EmailID."
            }
            return nil
        }
        return "Some error occured. Please try again later."
    }
    
    
    func logInUserWith(userName : String, password : String, callBack : @escaping ((Void) -> (Void))){
        
        let parameters = "grant_type=password&username=\(userName)&password=\(password)&device=android"
        
        loginDataManager.loginUserWith(parameter: parameters, callBack: {
            (accessToken, accessTokenType, userName, errorMessage) in
            if let errorMessage = errorMessage{
                self.errorMessage = errorMessage
                callBack()
            }
            else
            {
                self.errorMessage = nil
                //Show The Next View Controller...
                ALConstantMethods.saveUserDataWith(isUserLoggedIn: true, emailID: nil, userName: userName, password: nil, bearerToken: accessToken, bearerTokenType: accessTokenType)
                callBack()
            }
        })
    }
}
