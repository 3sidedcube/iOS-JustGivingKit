//
//  JGSearchController.h
//  JustGivingKit
//
//  Created by Joel Trew on 30/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>
@import ThunderRequest;
@class JGSearchQuery;

@interface JGSearchController : NSObject

typedef void (^JGPerformSearchCompletion)(NSArray *results, NSError *error);

/**
 @abstract Searches JustGiving with a given search query
 @param searchQuery A query to search the api with
 @param completion Block which returns an array of results which can be varying object types represented as a dictionary
 */
- (void)performSearchWithQuery:(JGSearchQuery *)searchQuery withCompletion:(JGPerformSearchCompletion)completion;

@end
