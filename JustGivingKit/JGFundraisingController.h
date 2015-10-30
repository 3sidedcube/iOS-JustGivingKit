//
//  JGFundraisingController.h
//  JustGivingKit
//
//  Created by Sam Houghton on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JGUser;
@class JGFundraisingPage;

/**
 @class JGFundraisingController
 @abstract A fundraising controller provides a set of useful methods to obtain fundraising page information from the JustGiving API
 */
@interface JGFundraisingController : NSObject

typedef void (^JGFetchPagesCompletion)(NSArray *pages, NSError *error);
typedef void (^JGFetchPageDetailCompletion)(JGFundraisingPage *page, NSError *error);
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

/**
 @abstract Returns a fundraising page model with greater detailed attributes
 @discussion Use this method after getting a fundraising page to obtain more information about the fundraising page
 @param fundraisingPage The fundraising page for which you want to obtain the details
 @param completion completion block which returns a fundraising page object if the operation successfully completes
 */
- (void)getMoreDetailsForFundraisingPage:(JGFundraisingPage *)fundraisingPage withCompletion:(JGFetchPageDetailCompletion)completion;

/**
 @abstract Returns the total amount of money raised by a user for a given charity
 @param user A just giving user which you want the total for
 @param charityId A valid justgiving charityId
 @param completion completion block which returns the total amount raised if the operation successfully completes
 */
- (void)totalFundsRaisedByUser:(JGUser *)user ForCharityId:(NSString *)charityId completion:(JGRaisedAmountCompletion)completion;

@end
