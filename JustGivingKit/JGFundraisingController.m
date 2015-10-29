//
//  JGFundraisingController.m
//  JustGivingKit
//
//  Created by Sam Houghton on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

@import ThunderRequest;

#import "JGFundraisingController.h"
#import "JGFundraisingPage.h"
#import "JGSession.h"
#import "JGUser.h"

@implementation JGFundraisingController

- (void)getFundraisingPagesWithCharityId:(NSString *)charityId forUser:(JGUser *)user withCompletion:(JGFetchPagesCompletion)completion
{
    NSString *userEmail = @"";
    if (user) {
        userEmail = user.email;
    }
    
    [self getFundraisingPagesWithCharityId:charityId forUserEmail:userEmail withCompletion:^(NSArray *pages, NSError *error) {
        
        if (completion) {
            if (!error) {
                completion(pages, error);
            }
        }
    }];
}

- (void)getFundraisingPagesWithCharityId:(NSString *)charityId forUserEmail:(NSString *)userEmail withCompletion:(JGFetchPagesCompletion)completion
{
    NSString *encodedEmail = [userEmail stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *getAddress = [NSString stringWithFormat:@"account/%@/pages?charityid=%@",encodedEmail, charityId];
    
    [self requestPagesWithAddress:getAddress WithCompletion:^(NSArray *pages, NSError *error) {
        if (completion) {
            if (!error) {
                completion(pages, error);
            }
        }
    }];
}

- (void)getFundraisingPagesWithCompletion:(JGFetchPagesCompletion)completion
{
    [self requestPagesWithAddress:@"fundraising/pages" WithCompletion:^(NSArray *pages, NSError *error) {
        if (completion) {
            if (!error) {
                completion(pages, error);
            }
        }
    }];
}

- (void)requestPagesWithAddress:(NSString *)address WithCompletion:(JGFetchPagesCompletion)completion
{
    [[JGSession sharedSession].requestController get:address completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error || response.status != 200) {
            completion(nil, error);
            return;
        }
        
        NSMutableArray *pages = [NSMutableArray new];
        
        for (NSDictionary *pageInfo in response.array) {
            
            NSLog(@"pageinfo: %@",pageInfo);
            JGFundraisingPage *page = [[JGFundraisingPage alloc]initWithDictionary:pageInfo];
            [pages addObject:page];
        }
        
        completion([pages copy],error);
    }];
}

- (void)totalFundsRaisedByUser:(JGUser *)user ForCharityId:(NSString *)charityId completion:(JGRaisedAmountCompletion)completion
{
    __block double totalRaised = 0;
    [self getFundraisingPagesWithCharityId:charityId forUser:user withCompletion:^(NSArray *pages, NSError *error) {
        
        for (NSDictionary *pageInfo in pages) {
            JGFundraisingPage *page = [[JGFundraisingPage alloc]initWithDictionary:pageInfo];
            if (page.raisedAmount) {
                double raisedAmount = page.raisedAmount.doubleValue;
                totalRaised += raisedAmount;
            }
        }
        
        completion([NSNumber numberWithDouble:totalRaised], error);
    }];
}


@end
