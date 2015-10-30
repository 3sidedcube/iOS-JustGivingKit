//
//  JGEventController.m
//  JustGivingKit
//
//  Created by Joel Trew on 30/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

@import ThunderRequest;
#import "JGEventController.h"
#import "JGSession.h"
#import "JGUser.h"
#import "JGFundraisingPageEvent.h"

@implementation JGEventController

- (void)getEventsForUser:(JGUser *)user withCharityId:(NSString *)charityId completion:(JGFetchEventsCompletion)completion
{
    NSString *userEmail = @"";
    if (user) {
        userEmail = user.email;
    }
    
    NSString *encodedEmail = [userEmail stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *getAddress = [NSString stringWithFormat:@"account/%@/pages?charityid=%@",encodedEmail, charityId];
    
    [[JGSession sharedSession].requestController get:getAddress completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error || response.status != 200) {
            completion(nil, error);
            return;
        }
        
        NSMutableArray *events = [NSMutableArray new];
        
        for (NSDictionary *pageInfo in response.array) {
            JGFundraisingPageEvent *event = [[JGFundraisingPageEvent alloc]initWithDictionary:pageInfo];
            [events addObject:event];
        }
        
        completion([events copy],error);
    }];
}

@end
