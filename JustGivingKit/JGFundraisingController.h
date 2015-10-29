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

- (void)getFundraisingPagesWithCompletion:(JGFetchPagesCompletion)completion;

- (void)getFundraisingPagesWithCharityId:(NSString *)charityId forUser:(JGUser *)user withCompletion:(JGFetchPagesCompletion)completion;

- (void)getFundraisingPages:(NSString *)charityId forUser:(NSString *)userEmail withCompletion:(JGFetchPagesCompletion)completion;


-(NSObject *)getMoreDetailsforFundraisingPage:(NSObject *)pageShortName;

@end
