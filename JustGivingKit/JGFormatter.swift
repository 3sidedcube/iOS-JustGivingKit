//
//  JGFormatter.swift
//  JustGivingKit
//
//  Created by Matthew Cheetham on 11/12/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

import Foundation

/**
The formatter is responsible for converting enums to values and back
*/
public class JGFormatter: NSObject {
    
    /**
    Converts an activityType enum into an String that can be passed to the JustGiving API
    - parameter activityType: The activity type in enum form to be converted
    - returns: A string that can be passed to the JustGiving API
    */
    public class func stringForActivityType(activityType: JGFundraisingActivityType) -> String {
        
        switch activityType {
        case .RunningMarathon:
            return "Running_Marathons"
        case .Trek:
            return "Treks"
        case .Walk:
            return "Walks"
        case .Cycling:
            return "Cycling"
        case .Swimming:
            return "Swimming"
        case .Birthday:
            return "Birthday"
        case .Wedding:
            return "Wedding"
        case .OtherCelebration:
            return "OtherCelebration"
        case .Christening:
            return "Christening"
        case .InMemory:
            return "InMemory"
        case .Anniversary:
            return "Anniversaries"
        case .Triathalon:
            return "Triathalons"
        case .ParachutingSkydive:
            return "Parachuting_Skydives"
        case .OtherSportingEvent:
            return "OtherSportingEvents"
        case .NewYearsResolution:
            return "NewYearsResolutions"
        case .Christmas:
            return "Christmas"
        case .OtherPersonalChallenge:
            return "OtherPersonalChallenge"
        case .CharityAppeal:
            return "CharityAppeal"
        case .IndividualAppeal:
            return "IndividualAppeal"
        case .CompanyAppeal:
            return "CompanyAppeal"
        case .PersonalRunningMarathon:
            return "PersonalRunning_Marathons"
        case .PersonalTrek:
            return "PersonalTreks"
        case .PersonalWalk:
            return "PersonalWalks"
        case .PersonalCycling:
            return "PersonalCycling"
        case .PersonalSwimming:
            return "PersonalSwimming"
        case .PersonalTriathalon:
            return "PersonalTriathlons"
        case .PersonalParachutingSkydive:
            return "PersonalParachuting_Skydives"
        case .Unknown:
            return "Unknown"
        }
        
    }
    
    /**
    Converts an activityType enum into an String that can be passed to the JustGiving API
    - parameter activityType: The activity type in enum form to be converted
    - returns: A string that can be passed to the JustGiving API
    */
    public class func activityTypeForString(activityString: String) -> JGFundraisingActivityType {
        
        switch activityString {
            
        case "Running_Marathons":
            return .RunningMarathon
        case "Treks":
            return .Trek
        case "Walks":
            return .Walk
        case "Cycling":
            return .Cycling
        case "Swimming":
            return .Swimming
        case "Birthday":
            return .Birthday
        case "Wedding":
            return .Wedding
        case "OtherCelebration":
            return .OtherCelebration
        case "Christening":
            return .Christening
        case "InMemory":
            return .InMemory
        case "Anniversaries":
            return .Anniversary
        case "Triathalons":
            return .Triathalon
        case "Parachuting_Skydives":
            return .ParachutingSkydive
        case "OtherSportingEvents":
            return .OtherSportingEvent
        case "NewYearsResolutions":
            return .NewYearsResolution
        case "Christmas":
            return .Christmas
        case "OtherPersonalChallenge":
            return .OtherPersonalChallenge
        case "CharityAppeal":
            return .CharityAppeal
        case "IndividualAppeal":
            return .IndividualAppeal
        case "CompanyAppeal":
            return .CompanyAppeal
        case "PersonalRunning_Marathons":
            return .PersonalRunningMarathon
        case "PersonalTreks":
            return .PersonalTrek
        case "PersonalWalks":
            return .PersonalWalk
        case "PersonalCycling":
            return .PersonalCycling
        case "PersonalSwimming":
            return .PersonalSwimming
        case "PersonalTriathlons":
            return .PersonalTriathalon
        case "PersonalParachuting_Skydives":
            return .PersonalParachutingSkydive
        case "Unknown":
            return .Unknown
        default:
            return .Unknown
        }
    }
}

extension NSDate {
    
    /**
     Initialises a new date from an OData DateTime string (E.g. /Date(1278688766000+0000)/)
     - parameter ODataString: The OData DateTime string to convert to NSDate
     */
    convenience init(ODataString: String!) {
        
        let regex = try? NSRegularExpression(pattern: "[0-9]+(?:[0-9]*)?", options: .CaseInsensitive)

        if let dateRegex = regex {
            
            let firstRange = dateRegex.rangeOfFirstMatchInString(ODataString, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, ODataString.characters.count))
        
            if NSEqualRanges(firstRange, NSMakeRange(NSNotFound, 0)) {
                
                let oDataStringAsNSString = ODataString as NSString
                let matchingSubstring = oDataStringAsNSString.substringWithRange(firstRange)
                
                if let timestampDouble = Double(matchingSubstring) {
                    
                    self.init(timeIntervalSince1970: timestampDouble)
                    return
                }
                
            }
            
        }
        
        self.init()
        
    }

}