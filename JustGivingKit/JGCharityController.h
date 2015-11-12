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

- (void)getTotalRaisedForCharity:(NSString *)charityId forUser:(JGUser *)user perAmountCompletion:(JGAmountCompletion)amountCompletion completion:(JGTotalRaisedCompletion)completion;

@end
