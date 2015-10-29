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
    
    [self getFundraisingPages:charityId forUser:userEmail withCompletion:^(NSArray *pages, NSError *error) {
        
        if (completion) {
            if (!error) {
                completion(pages, error);
            }
        }
        
    }];
}

- (void)getFundraisingPages:(NSString *)charityId forUser:(NSString *)userEmail withCompletion:(JGFetchPagesCompletion)completion
{
    NSString *encodedEmail = [userEmail stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *getAddress = [NSString stringWithFormat:@"account/%@/pages?charityid=%@",encodedEmail, charityId];
    
    [[JGSession sharedSession].requestController get:getAddress completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
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


- (void)getFundraisingPagesWithCompletion:(JGFetchPagesCompletion)completion {
    [[JGSession sharedSession].requestController get:@"fundraising/pages?charityid=183092" completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
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

- (NSObject *)getMoreDetailsforFundraisingPage:(NSObject *)pageShortName
{
    
    return @"";

}





@end
