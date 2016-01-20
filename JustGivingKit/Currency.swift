//
//  Currency.swift
//  JustGivingKit
//
//  Created by Matthew Cheetham on 23/12/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

import UIKit

/**
An object representation of a supported currency in the JustGiving API
*/
public class Currency: NSObject {
    
    /**
    An description of the currency in English
    */
    public var name: String?
    
    /**
    The symbol used to represent this currency when written down
    */
    public var symbol: String?
    
    /**
    The 3 letter currency code
    */
    public var code: String?
    
    public init(dictionary: [String: AnyObject]) {
        
        name = dictionary["description"] as? String
        symbol = dictionary["currencySymbol"] as? String
        code = dictionary["currencyCode"] as? String
    }

    public override init () {
        
    }
    
    public func serialisableRepresentation() -> [String: AnyObject] {
        
        var serialisable = [String : AnyObject]()
        
        if let aName = name {
            serialisable["description"] = aName
        }
        
        if let aSymbol = symbol {
            serialisable["currencySymbol"] = aSymbol
        }
        
        if let aCode = code {
            serialisable["currencyCode"] = aCode
        }
        
        return serialisable
    }
}
