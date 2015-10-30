//
//  JGEventController.h
//  JustGivingKit
//
//  Created by Joel Trew on 30/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JGUser;

@interface JGEventController : NSObject

typedef void (^JGFetchEventsCompletion)(NSArray *events, NSError *error);

- (void)getEventsForUser:(JGUser *)user withCharityId:(NSString *)charityId completion:(JGFetchEventsCompletion)completion;

@end
