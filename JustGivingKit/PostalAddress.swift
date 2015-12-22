//
//  PostalAddress.swift
//  JustGivingKit
//
//  Created by Matthew Cheetham on 22/12/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

import UIKit

/**
An object representation of an address. This will most commonly be asssosciated with a user object
*/
public class PostalAddress: NSObject {

    /**
    The first line of an address. Usually the house number and street name
    */
    public var street: String?
    
    /**
    The city in the address
    */
    public var city: String?
    
    /**
    The state or county in the address
    */
    public var state: String?
    
    /**
    The postal code (Post Code or Zip)
    */
    public var postalCode: String?
    
    /**
    The country in the address
    */
    public var country: String?
    
    /**
     Initialises the object from a dictionary supplied by the JustGiving API
     - parameter dictionary: A dictionary object from the JustGiving API
     */
    internal init(dictionary: [String: AnyObject]) {
        
        street = dictionary["line1"] as? String
        city = dictionary["townOrCity"] as? String
        state = dictionary["countyOrState"] as? String
        postalCode = dictionary["postcodeOrZipcode"] as? String
        country = dictionary["country"] as? String
        
    }
    
}

