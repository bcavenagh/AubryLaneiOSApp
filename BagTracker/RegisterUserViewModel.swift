//
//  RegisterUserViewModel.swift
//  AubryLane
//
//  Created by day on 01/05/17.
//  Copyright © 2017 day. All rights reserved.
//

import UIKit

class RegisterUserViewModel: NSObject {
    
    func validateRegisterUserWith(userName : String?, emailID : String?, password : String?, rePassWord : String?, acceptedTC : Bool?) -> String?{
        
        print("Email id is \(String(describing: emailID)) password is \(String(describing: password))")
        
        print("user name is \(String(describing: userName)) rePassWord is \(String(describing: rePassWord))")
        
        if let emailID = emailID, let userName = userName, let password = password, let rePassWord = rePassWord{
            
            if userName.characters.count == 0 {
                return "Please enter your user name."
            }
            else if emailID.characters.count == 0 {
                return "Please enter your mail Id."
            }
            else if password.characters.count == 0{
                return "Please enter your password."
            }
            else if rePassWord.characters.count == 0{
                return "Please enter your re password."
            }
            else if password.characters.count < 8{
                return "Password must be 8 character with letters and numbers."
            }
            else if rePassWord.characters.count < 8 {
                return "rePassword must be 8 character with letters and numbers."
            }
            else if !ALConstantMethods.isValidEmailWith(emailID: emailID){
                return "Please enter valid EmailID."
            }
            else if password.characters.count != rePassWord.characters.count || password != rePassWord {
                return "Password and rePassword not matching. Please try again."
            }
            else if acceptedTC == false{
                print("Not accepted")
                return "You must accept the Terms & Conditons"
            }
            return nil
        }
        return "Some error occured. Please try again later."
    }
}
