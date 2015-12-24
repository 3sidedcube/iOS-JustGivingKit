//
//  Donation.swift
//  JustGivingKit
//
//  Created by Matthew Cheetham on 24/12/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

import UIKit

/**
An object representation of a donation in the JustGiving API
*/
public class Donation: NSObject {
    
    /**
    The unique identifier for the donation
    */
    public var identifier: Int?
    
    /**
    The reference presented to the user on their donation receipt
    */
    public var reference: String?
    
    /**
    The image the user selected when leaving a message. Only available if the user has left a message with preferences that allow this information to be shared.
    */
    public var imageURL: NSURL?
    
    /**
    The date that the user made the donation
    */
    public var date: NSDate?
    
    /**
    The name the donor left with their donation message
    */
    public var donorDisplayName: String?
    
    /**
    The message the donor left with their donation. Only available if the authenticated user credentials match the page owner or if the donation preferences enable sharing this value on the web.
    */
    public var message: String?
    
    /**
    Not documented in JustGiving API
    */
    public var estimatedTaxReclaim: Double?
    
    /**
    Not documented in JustGiving API
    */
    public var amount: String?
    
    /**
    The real name of the donor. Only available if the authenticated user credentials match the page owner.
    */
    public var donorRealName: String?
    
    /**
    Reference attached to the donation via Simple Donation Integration
    */
    public var thirdPartyReference: String?
    
    /**
    The status of the donation. One of "Accepted", "Rejected", "Cancelled", "Refunded" or "Pending"
    */
    public var status: JGDonationStatus?
    
    /**
    The origin of the donation, one of "DirectDonations", "SponsorshipDonations", "Ipdd", "Sms" as an enum
    */
    public var source: JGDonationSource?
    
    /**
    The three letter currency code representing the currency this donation was made in
    */
    public var currencyCode: String?
    
    /**
    Not documented in JustGiving API
    */
    public var donorLocalAmount: String?
    
    /**
    Not documented in JustGiving API
    */
    public var donorLocalCurrencyCode: String?
    
    /**
    Not documented in JustGiving API
    */
    public var pageShortName: String?
    
    /**
     Not documented in JustGiving API
     */
    public var pageOwnerName: String?
    
    /**
     Not documented in JustGiving API
     */
    public var pageTitle: String?
    
    /**
     Not documented in JustGiving API
     */
    public var paymentType: String?
    
    /**
     Initialises the object from a dictionary supplied by the JustGiving API
     - parameter dictionary: A dictionary object from the JustGiving API
     */
    public init(dictionary: [String: AnyObject]) {
        
        identifier = dictionary["id"] as? Int
        reference = dictionary["donationRef"] as? String
        
        if let imageString = dictionary["image"] as? String {
            imageURL = NSURL(string: imageString)
        }
        
        if let dateString = dictionary["donationDate"] as? String {
            date = NSDate(ODataString: dateString)
        }
        
        donorDisplayName = dictionary["donorDisplayName"] as? String
        message = dictionary["message"] as? String
        estimatedTaxReclaim = dictionary["estimatedTaxReclaim"] as? Double
        amount = dictionary["amount"] as? String
        donorRealName = dictionary["donorRealName"] as? String
        thirdPartyReference = dictionary["thirdPartyReference"] as? String
        
        if let donationStatus = dictionary["status"] as? String {
            status = JGFormatter.donationStatusForString(donationStatus)
        }
        
        if let donationSource = dictionary["source"] as? String {
            source = JGFormatter.donationSourceForString(donationSource)
        }
        
        currencyCode = dictionary["currencyCode"] as? String
        donorLocalAmount = dictionary["donorLocalAmount"] as? String
        donorLocalCurrencyCode = dictionary["donorLocalCurrencyCode"] as? String
        pageShortName = dictionary["pageShortName"] as? String
        pageOwnerName = dictionary["pageOwnerName"] as? String
        pageTitle = dictionary["pageTitle"] as? String
        paymentType = dictionary["paymentType"] as? String
        
    }

}
