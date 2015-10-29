//
//  JGFundraisingController.h
//  JustGivingKit
//
//  Created by Sam Houghton on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGFundraisingController : NSObject

typedef void (^JGFetchPagesCompletion)(NSArray *pages, NSError *error);

- (void)getFundraisingPagesWithCompletion:(JGFetchPagesCompletion)completion;


-(NSObject *)getMoreDetailsforFundraisingPage:(NSObject *)pageShortName;

@end
