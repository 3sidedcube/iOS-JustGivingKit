//
//  JGEventController.h
//  JustGivingKit
//
//  Created by Joel Trew on 30/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@class JGFundraisingPage;

/**
 @class JGEventController
 @abstract An Event controller provides a set of useful methods to obtain event information, related to a fundraising page, from the JustGiving API
 */
@interface JGEventController : NSObject

typedef void (^JGFetchEventsCompletion)(NSArray *events, NSError *error);
typedef void (^JGJoinEventCompletion)(JGFundraisingPage *page, NSError *error);

/**
 @abstract Returns an array of fundraising page events for a given user for a charity
 @param user A JustGiving user
 @param charityId A valid JustGiving charityId
 @param completion completion block which returns an array of events if the operation successfully completes
 */
- (void)getEventsForUser:(User *)user withCharityId:(NSString *)charityId completion:(JGFetchEventsCompletion)completion;

/**
 @abstract Searches for events using OneSearch and returns an array of events
 @param searchTerm Search term to query events for
 @param charityId Unique charity Id to find the events for
 @param completion Completion block which returns an array of events if the operation successfully completes
 */
- (void)getEventsForSearchTerm:(NSString *)searchTerm withCharityId:(NSString *)charityId completion:(JGFetchEventsCompletion)completion;

/**
 @abstract Joins the user to an event and creates a fundraising page for it
 @param eventId Unique Id for an event
 @param pageTitle Title of the fundraising page to be created
 @param pageShortName Unique identifier short name for the craeted fundraising page
 @param charityId Unique charity Id that the fundraising page is for
 @param targetAmount The target amount of money the page aims to raise
 @param image The image to upload with the event to be the default image
 */
- (void)joinEventWithEventId:(NSNumber *)eventId pageTitle:(NSString *)pageTitle pageShortName:(NSString *)pageShortName withCharityId:(NSString *)charityId targetAmount:(NSNumber *)targetAmount eventImage:(UIImage *)image withCompletion:(JGJoinEventCompletion)completion;

@end
