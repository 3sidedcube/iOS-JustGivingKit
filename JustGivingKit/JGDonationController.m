//
//  JGDonationController.m
//  JustGivingKit
//
//  Created by Joel Trew on 12/11/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

@import ThunderBasics;

#import "JGDonationController.h"
#import "JGFundraisingPage.h"
#import "JGDefines.h"

@implementation JGDonationController

- (NSURL *)donationUrlForCharityId:(NSString *)charityId donationAmount:(NSNumber *)donationAmount
{
    NSString *donateURLString;
    
    //setup base url
    donateURLString = [NSString stringWithFormat:@"https://www.justgiving.com/4w350m3/donation/direct/charity/%@", charityId];
    
    donateURLString = [donateURLString stringByAppendingString:[NSString stringWithFormat:@"?amount=%.2f&exitUrl=%@", [donationAmount floatValue], [@"JGK://" urlEncodedString]]];
    
    donateURLString = [donateURLString stringByAppendingString:[NSString stringWithFormat:@"&currency=%@", [[NSLocale currentLocale] objectForKey:NSLocaleCurrencyCode]]];
    
    return [NSURL URLWithString:donateURLString];
}

- (NSURL *)donateUrlForFundraisingPage:(JGFundraisingPage *)fundraisingPage withDonationAmount:(NSNumber *)donationAmount
{
    NSString *donateURLString;
    
    if (fundraisingPage.domain && fundraisingPage.pageShortName) {
        donateURLString = [NSString stringWithFormat:@"http://%@/%@", fundraisingPage.domain, fundraisingPage.pageShortName];
    } else {
        NSLog(@"The page does not have a domain or short name");
    }
    
    donateURLString = [NSString stringWithFormat:@"%@/4w350m3/donate/?amount=%.2f&exitUrl=%@", donateURLString, [donationAmount floatValue], [@"JGK://" urlEncodedString]];
    donateURLString = [donateURLString stringByAppendingString:[NSString stringWithFormat:@"&currency=%@", [[NSLocale currentLocale] objectForKey:NSLocaleCurrencyCode]]];
    
    NSLog(@"THE URL: %@", donateURLString);
    
    return [NSURL URLWithString:donateURLString];
}


@end
