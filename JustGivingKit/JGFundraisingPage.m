//
//  JGFundraisingPage.m
//  JustGivingKit
//
//  Created by Joel Trew on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import "JGFundraisingPage.h"
#import <JustGivingKit/JustGivingKit-Swift.h>
@import ThunderBasics;

NSString * const JGFundraisingPageIdKey = @"pageId";
NSString * const JGFundraisingPageTitleKey = @"pageTitle";
NSString * const JGFundraisingPageSummaryKey = @"pageSummary";
NSString * const JGFundraisingPageSummaryWhatKey = @"pageSummaryWhat";
NSString * const JGFundraisingPageSummaryWhyKey = @"pageSummaryWhy";
NSString * const JGFundraisingPageShortNameKey = @"pageShortName";
NSString * const JGFundraisingPageEndDateKey = @"expiryDate";
NSString * const JGFundraisingPageEventDateKey = @"eventDate";
NSString * const JGFundraisingPagePageStatusKey = @"pageStatus";
NSString * const JGFundraisingPageStatusKey = @"status";
NSString * const JGFundraisingPageRaisedAmountKey = @"raisedAmount";
NSString * const JGFundraisingPageTargetAmountKey = @"targetAmount";
NSString * const JGFundraisingPageImageUrlsKey = @"images";
NSString * const JGFundraisingPageImageAbsoluteUrlKey = @"absoluteUrl";
NSString * const JGFundraisingPageCharityIdKey = @"charityId";
NSString * const JGFundraisingPageEventIdKey = @"eventId";
NSString * const JGFundraisingPageEventNameKey = @"eventName";
NSString * const JGFundraisingPageDomainKey = @"domain";
NSString * const JGFundraisingPageActivityTypeKey = @"activityType";
NSString * const JGFundraisingPageCustomCodesKey = @"customCodes";

@implementation JGFundraisingPage

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        if (dictionary[JGFundraisingPageIdKey] && [dictionary[JGFundraisingPageIdKey] isKindOfClass:[NSString class]]) {
            self.pageId = dictionary[JGFundraisingPageIdKey];
        }
        
        if (dictionary[JGFundraisingPageTitleKey] && [dictionary[JGFundraisingPageTitleKey] isKindOfClass:[NSString class]]) {
            self.pageTitle = dictionary[JGFundraisingPageTitleKey];
        }
        
        if (dictionary[JGFundraisingPageActivityTypeKey] && [dictionary[JGFundraisingPageActivityTypeKey] isKindOfClass:[NSString class]]) {
            self.activityType = [JGFormatter activityTypeForString:dictionary[JGFundraisingPageActivityTypeKey]];
        }
        
        if (dictionary[JGFundraisingPageSummaryKey] && [dictionary[JGFundraisingPageSummaryKey] isKindOfClass:[NSString class]]) {
            self.pageSummary = dictionary[JGFundraisingPageSummaryKey];
        }
        
        if (dictionary[JGFundraisingPageSummaryWhatKey] && [dictionary[JGFundraisingPageSummaryWhatKey] isKindOfClass:[NSString class]]) {
            self.pageSummaryWhat = dictionary[JGFundraisingPageSummaryWhatKey];
        }
        
        if (dictionary[JGFundraisingPageSummaryWhyKey] && [dictionary[JGFundraisingPageSummaryWhyKey] isKindOfClass:[NSString class]]) {
            self.pageSummaryWhy = dictionary[JGFundraisingPageSummaryWhyKey];
        }
        
        if (dictionary[JGFundraisingPageShortNameKey] && [dictionary[JGFundraisingPageShortNameKey] isKindOfClass:[NSString class]]) {
            self.pageShortName = dictionary[JGFundraisingPageShortNameKey];
        }
        
        if (dictionary[JGFundraisingPagePageStatusKey] && [dictionary[JGFundraisingPagePageStatusKey] isKindOfClass:[NSString class]]) {
            self.pageStatus = dictionary[JGFundraisingPagePageStatusKey];
            // we have to check for 'status' aswell as the API uses this in some places
        } else if (dictionary[JGFundraisingPageStatusKey] && [dictionary[JGFundraisingPageStatusKey] isKindOfClass:[NSString class]]) {
            self.pageStatus = dictionary[JGFundraisingPageStatusKey];
        }
        
        if (dictionary[JGFundraisingPageRaisedAmountKey] && [dictionary[JGFundraisingPageRaisedAmountKey] isKindOfClass:[NSNumber class]]) {
            self.raisedAmount = dictionary[JGFundraisingPageRaisedAmountKey];
            
            if (!self.raisedAmount) {
                self.raisedAmount = @(0);
            }
        } else {
            self.raisedAmount = @(0);
        }
        
        if (dictionary[JGFundraisingPageEventIdKey] && [dictionary[JGFundraisingPageEventIdKey] isKindOfClass:[NSNumber class]]) {
            self.eventId = dictionary[JGFundraisingPageEventIdKey];
        }
        
        if (dictionary[JGFundraisingPageEventNameKey] && [dictionary[JGFundraisingPageEventNameKey] isKindOfClass:[NSString class]]) {
            self.eventName = dictionary[JGFundraisingPageEventNameKey];
        }
        
        if (dictionary[JGFundraisingPageDomainKey]) {
            self.domain = dictionary[JGFundraisingPageDomainKey];
        }

        
        if (dictionary[JGFundraisingPageTargetAmountKey] && [dictionary[JGFundraisingPageTargetAmountKey] isKindOfClass:[NSNumber class]]) {
            
            self.targetAmount = dictionary[JGFundraisingPageTargetAmountKey];
            
            if (!self.targetAmount) {
                self.targetAmount = @(0);
            }
        } else {
            self.targetAmount = @(0);
        }
        
        if (dictionary[JGFundraisingPageCustomCodesKey] && [dictionary[JGFundraisingPageCustomCodesKey] isKindOfClass:[NSDictionary class]]) {
            self.customCodes = dictionary[JGFundraisingPageCustomCodesKey];
        }
        
        
        if (dictionary[JGFundraisingPageEndDateKey] && [dictionary[JGFundraisingPageEndDateKey] isKindOfClass:[NSString class]]) {
            self.pageEndDate = [NSDate dateWithISO8601String:dictionary[JGFundraisingPageEndDateKey]];
        }
        
        if (dictionary[JGFundraisingPageEventDateKey] && [dictionary[JGFundraisingPageEventDateKey] isKindOfClass:[NSString class]]) {
            self.pageEventDate = [NSDate dateWithISO8601String:dictionary[JGFundraisingPageEventDateKey]];
        }
        
        NSMutableArray<NSURL *> *imageUrls = [NSMutableArray new];
        
        if (dictionary[JGFundraisingPageImageUrlsKey] && [dictionary[JGFundraisingPageImageUrlsKey] isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary *imageDictionary in dictionary[JGFundraisingPageImageUrlsKey]) {
                
                if (imageDictionary[JGFundraisingPageImageAbsoluteUrlKey]) {
                    [imageUrls addObject:[NSURL URLWithString:imageDictionary[JGFundraisingPageImageAbsoluteUrlKey]]];
                }
            }
        }
        
        self.imageUrls = [NSArray<NSURL *> arrayWithArray:imageUrls];
    }
    
    return self;
}

- (NSURL *)pageURL
{
    if (self.domain && self.pageShortName) {
        return [NSURL URLWithString:[self.domain stringByAppendingPathComponent:self.pageShortName]];
    }
    return nil;
}

@end
