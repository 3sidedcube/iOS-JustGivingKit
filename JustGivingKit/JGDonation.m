//
//  JGDonation.m
//  JustGivingKit
//
//  Created by Sam Houghton on 03/11/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import "JGDonation.h"
#import "NSDate+JGDate.h"

@implementation JGDonation

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            if (dictionary[@"amount"]) {
                self.donationAmount = dictionary[@"amount"];
            }
            
            if (dictionary[@"donorDisplayName"]) {
                self.donorDisplayName = dictionary[@"donorDisplayName"];
            }
            
            if (dictionary[@"donorRealName"]) {
                self.donorRealName = dictionary[@"donorRealName"];
            }
            
            if (dictionary[@"message"]) {
                self.donorMessage = dictionary[@"message"];
            }
            
            if (dictionary[@"image"]) {
                self.donorProfileImageUrl = [NSURL URLWithString:dictionary[@"image"]];
            }
            
            if (dictionary[@"donationDate"]) {
                self.donationDate = [NSDate dateWithODataString:dictionary[@"donationDate"]];
            }
            
            if (dictionary[@"pageShortName"]) {
                self.pageShortName = dictionary[@"pageShortName"];
            }
        }
    }
    
    return self;
}

@end
