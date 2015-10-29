//
//  JGFundraisingController.m
//  JustGivingKit
//
//  Created by Sam Houghton on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

@import ThunderRequest;

#import "JGFundraisingController.h"
#import "JGSession.h"

@implementation JGFundraisingController

- (void)getFundraisingPagesWithCompletion:(JGFetchPagesCompletion)completion {
    [[JGSession sharedSession].requestController get:@"fundraising/pages" completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error || response.status != 200) {
            completion(nil, error);
        }
        
        NSLog(@"response: %d", response.status);
        
        
    }];
}

- (NSObject *)getMoreDetailsforFundraisingPage:(NSObject *)pageShortName
{
    
    return @"";

}





@end
