//
//  JGEventController.h
//  JustGivingKit
//
//  Created by Joel Trew on 30/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JGUser;
@class JGFundraisingPage;

/**
 @class JGEventController
 @abstract An Event controller provides a set of useful methods to obtain event information, related to a fundraising page, from the JustGiving API
 */
@interface JGEventController : NSObject

typedef void (^JGFetchEventsCompletion)(NSArray *events, NSError *error);
typedef void (^JGJoinEventCompletion)(JGFundraisingPage *page, NSError *error);

/**
 @abstract Returns an arary of fundraising page events for a given user for a charity
 @param user A JustGiving user
 @param charityId A valid JustGiving charityId
 @param completion completion block which returns an array of events if the operation successfully completes
 */
- (void)getEventsForUser:(JGUser *)user withCharityId:(NSString *)charityId completion:(JGFetchEventsCompletion)completion;


- (void)getEventsForSearchTerm:(NSString *)searchTerm withCharityId:(NSString *)charityId completion:(JGFetchEventsCompletion)completion;


- (void)joinEventWithEventId:(NSString *)eventId pageTitle:(NSString *)pageTitle pageShortName:(NSString *)pageShortName withCharityId:(NSString *)charityId targetAmount:(NSNumber *)targetAmount withCompletion:(JGJoinEventCompletion)completion;

@end
