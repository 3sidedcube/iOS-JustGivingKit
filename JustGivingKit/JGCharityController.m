//
//  JGCharityController.m
//  JustGivingKit
//
//  Created by Joel Trew on 12/11/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import "JGCharityController.h"
#import "JGFundraisingController.h"
#import "JGFundraisingPage.h"
#import "JGDonation.h"
#import "JGDonationController.h"
#import "JGSession.h"

@interface JGCharityController ()

typedef void (^JGPageNamesCompletion)(NSDictionary *pageNames, NSError *error);

@end

@implementation JGCharityController

- (void)totalRaisedForCharity:(NSString *)charityId perAmountCompletion:(JGAmountCompletion)amountCompletion completion:(JGTotalRaisedCompletion)completion;
{
    JGFundraisingController *fundraisingController = [JGFundraisingController new];
    
    [fundraisingController getFundraisingPagesWithCharityId:charityId forUser:[JGSession sharedSession].currentUser withCompletion:^(NSArray<JGFundraisingPage *> *pages, NSError *error) {
        
        __block NSInteger totalRaised = 0;
        
        totalRaised += [[self totalRaisedForPages:pages] integerValue];
        
        JGDonationController *donationController = [JGDonationController new];
        
        [donationController getDonationsForCharity:charityId completion:^(NSArray<JGDonation *> *donations, NSError *error) {
            NSDictionary *pageNames = [self dictionaryForPages:pages];
            
            for (JGDonation *donation in donations) {
                //if the pageName which the donation belongs to is not in the dictionary then add it to the total
                if (![pageNames objectForKey:donation.pageShortName]) {
                    
                    totalRaised += [donation.donationAmount integerValue];
                    amountCompletion(@(totalRaised), nil);
                }
            }
            completion(@(totalRaised), nil);
        }];
    }];
}

- (NSDictionary *)dictionaryForPages:(NSArray<JGFundraisingPage *> *)pages
{
    NSMutableDictionary *pageNameDictionary = [NSMutableDictionary new];
    
    for (JGFundraisingPage *page in pages) {
        [pageNameDictionary setObject:@"" forKey:page.pageShortName];
    }
    
    return [pageNameDictionary copy];
}

- (NSNumber *)totalRaisedForPages:(NSArray<JGFundraisingPage *> *)pages {
    
    NSInteger totalRaised = 0;
    
    for (JGFundraisingPage *page in pages) {
        
        if (page.raisedAmount) {
            
            double raisedAmount = page.raisedAmount.doubleValue;
            totalRaised += raisedAmount;
        }
    }
    return @(totalRaised);
}




@end
