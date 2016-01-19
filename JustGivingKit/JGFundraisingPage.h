//
//  JGFundraisingPage.h
//  JustGivingKit
//
//  Created by Joel Trew on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGDefines.h"

typedef NS_ENUM(NSUInteger, JGFundraisingPageStatus) {
    JGFundraisingPageStatusUnknown = 0,
    JGFundraisingPageStatusActive = 1,
    JGFundraisingPageStatusCompleted = 2,
    JGFundraisingPageStatusCancelled = 3
};

@interface JGFundraisingPage : NSObject

FOUNDATION_EXPORT NSString * const JGFundraisingPageIdKey;
/**
 @abstract A unique fundraising page Id
 */
@property (nonatomic, copy) NSNumber *pageId;

FOUNDATION_EXPORT NSString * const JGFundraisingPageTitleKey;
/**
 @abstract The title of the fundraising page
 */
@property (nonatomic, copy) NSString *pageTitle;

FOUNDATION_EXPORT NSString * const JGFundraisingPageSummaryKey;
/**
 @abstract The summary of what the user is doing and why the user is raising
 */
@property (nonatomic, copy) NSString *pageSummary;

FOUNDATION_EXPORT NSString * const JGFundraisingPageSummaryWhatKey;
/**
 @abstract What the user is doing / giving up
 */
@property (nonatomic, copy) NSString *pageSummaryWhat;

FOUNDATION_EXPORT NSString * const JGFundraisingPageSummaryWhyKey;
/**
 @abstract Why the user is doing / giving up what they're doing / giving up
 */
@property (nonatomic, copy) NSString *pageSummaryWhy;

FOUNDATION_EXPORT NSString * const JGFundraisingPageShortNameKey;
/**
 @abstract A unique identifier for the fundraising page that is used to make requests
 */
@property (nonatomic, copy) NSString *pageShortName;

FOUNDATION_EXPORT NSString * const JGFundraisingPageEndDateKey;
/**
 @abstract The ending date of the fundraising page
 */
@property (nonatomic, strong) NSDate *pageEndDate;

FOUNDATION_EXPORT NSString * const JGFundraisingPageEventDateKey;
/**
 @abstract The event date of the fundraising page
 */
@property (nonatomic, strong) NSDate *pageEventDate;

FOUNDATION_EXPORT NSString * const JGFundraisingPageCurrencyCodeKey;
/**
 @abstract The currency code of the fundraising page
 */
@property (nonatomic, copy) NSString *currencyCode;

FOUNDATION_EXPORT NSString * const JGFundraisingPageCurrencySymbolKey;
/**
 @abstract The currency symbol of the fundraising page
 */
@property (nonatomic, copy) NSString *currencySymbol;

FOUNDATION_EXPORT NSString * const JGFundraisingPagePageStatusKey;
FOUNDATION_EXPORT NSString * const JGFundraisingPageStatusKey;
/**
 @abstract The page status string i.e Active/Cancelled
 */
@property (nonatomic, copy) NSString *pageStatusString;

/**
 @abstract The page status
 */
@property (nonatomic, assign) JGFundraisingPageStatus pageStatus;

FOUNDATION_EXPORT NSString * const JGFundraisingPageRaisedAmountKey;
/**
 @abstract The total amount raised for a given fundraising page
 */
@property (nonatomic, copy) NSNumber *raisedAmount;

FOUNDATION_EXPORT NSString * const JGFundraisingPageTargetAmountKey;
/**
 @abstract The target amount to raise for a fundraising page
 */
@property (nonatomic, copy) NSNumber *targetAmount;

FOUNDATION_EXPORT NSString * const JGFundraisingPageImageUrlsKey;
FOUNDATION_EXPORT NSString * const JGFundraisingPageImageAbsoluteUrlKey;
/**
 @abstract An array of the funraising page's image urls
 */
@property (nonatomic, strong) NSArray<NSURL *> *imageUrls;

FOUNDATION_EXPORT NSString * const JGFundraisingPageCharityIdKey;
/**
 @abstract The charity the fundraising page is raising for
 */
@property (nonatomic, strong) NSString *charityId;

FOUNDATION_EXPORT NSString * const JGFundraisingPageEventIdKey;
/**
 @abstract The unqiue event identifier
 */
@property (nonatomic, copy) NSNumber *eventId;

FOUNDATION_EXPORT NSString * const JGFundraisingPageEventNameKey;
/**
 @abstract The event's name
 */
@property (nonatomic, copy) NSString *eventName;

FOUNDATION_EXPORT NSString * const JGFundraisingPageDomainKey;
/**
 @abstract The domain of the fundraising page e.g www.justgiving.com
 */
@property (nonatomic, copy) NSString *domain;

FOUNDATION_EXPORT NSString * const JGFundraisingPageActivityTypeKey;
/**
 @abstract The type of the event assosicated with the event (If any)
 */
@property (nonatomic, assign) JGFundraisingActivityType activityType;

FOUNDATION_EXPORT NSString * const JGFundraisingPageCustomCodesKey;
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
