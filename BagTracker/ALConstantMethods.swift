//
//  ALConstantMethods.swift
//  AubryLane
//
//  Created by day on 25/04/17.
//  Copyright © 2017 day. All rights reserved.
//

import UIKit

let textFieldKeyBoardOffset = 10


struct ALConstantsStrings {
    struct UserDefaultKeys{
        static let userLoggedInKey = "UserLoggedIn"
        static let userEmailIDKey = "UserEmailID"
        static let userNameKey = "UserNameKey"
        static let userAccessTokenKey = "UserAccessToken"
        static let userAccessTokenTypeKey = "UserAccessTokenType"
    }
}


class ALConstantMethods: NSObject {
    
    class func isUserLoggedIn()-> Bool{
        return UserDefaults.standard.bool(forKey: ALConstantsStrings.UserDefaultKeys.userLoggedInKey)
    }
    
    class func getRegisteredUserName() -> String{
        return UserDefaults.standard.value(forKey: ALConstantsStrings.UserDefaultKeys.userNameKey) as! String
        
    }
    
    class func switchLoginRegisterViewWith(_ controller : UINavigationController) {
        var viewControllers = controller.viewControllers
        if viewControllers.count > 1{
            viewControllers[0...1] = [viewControllers[1]]
            controller.setViewControllers(viewControllers, animated: false)
        }
    }
    
    class func showAlertWith(message : String, parentController : UIViewController, okButtonCallback:((Void) -> (Void))?){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in
            if let buttonCallBack = okButtonCallback{
                buttonCallBack()
            }
        }))
        parentController.present(alert, animated: true, completion: nil)
    }
    
    class func isValidEmailWith(emailID:String)-> Bool {
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: emailID)
        return result
    }
    
    
    class func shiftKeyBoardFor(textFieldFrame : CGRect, keyboardHeight : CGFloat, isKeyBoardShown : Bool, parentView : UIView){
        
        let textFieldExtremeYLimit = textFieldFrame.origin.y + textFieldFrame.size.height
        let screenCordinateBelowKeyboard = UIScreen.main.bounds.size.height - keyboardHeight
        if  isKeyBoardShown && screenCordinateBelowKeyboard > textFieldExtremeYLimit &&  screenCordinateBelowKeyboard - textFieldExtremeYLimit > 10{
            return
        }
       let textFieldFrame = abs(screenCordinateBelowKeyboard - textFieldExtremeYLimit) + CGFloat(textFieldKeyBoardOffset)
        UIView.animate(withDuration: 0.5, animations: {
            parentView.frame = CGRect(x: 0.0, y: isKeyBoardShown ? -textFieldFrame: 0.0, width: parentView.frame.size.width, height: parentView.frame.size.height)
        })
    }
    
    
    class func refreshAppWindow(){
        if let appDelegateInstance = UIApplication.shared.delegate as? AppDelegate{
            appDelegateInstance.setHomeViewController()
        }
    }
    
    class func getViewControllerWith(storyBoardID : String, viewControllerID : String) -> UIViewController{
        let storyboard = UIStoryboard(name: storyBoardID, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerID)
        return viewController
    }
    
    
    class func saveUserDataWith(isUserLoggedIn : Bool, emailID : String?, userName : String?, password : String?, bearerToken : String?, bearerTokenType : String?){
        
        //Set User Status For Logged In Value...
        UserDefaults.standard.set(isUserLoggedIn, forKey: ALConstantsStrings.UserDefaultKeys.userLoggedInKey)
        
        //Set User Access Token Value...
        if let accessToken = bearerToken{
            UserDefaults.standard.set(accessToken, forKey: ALConstantsStrings.UserDefaultKeys.userAccessTokenKey)
        }
        
        //Set User Access Token Type Value...
        if let accessTokenType = bearerTokenType{
            UserDefaults.standard.set(accessTokenType, forKey: ALConstantsStrings.UserDefaultKeys.userAccessTokenTypeKey)
        }
        
        //Set User Name Type Value...
        UserDefaults.standard.set(userName ?? "", forKey: ALConstantsStrings.UserDefaultKeys.userNameKey)
        
        UserDefaults.standard.synchronize()
       
        //In Case We Need To Save User Name, Email ID In Future... 
        //UnComment This One...
        
        /*
        //Set User Email Key...
        if let emailID = emailID{
            UserDefaults.standard.set(emailID, forKey: ALConstantsStrings.UserDefaultKeys.userEmailIDKey)
        }
        
        //Set User Name Key...
        if let userName = userName{
            UserDefaults.standard.set(userName, forKey: ALConstantsStrings.UserDefaultKeys.userNameKey)
        }
        */
        
    }
}
