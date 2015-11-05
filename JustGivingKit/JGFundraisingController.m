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
#import "JGFundraisingPageEvent.h"
#import "JGSession.h"
#import "JGUser.h"
#import "JGDonation.h"

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

- (void)getMoreDetailsForFundraisingPage:(JGFundraisingPage *)fundraisingPage withCompletion:(JGFetchPageDetailCompletion)completion
{
    NSString *getAddress = [NSString stringWithFormat:@"fundraising/pages/%@",fundraisingPage.pageShortName];
    
    [[JGSession sharedSession].requestController get:getAddress completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error || response.status != 200) {
            completion(nil, error);
            return;
        }
        
        JGFundraisingPage *page = [[JGFundraisingPage alloc] initWithDictionary:response.dictionary];
        completion(page, error);
    }];
}

- (void)getDonationsForFundraisingPage:(JGFundraisingPage *)fundraisingPage withCompletion:(JGFetchPageDonationsCompletion)completion
{
    NSString *getAddress = [NSString stringWithFormat:@"fundraising/pages/%@/donations",fundraisingPage.pageShortName];
    
    [[JGSession sharedSession].requestController get:getAddress completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        NSMutableArray *donations = [NSMutableArray new];
        
        for (NSDictionary *donationDictionary in response.dictionary[@"donations"]) {
            [donations addObject:[[JGDonation alloc] initWithDictionary:donationDictionary]];
        }
        
        completion([NSArray arrayWithArray:donations], nil);
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
        
        for (JGFundraisingPage *page in pages) {
            if (page.raisedAmount) {
                double raisedAmount = page.raisedAmount.doubleValue;
                totalRaised += raisedAmount;
            }
        }
        
        completion([NSNumber numberWithDouble:totalRaised], error);
    }];
}

- (void)createFundraisingPage:(JGFundraisingPage *)fundraisingPage withCompletion:(JGCreateFundraisingPageCompletion)completion
{
    NSMutableDictionary *payload = [NSMutableDictionary new];
    
    payload[@"charityId"] = fundraisingPage.charityId;
    payload[@"pageShortName"] = fundraisingPage.pageShortName;
    payload[@"pageTitle"] = fundraisingPage.pageTitle;
    if (fundraisingPage.targetAmount) { payload[@"targetAmount"] = [fundraisingPage.targetAmount stringValue]; }
    payload[@"justGivingOptIn"] = @"false";
    payload[@"charityOptIn"] = @"false";
    payload[@"charityFunded"] = @"false";

    
    [[JGSession sharedSession].requestController put:@"fundraising/pages" bodyParams:payload completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error || response.status != 201) {
            if (response.status == 409) {
                // page was not created
                
                if ([response.dictionary[@"error"][@"id"] isEqualToString:@"PageShortNameAlreadyExists"]) {
                    // pageshortname exists
                    completion(nil, error);
                }
                
                completion(nil, error);
                return;
            }
            
        } else {
            
            // success
            [self getMoreDetailsForFundraisingPage:fundraisingPage withCompletion:^(JGFundraisingPage *page, NSError *error) {
                
                if (error) {
                    completion(nil, error);
                    
                } else {
                    completion(page, error);
                }
            }];
        }
    }];
}

@end
