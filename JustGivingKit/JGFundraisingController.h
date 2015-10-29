//
//  JGFundraisingController.h
//  JustGivingKit
//
//  Created by Sam Houghton on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JGUser;

@interface JGFundraisingController : NSObject

typedef void (^JGFetchPagesCompletion)(NSArray *pages, NSError *error);
typedef void (^JGRaisedAmountCompletion)(NSNumber *raisedAmount, NSError *error);

/**
 @abstract Returns all of a user's fundraising pages
 @param completion completion block which returns an array of fundraising pages if operation successfully completes
 */
- (void)getFundraisingPagesWithCompletion:(JGFetchPagesCompletion)completion;

/**
 @abstract Returns all of a user's fundraising pages for a given charity
 @param charityId The id for the charity you want fundraising pages for
 @param user The user who created the fundraising page
 @param completion completion block which returns an array of fundraising pages if operation successfully completes
 */
- (void)getFundraisingPagesWithCharityId:(NSString *)charityId forUser:(JGUser *)user withCompletion:(JGFetchPagesCompletion)completion;

/**
 @abstract Returns all of a user's fundraising pages for a given charity
 @discussion Use this method if you have the users email as a string
 @param charityId The id for the charity you want fundraising pages for
 @param userEmail An email address of a justgiving user
 @param completion completion block which returns an array of fundraising pages if operation successfully completes
 */
- (void)getFundraisingPagesWithCharityId:(NSString *)charityId forUserEmail:(NSString *)userEmail withCompletion:(JGFetchPagesCompletion)completion;


- (NSObject *)getMoreDetailsforFundraisingPage:(NSObject *)pageShortName;

- (void)totalFundsRaisedByUser:(JGUser *)user ForCharityId:(NSString *)charityId completion:(JGRaisedAmountCompletion)completion;

@end
