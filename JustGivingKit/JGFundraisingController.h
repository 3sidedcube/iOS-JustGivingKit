//
//  JGFundraisingController.h
//  JustGivingKit
//
//  Created by Sam Houghton on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@class JGUser;
@class JGFundraisingPage;
@class JGDonation;


/**
 @class JGFundraisingController
 @abstract A fundraising controller provides a set of useful methods to obtain fundraising page information from the JustGiving API
 */
@interface JGFundraisingController : NSObject

typedef void (^JGFetchPagesCompletion)(NSArray<JGFundraisingPage *> * _Nullable pages, NSError * _Nullable error);
typedef void (^JGFetchPageDetailCompletion)(JGFundraisingPage * _Nullable page, NSError * _Nullable error);
typedef void (^JGRaisedAmountCompletion)(NSNumber * _Nullable raisedAmount, NSError * _Nullable error);
typedef void (^JGFetchPageDonationsCompletion)(NSArray<JGDonation *> * _Nullable donations, NSError * _Nullable error);
typedef void (^JGCreateFundraisingPageCompletion)(JGFundraisingPage * _Nullable page, NSError * _Nullable creationError, NSError * _Nullable imageError);
typedef void (^JGDeleteFundraisingPageCompletion)(NSError * _Nullable error);
typedef void (^JGSuggestedNamesCompletion)(NSArray<NSString *> * _Nullable names, NSError * _Nullable error);
typedef void (^JGShortPageNameAvailabilityCompletion)(BOOL isAvailable, NSError * _Nullable error);

/**
 The block that will be called when an image upload request succeeds or fails
 */
typedef void (^JGUploadImageCompletion)(NSError * _Nullable error);

/**
 @abstract Returns all of a user's fundraising pages
 @param completion completion block which returns an array of fundraising pages if operation successfully completes
 */
- (void)getFundraisingPagesWithCompletion:(JGFetchPagesCompletion _Nullable)completion;

/**
 @abstract Returns all of a user's fundraising pages for a given charity
 @param charityId The id for the charity you want fundraising pages for
 @param user The user who created the fundraising page
 @param completion completion block which returns an array of fundraising pages if operation successfully completes
 */
- (void)getFundraisingPagesWithCharityId:(NSString * _Nonnull)charityId forUser:(JGUser * _Nonnull)user withCompletion:(JGFetchPagesCompletion _Nullable)completion;

/**
 @abstract Returns all of a user's fundraising pages for a given charity
 @discussion Use this method if you have the users email as a string
 @param charityId The id for the charity you want fundraising pages for
 @param userEmail An email address of a justgiving user
 @param completion completion block which returns an array of fundraising pages if operation successfully completes
 */
- (void)getFundraisingPagesWithCharityId:(NSString * _Nonnull)charityId forUserEmail:(NSString * _Nonnull)userEmail withCompletion:(JGFetchPagesCompletion _Nullable)completion;

/**
 @abstract Returns a fundraising page model with greater detailed attributes
 @discussion Use this method after getting a fundraising page to obtain more information about the fundraising page
 @param fundraisingPage The fundraising page for which you want to obtain the details
 @param completion completion block which returns a fundraising page object if the operation successfully completes
 */
- (void)getMoreDetailsForFundraisingPage:(JGFundraisingPage * _Nonnull)fundraisingPage withCompletion:(JGFetchPageDetailCompletion _Nonnull)completion;

/**
 @abstract Determines whether or not a short name is available to be registered in the JustGiving API
 @discussion Use this to check if a page URL is available before registering a fundraising page to avoid errors
 @param shortName The proposed URL to be registered
 @param completion The completion block which returns a `BOOL` of the availability as well as an `NSError` if it exists
 */
- (void)getAvailabilityOfFundraisingPageShortName:(NSString * _Nonnull)shortName completion:(JGShortPageNameAvailabilityCompletion _Nonnull)completion;

/**
 @abstract Returns an arrary of `JGDonation` objects for the given `JGFundraisingPage`
 @discussion Use this method get the donations made to a fundraising page
 @param fundraisingPage The fundraising page for which you want to obtain the donations
 @param completion completion block which returns an `NSArrary` of `JGDonation` objects if the operation successfully completes
 */
