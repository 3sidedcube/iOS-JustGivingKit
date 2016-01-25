//
//  JGDonationController.m
//  JustGivingKit
//
//  Created by Joel Trew on 12/11/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

@import ThunderBasics;
@import ThunderRequest;

#import "JGDonationController.h"
#import "JGFundraisingPage.h"
#import "JGDefines.h"
#import "JGSession.h"
#import "JGDonation.h"

@implementation JGDonationController

- (NSURL *)donationUrlForCharityId:(NSString *)charityId donationAmount:(NSNumber *)donationAmount
{
    NSString *donateURLString;
    
    //setup base url
    donateURLString = [NSString stringWithFormat:@"https://www.justgiving.com/4w350m3/donation/direct/charity/%@", charityId];
    
    donateURLString = [donateURLString stringByAppendingString:[NSString stringWithFormat:@"?amount=%.2f&exitUrl=%@", [donationAmount floatValue], [@"JGTRO://" urlEncodedString]]];
    
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

- (void)getDonationsForCharity:(NSString *)charityId completion:(JGDonationsForCharityCompletion)completion
{
    NSString *getAddress = [NSString stringWithFormat:@"account/donations?pagesize=%i&pagenum=%i&charityid=%@", 150, 1, charityId];
    
    [[JGSession sharedSession].requestController get:getAddress completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error || response.status != 200) {
            
            completion(nil, error);
            return;
        }
        NSMutableArray *donations = [NSMutableArray new];
        
        for (NSDictionary *donationDictionary in response.dictionary[@"donations"]) {
            JGDonation *donation = [[JGDonation alloc] initWithDictionary:donationDictionary];
            [donations addObject:donation];
        }
        
        completion([donations copy], error);
    }];

}


@end
