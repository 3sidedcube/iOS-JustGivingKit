//
//  MonetaryAmount.swift
//  JustGivingKit
//
//  Created by Matthew Cheetham on 22/12/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

import UIKit

/**
Represents a collection of donations as a total with currency information.
*/
public class MonetaryAmount: NSObject {
    
    /**
    The amount of units for this currency
    */
    public let amount: Double?
    
    /**
    Not documented in the JustGiving API
    */
    public let currencyCode: Int?
    
    /**
    The currency symbol to be displayed with the amount
    */
    public let currencySymbol: String?
    
    /**
     Initialises the object from a dictionary supplied by the JustGiving API
     - parameter dictionary: A dictionary object from the JustGiving API
     */
    internal init(dictionary: [String: AnyObject]) {
        
        amount = dictionary["amount"] as? Double
        currencyCode = dictionary["currencyCode"] as? Int
        currencySymbol = dictionary["currencySymbol"] as? String
        
    }

}