- (void)getDonationsForFundraisingPage:(JGFundraisingPage * _Nonnull)fundraisingPage withCompletion:(JGFetchPageDonationsCompletion _Nonnull)completion;

/**
 @abstract Returns an array of `NSString` objects as suggestions for the user for their new fundraising page
 @discussion Use this method to present options to the user before registering a page. You may let the user choose their own custom short name but you must verify that it is available before attempting to register
 @param preferredString A string to generate suggestions from. It is recommended that you ask the user to name their fundraising page and then pass that value here
 @param completion The completion block which returns an `NSArray` of `NSString` objects if the request is successful. It may also return an `NSError` object if there is a problem with the request.
 */
- (void)getSuggestedPageShortNamesWithPreferredString:(nonnull NSString *)preferredString completion:(nonnull JGSuggestedNamesCompletion)completion;

/**
 @abstract Returns the total amount of money raised by a user for a given charity
 @param user A just giving user which you want the total for
 @param charityId A valid justgiving charityId
 @param completion completion block which returns the total amount raised if the operation successfully completes
 */
- (void)totalFundsRaisedByUser:(JGUser * _Nonnull)user ForCharityId:(NSString * _Nonnull)charityId completion:(JGRaisedAmountCompletion _Nonnull)completion;

/**
 @abstract Creates/registers a fundraising page using the JustGivingApi
 @discussion Make sure the fundraisingpage object you give the method has at least a charityId, pageShortName and pageTitle. The method is used in the wrapper method joinEventWithEventId
 @param fundraisingPage A fundraising page with a charityId, pageShortName and pageTitle
 @param completion completion block which returns the a fully detailed fundraisingPage or an error 
 */
- (void)createFundraisingPage:(JGFundraisingPage * _Nonnull)fundraisingPage withCompletion:(JGCreateFundraisingPageCompletion _Nonnull)completion;

/**
 @abstract Creates/registers a fundraising page using the JustGivingApi and also uploads an image
 @discussion Make sure the fundraisingpage object you give the method has at least a charityId, pageShortName and pageTitle. The method is used in the wrapper method joinEventWithEventId
 @param fundraisingPage A fundraising page with a charityId, pageShortName and pageTitle
 @param fundraisingImage An image to be uploaded to the page once it is created
 @param completion completion block which returns the a fully detailed fundraisingPage or an error
 */
- (void)createFundraisingPage:(JGFundraisingPage * _Nonnull)fundraisingPage image:(UIImage * _Nonnull)fundraisingImage completion:(nullable JGCreateFundraisingPageCompletion)completion;

/**
 @abstract Deletes a given fundraising page
 @discussion Convenience method which calls deleteFundraisingPageWithShortName the deleted page will still appear in requests but will have a status of 'Cancelled'
 @param fundraisingPage A fundraising page with a pageShortName
 @param completion Completion block which returns an error if the delete was not successful
 */
- (void)deleteFundraisingPage:(JGFundraisingPage * _Nonnull)fundraisingPage withCompletion:(JGDeleteFundraisingPageCompletion _Nonnull)completion;

/**
 @abstract Deletes a given fundraising page via a shortName
 @discussion The deleted page will still appear in requests but will have a status of 'Cancelled'
 @param pageShortName Unique page short name string
 @param completion Completion block which returns an error if the delete was not successful
 */
- (void)deleteFundraisingPageWithShortName:(NSString * _Nonnull)pageShortName withCompletion:(JGDeleteFundraisingPageCompletion _Nonnull)completion;

/**
 @abstract Uploads a new image to an existing funraising page. Optionally setting it as the default image and also giving it a caption if desired
 @param fundraisingImage The image to upload to the fundraising page
 @param imageCaption An optional caption that will be displayed with the image on the Just Giving website
 @param fundraisingPage The page to upload to
 @param isDefault Whether or not the image should be set as the fundraising page's default image once upload is complete
 @param uploadCompletion The completion block containing a potential `NSError` if the request fails
 */
 - (void)uploadImage:(nonnull UIImage *)fundraisingImage caption:(nullable NSString *)imageCaption toFundraisingPage:(nonnull JGFundraisingPage *)fundraisingPage isDefault:(BOOL)isDefault completion:(nullable JGUploadImageCompletion)uploadCompletion;
@end
