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

@property (nonatomic, strong) TSCRequestController *requestController;

- (void)performSearchWithQuery:(JGSearchQuery *)searchQuery withCompletion:(JGPerformSearchCompletion)completion;

@end
