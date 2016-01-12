//
//  JGFundraisingPage.h
//  JustGivingKit
//
//  Created by Joel Trew on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGDefines.h"

@interface JGFundraisingPage : NSObject

/**
 @abstract A unique fundraising page Id
 */
@property (nonatomic, copy) NSString *pageId;

/**
 @abstract The title of the fundraising page
 */
@property (nonatomic, copy) NSString *pageTitle;

/**
 @abstract The summary of what the user is doing and why the user is raising
 */
@property (nonatomic, copy) NSString *pageSummary;

/**
 @abstract A unique identifier for the fundraising page that is used to make requests
 */
@property (nonatomic, copy) NSString *pageShortName;

/**
 @abstract The ending date of the fundraising page
 */
@property (nonatomic, strong) NSDate *pageEndDate;

/**
 @abstract The event date of the fundraising page
 */
@property (nonatomic, strong) NSDate *pageEventDate;

/**
 @abstract The page status i.e Active/Cancelled
 */
@property (nonatomic, copy) NSString *pageStatus;

/**
 @abstract The total amount raised for a given fundraising page
 */
@property (nonatomic, copy) NSNumber *raisedAmount;

/**
 @abstract The target amount to raise for a fundraising page
 */
@property (nonatomic, copy) NSNumber *targetAmount;

/**
 @abstract An array of the funraising page's image urls
 */
@property (nonatomic, strong) NSArray<NSURL *> *imageUrls;

/**
 @abstract The charity the fundraising page is raising for
 */
@property (nonatomic, strong) NSString *charityId;

/**
 @abstract The unqiue event identifier
 */
@property (nonatomic, copy) NSNumber *eventId;

/**
 @abstract The event's name
 */
@property (nonatomic, copy) NSString *eventName;

/**
 @abstract The domain of the fundraising page e.g www.justgiving.com
 */
@property (nonatomic, copy) NSString *domain;

/**
 @abstract The type of the event assosicated with the event (If any)
 */
@property (nonatomic, assign) JGFundraisingActivityType activityType;

/**
 @abstract A dictionary of custom codes associated with the page
 @discussion These will be stored under keys: customCode1 e.t.c.
 */
@property (nonatomic, strong) NSDictionary *customCodes;

/**
 @abstract Initialises the object with a dictionary representation of itself
 @param dictionary A dictionary representation of `JGFundraisingPage`.
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 @abstract Returns the URL for the fundraising page
 @discussion This is constructed each time from the domain and pageShortName
 */
@property (nonatomic, weak) NSURL *pageURL;

@end
