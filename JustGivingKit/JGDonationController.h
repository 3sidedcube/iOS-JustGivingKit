//
//  JGDonationController.h
//  JustGivingKit
//
//  Created by Joel Trew on 12/11/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JGFundraisingPage;
@class JGUser;
@class JGDonation;

@interface JGDonationController : NSObject

typedef void (^JGDonationsForCharityCompletion)(NSArray<JGDonation *> *donations, NSError *error);

- (NSURL *)donationUrlForCharityId:(NSString *)charityId donationAmount:(NSNumber *)donationAmount;

/**
 @abstract Creates a donation url for a given fundraising page
 @discussion This method creates a url which you can use to push the user out to a donation page via web view, the url has an exitURL which returns the user back to your app when finished
 @param fundraisingPage The fundraising page to create the url for
 @param donationAmount The amount the user is donating (This is converted to a float)
 @return The donation link as an NSURL
 */
- (NSURL *)donateUrlForFundraisingPage:(JGFundraisingPage *)fundraisingPage withDonationAmount:(NSNumber *)donationAmount;

- (void)getDonationsForCharity:(NSString *)charityId completion:(JGDonationsForCharityCompletion)completion;

@end
