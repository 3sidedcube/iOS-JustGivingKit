//
//  JGCharityController.h
//  JustGivingKit
//
//  Created by Joel Trew on 12/11/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JGUser;

@interface JGCharityController : NSObject

typedef void (^JGAmountCompletion)(NSNumber *amount, NSError *error);
typedef void (^JGTotalRaisedCompletion)(NSNumber *totalRaised, NSError *error);

/**
 @abstract Adds the total amount raised including money donated directly to a charity
 @param charityId A valid JustGiving charityId
 @param perAmountCompletion completion block which gets called on every amount being added
 @param completion completion block which gets called on the total completely added up
 */
- (void)totalRaisedForCharity:(NSString *)charityId perAmountCompletion:(JGAmountCompletion)amountCompletion completion:(JGTotalRaisedCompletion)completion;

@end
