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
@objc(JGMonetaryAmount)
public class MonetaryAmount: NSObject {
    
    /**
    The amount of units for this currency
    */
    public var amount: Double = 0
    
    /**
    Not documented in the JustGiving API
    */
    public var currencyCode: Int?
    
    /**
    The currency as a three letter country code
    - note: This is not part of the JustGiving API so may not be available on all objects of this type
    */
    public var currencyCodeString: String?
    
    /**
    The currency symbol to be displayed with the amount
    */
    public var currencySymbol: String?
    
    /**
     Initialises the object from a dictionary supplied by the JustGiving API
     - parameter dictionary: A dictionary object from the JustGiving API
     */
    internal init(dictionary: [String: AnyObject]) {
        
        if let dictionaryAmount = dictionary["amount"] as? Double {
            amount = dictionaryAmount
        }
        currencyCode = dictionary["currencyCode"] as? Int
        currencySymbol = dictionary["currencySymbol"] as? String
        
    }
    
    override init() {
        
    }

}
