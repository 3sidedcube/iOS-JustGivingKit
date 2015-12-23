//
//  JGFundraisingController.swift
//  JustGivingKit
//
//  Created by Matthew Cheetham on 23/12/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

import UIKit

/**
Responsible for handling all interactions with fundraising pages
*/
public extension JGFundraisingController {
    
    public func getSupportedCurrencies(completion: (currencies: [Currency]?, error: NSError?) -> Void) {
     
        JGSession.sharedSession().requestController.get("fundraising/currencies") { (response: TSCRequestResponse?, error: NSError?) -> Void in
            
            if let requestError = error {
                completion(currencies: nil, error: requestError)
                return
            }
            
            if let currenciesDictArray = response?.array as? [[String: AnyObject]] {
                
                let currencies = currenciesDictArray.map({
                    Currency(dictionary: $0)
                })
                
                completion(currencies: currencies, error: nil)

            }
            
        }
        
    }

}
