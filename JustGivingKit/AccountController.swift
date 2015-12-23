//
//  AccountController.swift
//  JustGivingKit
//
//  Created by Matthew Cheetham on 22/12/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

import UIKit
import ThunderRequest

/**
The account controller is responsible for performing operations on a user account such as resetting the password
*/
public class AccountController: NSObject {
    
    /**
     Submits a request for a password reminder for the given email address
     - parameter emailAddress: The email address to request the reset for
     - parameter completion: A completion block to fire once the request is completed. The block contains an error object if an error occurs.
     */
    public func requestPasswordReminder(emailAddress: String!, completion: (error: NSError?) -> Void) {
        
        JGSession.sharedSession().requestController.get("account/\(emailAddress)/requestpasswordreminder") { (response: TSCRequestResponse?, error: NSError?) -> Void in
            
            if let requestError = error {
                
                if let responseArray = response?.array, let errorDictionary = responseArray.first, let errorDescription = errorDictionary["desc"] as? String {
                    
                    completion(error: NSError(domain: requestError.domain, code: requestError.code, userInfo: [NSLocalizedDescriptionKey: errorDescription]))
                    return
                }

                completion(error: requestError)
                return
            }
            
            completion(error: nil)
            return
        }
        
    }
    
    /**
    Changes the authenticated users password
    - parameter emailAddress: The email address to change the password for
    - parameter currentPassword: The current password the user has set on their account
    - parameter newPassword: The password that you wish to assign to their account
    - parameter completion: A completion block to fire once the request is completed. This block contains an error object if an error occurs or the change was unseccessful
    */
    public func changePassword(emailAddress: String!, currentPassword: String!, newPassword: String!, completion: (error: NSError?) -> Void) {
        
        JGSession.sharedSession().requestController.post("account/password", bodyParams: ["currentPassword": currentPassword, "newPassword": newPassword, "emailAddress": emailAddress]) { (response: TSCRequestResponse?, error: NSError?) -> Void in
            
            if let requestError = error {
                
                completion(error: requestError)
            }
            
            if let responseDictionary = response?.dictionary, responseBool = responseDictionary["success"] as? Bool {
                
                if responseBool == false {
                    
                    completion(error: NSError(domain: "com.threesidedcube.JustGivingKit", code: 401, userInfo: [NSLocalizedDescriptionKey: "The email and password combination given was incorrect"]))
                    return
                }
                
                completion(error: nil)
                return
                
            }
            
        }
        
    }
    
    /**
     Loads information about a the currently authenticated user
     */
    public func retrieveUserAccountInformation(completion: (user: JGUser?, error: NSError?) -> Void) {
        
        JGSession.sharedSession().requestController.get("account") { (response: TSCRequestResponse?, error: NSError?) -> Void in
            
            if let requestError = error {
                
                completion(user: nil, error: requestError)
                return
            }
            
            guard let responseDictionary = response?.dictionary as? [String: AnyObject] else {
                
                completion(user: nil, error: NSError(domain: "com.threesidedcube.JustGivingKit", code: 500, userInfo: [NSLocalizedDescriptionKey: "The server did not return valid data for a user account"]))
                return
            }
            
            let user = JGUser(dictionary: responseDictionary)
            
            completion(user: user, error: nil)
            return
            
        }
        
    }
}
