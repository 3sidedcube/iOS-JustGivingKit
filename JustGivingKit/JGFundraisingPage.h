//
//  JGFundraisingPage.h
//  JustGivingKit
//
//  Created by Joel Trew on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>

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
 @abstract Initialises the object with a dictionary representation of itself
 @param dictionary A dictionary representation of `JGFundraisingPage`.
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
