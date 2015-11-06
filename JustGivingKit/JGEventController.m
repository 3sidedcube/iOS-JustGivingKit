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
#import "JGFundraisingPage.h"
#import "JGFundraisingController.h"
#import "JGSearchController.h"
#import "JGSearchQuery.h"
#import <JustGivingKit/JustGivingKit-Swift.h>

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
            JGFundraisingPage *event = [[JGFundraisingPage alloc]initWithDictionary:pageInfo];
            [events addObject:event];
        }
        
        completion([events copy],error);
    }];
}


- (void)getEventsForSearchTerm:(NSString *)searchTerm withCharityId:(NSString *)charityId completion:(JGFetchEventsCompletion)completion
{
    JGSearchQuery *query = [JGSearchQuery createQueryWithSearchTerm:searchTerm groupResults:false searchIndex:JGSearchQueryIndexEvent limit:@(10) offset:@(0) countryCode:@"gb"];
    
    JGSearchController *searchController = [JGSearchController new];
    
    [searchController performSearchWithQuery:query withCompletion:^(NSArray *results, NSError *error) {
       
        if (error) {
            
            completion(nil, error);
            return;
        }
        
        NSMutableArray *eventsArray = [NSMutableArray array];
        for (NSDictionary *eventDictionary in results) {
            
            JGEvent *event = [[JGEvent alloc] initWithDictionary:eventDictionary];
            [eventsArray addObject:event];
        }
        
        completion(eventsArray, nil);
    }];
}

- (void)joinEventWithEventId:(NSNumber *)eventId pageTitle:(NSString *)pageTitle pageShortName:(NSString *)pageShortName withCharityId:(NSString *)charityId targetAmount:(NSNumber *)targetAmount withCompletion:(JGJoinEventCompletion)completion;
{
    JGFundraisingController *fundraisingController = [JGFundraisingController new];
    
    JGFundraisingPage *page = [JGFundraisingPage new];
    page.eventId = eventId;
    page.pageTitle = pageTitle;
    page.pageShortName = pageShortName;
    page.charityId = charityId;
    page.targetAmount = targetAmount;
    
    [fundraisingController createFundraisingPage:page withCompletion:^(JGFundraisingPage *page, NSError *error) {
        
        if (error) {
            
            completion(nil, error);
            return;
        }
        
        completion(page, error);
    }];
}

@end
