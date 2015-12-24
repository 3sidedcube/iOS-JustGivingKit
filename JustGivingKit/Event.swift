//
//  Event.swift
//  JustGivingKit
//
//  Created by Matthew Cheetham on 03/11/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

import UIKit

/**
An event returned by the API after running a search
*/
public class Event: NSObject {
    
    /**
    The unique identifier for the event. Also known as the event ID
    */
    public var eventIdentifier: String?
    
    /**
    The event name as shown on the event page
    */
    public var eventName: String?
    
    /**
    The event description as shown on the event page
    */
    public var eventDescription: String?
    
    convenience public init(dictionary: [String: AnyObject]) {
        
        self.init()
        
        eventIdentifier = dictionary["Id"] as? String
        eventName = dictionary["Name"] as? String
        eventDescription = dictionary["Description"] as? String
        
    }

}
