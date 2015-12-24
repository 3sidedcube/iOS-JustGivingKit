//
//  JGDonationController.swift
//  JustGivingKit
//
//  Created by Matthew Cheetham on 23/12/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

import UIKit

/**
Handles loading of donations in the JustGiving API
*/
public extension JGDonationController {
    
    /**
    Gets an array of donations for a fundraising page. Results are paginated and will be loaded 50 at a time, you can load more by using the pageNumber parameter
    - parameter fundraisingPage: The fundraising page to load donations for. This starts at 1.
    - parameter pageNumber: The page number to load. Used for basic pagination.
    - parameter completion: The closure to call when the request succeeds or fails
    */
    public func getDonationsForFundraisingPage(fundraisingPage: JGFundraisingPage!, pageNumber: Int!, completion: (donations: [Donation]?, error: NSError?) -> Void) {
        
        JGSession.sharedSession().requestController.get("account/donations?pagenum=\(pageNumber)") { (response: TSCRequestResponse?, error: NSError?) -> Void in
            
            if let requestError = error {
                
                completion(donations: nil, error: requestError)
                return
            }
            
            if let responseDictionary = response?.dictionary as? [String: AnyObject], let donationsArray = responseDictionary["donations"] as? [[String: AnyObject]] {
                
                let donations = donationsArray.map({
                    Donation(dictionary: $0)
                }) as? [Donation]
                
                completion(donations: donations, error: nil)
                return
                
            }
            
            let error = NSError(domain: "com.threesidedcube.JustGivingKit", code: 204, userInfo: [NSLocalizedDescriptionKey: "No donations found"])
            completion(donations: nil, error: error)
        }
        
    }
    
    /**
    Loads a detailed donation object for a donation ID
    - parameter donationId: The unique identifier for the donation to look up in the JustGiving API
    - parameter completion: The closure to call when the request succeeds or fails. Contains a `JGDonation` object.
    */
    public func getDonation(donationId: Int!, completion: (donation: Donation?, error: NSError?) -> Void) {
        
        JGSession.sharedSession().requestController.get("donation/\(donationId)") { (response: TSCRequestResponse?, error: NSError?) -> Void in
            
            if let requestError = error {
                
                completion(donation: nil, error: requestError)
                return
            }
            
            if let responseDictionary = response?.dictionary as? [String: AnyObject] {
                
                let donation = Donation(dictionary: responseDictionary)
                completion(donation: donation, error: nil)

            }
            
            let error = NSError(domain: "com.threesidedcube.JustGivingKit", code: 500, userInfo: [NSLocalizedDescriptionKey: "The JustGiving API did not return a valid donation"])
            completion(donation: nil, error: error)
            return
        }
        
    }

}
