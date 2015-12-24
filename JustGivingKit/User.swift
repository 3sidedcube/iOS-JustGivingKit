//
//  User.swift
//  JustGivingKit
//
//  Created by Matthew Cheetham on 22/12/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

import UIKit

/**
A model representation of a user in the JustGiving API.
*/
public class User: NSObject {
    
    /**
    The first name on the account
    */
    public var firstName: String?
    
    /**
    The last name on the account 
    */
    public var lastName: String?
    
    /**
    The email address on the account
    */
    public var email: String?
    
    /**
    The number of active fundraising pages on the account
    */
    public var numberOfActivePages: Int?
    
    /**
    The number of completed fundraising pages on the account
    */
    public var numberOfCompletedPages: Int?
    
    /**
    Not documented in JustGiving API
    */
    public var totalGiftAid: Double?
    
    /**
    Not documented in JustGiving API
    */
    public var totalDonatedGiftAid: Double?
    
    /**
    An array of Avatar objects representing images available for the profile image on this account
    */
    public var profileImages: [Avatar]?
    
    /**
    The address listed on the account
    */
    public var address: PostalAddress?
    
    /**
    The date the user joined
    */
    public var joinDate: NSDate?
    
    /**
    Not documented in JustGiving API
    */
    public var donationTotalsInSupportedCurrencies: [MonetaryAmount]?
    
    /**
    Not documented in JustGiving API
    */
    public var raisedTotalsInSupportedCurrencies: [MonetaryAmount]?

    /**
    Not documented in JustGiving API
    */
    public var accountTypes: [String]?
    
    /**
    Not documented in JustGiving API
    */
    public var userId: String?
    
    /**
    Not documented in JustGiving API
    */
    public var accountID: Int?
    
    /**
    Not documented in JustGiving API
    */
    public var errorMessage: String?
    
    /**
     Initialises the object from a dictionary supplied by the JustGiving API
     - parameter dictionary: A dictionary object from the JustGiving API
     */
    public init(dictionary: [String: AnyObject]) {
        
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
        email = dictionary["email"] as? String
        numberOfActivePages = dictionary["activePageCount"] as? Int
        numberOfCompletedPages = dictionary["completedPagesCount"] as? Int
        totalGiftAid = dictionary["totalDonated"] as? Double
        totalDonatedGiftAid = dictionary["totalDonatedGiftAid"] as? Double
        
        if let imageURLArray = dictionary["profileImageUrls"] as? [[String: AnyObject]] {
            
            profileImages = imageURLArray.map({
                Avatar(dictionary: $0)
            })
        }
        
        if let addressDictionary = dictionary["address"] as? [String: AnyObject] {
            address = PostalAddress(dictionary: addressDictionary)
        }
        
        if let joinDateString = dictionary["joinDate"] as? String {
            
            joinDate = NSDate(ODataString: joinDateString)
        }
        
        if let donationTotalsArray = dictionary["donationTotalsInSupportedCurrencies"] as? [[String: AnyObject]] {
            
            donationTotalsInSupportedCurrencies = donationTotalsArray.map({
                MonetaryAmount(dictionary: $0)
            })
        }
        
        if let raisedTotalsArray = dictionary["raisedTotalsInSupportedCurrencies"] as? [[String: AnyObject]] {
            
            raisedTotalsInSupportedCurrencies = raisedTotalsArray.map({
                MonetaryAmount(dictionary: $0)
            })
        }
        
        accountTypes = dictionary["accountTypes"] as? [String]
        userId = dictionary["userId"] as? String
        accountID = dictionary["accountId"] as? Int
        errorMessage = dictionary["errorMessage"] as? String
        
    }
}
