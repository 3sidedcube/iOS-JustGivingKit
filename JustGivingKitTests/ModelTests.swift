//
//  ModelTests.swift
//  JustGivingKit
//
//  Created by Matthew Cheetham on 23/12/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

import XCTest
import JustGivingKit

class ModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func loadDictionaryForFile(name: String!) -> [String: AnyObject]? {
        
        let jsonFilePath = NSBundle(forClass: self.dynamicType).pathForResource(name, ofType: "json")
        
        if let jsonPath = jsonFilePath, let jsonFileData = NSData(contentsOfFile: jsonPath) {
            
            do {
                if let jsonObject = try NSJSONSerialization.JSONObjectWithData(jsonFileData, options: NSJSONReadingOptions.MutableContainers) as? [String: AnyObject] {
                    
                    return jsonObject
                }
                
            } catch let error as NSError {
                
                print(error)
            }
        }
        
        return nil
    }
    
    func testPopulatingUserObjectFromStaticJSON() {
        
        let userObject = loadDictionaryForFile("RetrieveAccount")
        
        if let userDictionary = userObject {
            
            let user = User(dictionary: userDictionary)
            
            XCTAssertNotNil(user.firstName)
            XCTAssertNotNil(user.lastName)
            XCTAssertNotNil(user.email)
            XCTAssertEqual(user.numberOfActivePages, 1)
            XCTAssertEqual(user.numberOfCompletedPages, 5)
            XCTAssertEqual(user.totalGiftAid, 0)
            XCTAssertEqual(user.totalDonatedGiftAid, 12.5)
            XCTAssertEqual(user.profileImages?.count, 2)
            
            if let profileArray = user.profileImages {
                
                for avatar: Avatar in profileArray {
                    
                        XCTAssertNotNil(avatar.key)
                        XCTAssertNotNil(avatar.imageURL)                    
                }
                
            }
            
            XCTAssertNotNil(user.address)
            
            if let postalAddress = user.address {
                
                XCTAssertNotNil(postalAddress.street)
                XCTAssertNotNil(postalAddress.city)
                XCTAssertNotNil(postalAddress.state)
                XCTAssertNotNil(postalAddress.postalCode)
                XCTAssertNotNil(postalAddress.country)
                
            }
            
            XCTAssertNotNil(user.joinDate)
            
            if let date = user.joinDate {
                
                let jsonDate = NSCalendar.currentCalendar().dateWithEra(1, year: 2009, month: 11, day: 5, hour: 0, minute: 0, second: 0, nanosecond: 0)!
                
                XCTAssertTrue(date.isEqualToDate(jsonDate))
                
            }
            
            XCTAssertEqual(user.donationTotalsInSupportedCurrencies?.count, 3)
            
            if let donationTotalsArray = user.donationTotalsInSupportedCurrencies {
                
                for donationTotal: MonetaryAmount in donationTotalsArray {
                    
                    XCTAssertNotNil(donationTotal.amount)
                    XCTAssertNotNil(donationTotal.currencyCode)
                    XCTAssertNotNil(donationTotal.currencySymbol)
                }
                
            }

            XCTAssertEqual(user.raisedTotalsInSupportedCurrencies?.count, 2)
            
            if let raisedTotalsArray = user.raisedTotalsInSupportedCurrencies {
                
                for raisedTotal: MonetaryAmount in raisedTotalsArray {
                    
                    XCTAssertNotNil(raisedTotal.amount)
                    XCTAssertNotNil(raisedTotal.currencyCode)
                    XCTAssertNotNil(raisedTotal.currencySymbol)
                }
                
            }
            
            XCTAssertEqual(user.accountTypes?.count, 1)
            XCTAssertNotNil(user.userId)
            XCTAssertNotNil(user.accountID)
            XCTAssertNil(user.errorMessage)
            
            print(user)

        }
        
    }
    
}
