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
}
