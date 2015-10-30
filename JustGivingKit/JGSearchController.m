//
//  JGSearchController.m
//  JustGivingKit
//
//  Created by Joel Trew on 30/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import "JGSearchController.h"
#import "JGSearchQuery.h"

@implementation JGSearchController

- (void)performSearchWithQuery:(JGSearchQuery *)searchQuery withCompletion:(JGPerformSearchCompletion)completion
{
    NSString *address = [searchQuery requestAddress];
    
    [self.requestController get:address completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error || response.status != 200) {
            completion(nil, error);
            return;
        }
        
        NSMutableArray *pages = [NSMutableArray new];
        
        for (NSDictionary *result in response.array) {
            NSLog(@"results: %@", result);
        }
        
        completion([pages copy],error);
    }];

}

@end
