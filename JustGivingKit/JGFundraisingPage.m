//
//  JGFundraisingPage.m
//  JustGivingKit
//
//  Created by Joel Trew on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import "JGFundraisingPage.h"

@implementation JGFundraisingPage

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        if (dictionary[@"pageId"]) {
            self.pageId = dictionary[@"pageId"];
        }
        
        if (dictionary[@"pageTitle"]) {
            self.pageTitle = dictionary[@"pageTitle"];
        }
        
        if (dictionary[@"pageSummary"]) {
            self.pageSummary = dictionary[@"pageSummary"];
        }
        
        if (dictionary[@"pageShortName"]) {
            self.pageShortName = dictionary[@"pageShortName"];
        }
        
        if (dictionary[@"pageStatus"]) {
            self.pageStatus = dictionary[@"pageStatus"];
            // we have to check for 'status' aswell as the API uses this in some places
        } else if (dictionary[@"status"]) {
            self.pageStatus = dictionary[@"status"];
        }
        
        if (dictionary[@"raisedAmount"]) {
            self.raisedAmount = dictionary[@"raisedAmount"];
            
            if (!self.raisedAmount) {
                self.raisedAmount = @(0);
            }
        }
        
        if (dictionary[@"eventId"]) {
            self.eventId = dictionary[@"eventId"];
        }
        
        if (dictionary[@"eventName"]) {
            self.eventName = dictionary[@"eventName"];
        }
        
        if (dictionary[@"domain"]) {
            self.domain = dictionary[@"domain"];
        }

        
        if (dictionary[@"targetAmount"]) {
            self.targetAmount = dictionary[@"targetAmount"];
            
            if (!self.targetAmount) {
                self.targetAmount = @(0);
            }
        }
        
        NSMutableArray<NSURL *> *imageUrls = [NSMutableArray new];
        
        if (dictionary[@"images"]) {
            for (NSDictionary *imageDictionary in dictionary[@"images"]) {
                if (imageDictionary[@"absoluteUrl"]) {
                    [imageUrls addObject:[NSURL URLWithString:imageDictionary[@"absoluteUrl"]]];
                }
            }
        }
        
        self.imageUrls = [NSArray<NSURL *> arrayWithArray:imageUrls];
    }
    
    return self;
}

@end
