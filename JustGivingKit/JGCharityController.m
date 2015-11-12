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

@interface JGCharityController ()

typedef void (^JGPageNamesCompletion)(NSDictionary *pageNames, NSError *error);

@end

@implementation JGCharityController

- (void)getTotalRaisedForCharity:(NSString *)charityId forUser:(JGUser *)user perAmountCompletion:(JGAmountCompletion)amountCompletion completion:(JGTotalRaisedCompletion)completion
{
    [self getUserPageNamesForUser:user withCharity:charityId withCompletion:^(NSDictionary *pageNames, NSError *error) {
        
        
    }];
}

- (void)getUserPageNamesForUser:(JGUser *)user withCharity:(NSString *)charityId withCompletion:(JGPageNamesCompletion)completion
{
    JGFundraisingController *fundraisingController = [JGFundraisingController new];
    [fundraisingController getFundraisingPagesWithCharityId:charityId forUser:user withCompletion:^(NSArray<JGFundraisingPage *> *pages, NSError *error) {
        
        NSMutableDictionary *pageNameDictionary = [NSMutableDictionary new];
        if (!error) {
            
            for (JGFundraisingPage *page in pages) {
                [pageNameDictionary setObject:@"" forKey:page.pageShortName];
            }
            completion([pageNameDictionary copy], nil);
            
        } else {
            completion(nil, error);
        }
    }];
}

@end
