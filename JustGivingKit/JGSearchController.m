//
//  JGSearchController.m
//  JustGivingKit
//
//  Created by Joel Trew on 30/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import "JGSearchController.h"
#import "JGSearchQuery.h"
#import "JGDefines.h"

@interface JGSearchController ()

@property (nonatomic, strong) TSCRequestController *requestController;

@end

@implementation JGSearchController

- (instancetype)init
{
    if (self = [super init]) {
        
        self.requestController = [[TSCRequestController alloc] initWithBaseAddress:[NSString stringWithFormat:@"%@/%@/v1", JGAPIBaseAddress, [[NSBundle mainBundle] infoDictionary][@"JGApplicationId"]]];
        self.requestController.sharedRequestHeaders[@"Accept"] = @"application/json";
        
    }
    
    return self;
}

- (void)performSearchWithQuery:(JGSearchQuery *)searchQuery withCompletion:(JGPerformSearchCompletion)completion
{
    NSString *address = [searchQuery requestAddress];
    
    [self.requestController get:address completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error || response.status != 200) {
            completion(nil, error);
            return;
        }
        
        if (response.dictionary && [response.dictionary isKindOfClass:[NSDictionary class]] && response.dictionary[@"GroupedResults"] && [response.dictionary[@"GroupedResults"] isKindOfClass:[NSArray class]]) {
            
            NSArray *resultsGroupedArray = response.dictionary[@"GroupedResults"];
            
            if (resultsGroupedArray.count > 0) {
                
                NSDictionary *resultDictionary = resultsGroupedArray.firstObject;
                NSArray *eventsResultsArray = resultDictionary[@"Results"];
                completion(eventsResultsArray,error);
                return;
                
            }
        }
        
        completion(nil,error);
    }];
}

@end
