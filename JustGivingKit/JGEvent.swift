//
//  JGEvent.swift
//  JustGivingKit
//
//  Created by Matthew Cheetham on 03/11/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

import UIKit

public class JGEvent: NSObject {
    
    public var eventIdentifier: String?
    public var eventName: String?
    public var eventDescription: String?
    
    convenience public init(dictionary: [String: AnyObject]) {
        
        self.init()
        
        eventIdentifier = dictionary["Id"] as? String
        eventName = dictionary["Name"] as? String
        eventDescription = dictionary["Description"] as? String
        
    }

}
