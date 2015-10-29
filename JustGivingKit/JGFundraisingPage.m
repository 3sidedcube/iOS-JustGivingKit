//
//  JGFundraisingPage.m
//  JustGivingKit
//
//  Created by Joel Trew on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import "JGFundraisingPage.h"

@implementation JGFundraisingPage

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        if (dictionary[@"pageId"]) {
            self.pageId = dictionary[@"pageId"];
        }
        
        if (dictionary[@"pageTitle"]) {
            self.pageTitle = dictionary[@"pageTitle"];
        }
        
        if (dictionary[@"pageShortName"]) {
            self.pageShortName = dictionary[@"pageShortName"];
        }
        
        if (dictionary[@"raisedAmount"]) {
            self.pageShortName = dictionary[@"raisedAmount"];
        }
        
    }
    
    return self;
}

@end
