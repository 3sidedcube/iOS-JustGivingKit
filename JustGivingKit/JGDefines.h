//
//  JGDefines.h
//  JustGivingKit
//
//  Created by Sam Houghton on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const JGAPIBaseAddress = @"https://api.justgiving.com";
static NSString * const JGAPISandboxBaseAddress = @"https://api-sandbox.justgiving.com";

/** A list of possible activityTypes for a `JGFundraisingPage` */
typedef NS_ENUM(NSInteger, JGFundraisingActivityType) {
    /** An unknown event type */
    JGFundraisingActivityTypeUnknown = 0,
    /** Running a Marathon */
    JGFundraisingActivityTypeRunningMarathon = 1,
    /** A trek event */
    JGFundraisingActivityTypeTrek = 2,
    /** A walking event */
    JGFundraisingActivityTypeWalk = 3,
    /** A cycling event */
    JGFundraisingActivityTypeCycling = 4,
    /** A swimming event */
    JGFundraisingActivityTypeSwimming = 5,
    /** A birthday event */
    JGFundraisingActivityTypeBirthday = 6,
    /** A wedding */
    JGFundraisingActivityTypeWedding = 7,
    /** Any other type of celebration */
    JGFundraisingActivityTypeOtherCelebration = 8,
    /** A Christening */
    JGFundraisingActivityTypeChristening = 9,
    /** An event in memory of someone */
    JGFundraisingActivityTypeInMemory = 10,
    /** An anniversary event */
    JGFundraisingActivityTypeAnniversary = 11,
    /** A triathalon event */
    JGFundraisingActivityTypeTriathalon = 12,
    /** A parachuting Skydive event */
    JGFundraisingActivityTypeParachutingSkydive = 13,
    /** Any other type of sporting event */
    JGFundraisingActivityTypeOtherSportingEvent = 14,
    /** A new years resolution event */
    JGFundraisingActivityTypeNewYearsResolution = 15,
    /** A Christmas event */
    JGFundraisingActivityTypeChristmas = 16,
    /** Any other type of personal challenge */
    JGFundraisingActivityTypeOtherPersonalChallenge = 17,
    /** A charity appeal */
    JGFundraisingActivityTypeCharityAppeal = 18,
    /** An individual appeal */
    JGFundraisingActivityTypeIndividualAppeal = 19,
    /** A company appeal */
    JGFundraisingActivityTypeCompanyAppeal = 20,
    /** A personal marathon that is not part of an organised marathon */
    JGFundraisingActivityTypePersonalRunningMarathon = 21,
    /** A personal trek that is not part of an organised trek */
    JGFundraisingActivityTypePersonalTrek = 22,
    /** A personal walk that is not part of an organised walk */
    JGFundraisingActivityTypePersonalWalk = 23,
    /** A personal cycle that is not part of an organised cycle event */
    JGFundraisingActivityTypePersonalCycling = 24,
    /** A personal swim that is not part of an organised swim */
    JGFundraisingActivityTypePersonalSwimming = 25,
    /** A personal triathalon that is not part of an organised triathalon */
    JGFundraisingActivityTypePersonalTriathalon = 26,
    /** A personal parachuting skydive that is not part of an organised parachuting skydive */
    JGFundraisingActivityTypePersonalParachutingSkydive = 27
};