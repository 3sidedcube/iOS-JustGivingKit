//
//  Avatar.swift
//  JustGivingKit
//
//  Created by Matthew Cheetham on 22/12/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

import UIKit

/**
An object representation of a avatar image. This is commonly assosciated with a user object
*/
public class Avatar: NSObject {
    
    /**
    A key defined by the JustGiving API that describes the image. Often referencing the size. E.G. Size150x150Face
    */
    public var key: String?
    
    /**
    A URL to load the image asset from
    */
    public var imageURL: NSURL?
    
    /**
    Initialises the object from a dictionary supplied by the JustGiving API
    - parameter dictionary: A dictionary object from the JustGiving API
    */
    internal init(dictionary: [String: AnyObject]) {

        key = dictionary["Key"] as? String
        
        if let urlString = dictionary["Value"] as? String {
            imageURL = NSURL(string: urlString)
        }
        
    }

}
