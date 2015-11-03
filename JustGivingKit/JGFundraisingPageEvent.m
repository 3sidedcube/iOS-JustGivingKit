//
//  JGFundraisingPageEvent.m
//  JustGivingKit
//
//  Created by Joel Trew on 30/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import "JGFundraisingPageEvent.h"

@implementation JGFundraisingPageEvent

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        if (dictionary[@"eventId"]) {
            self.eventId = dictionary[@"eventId"];
        }
        
        if (dictionary[@"eventName"]) {
            self.eventName = dictionary[@"eventName"];
        }
    }
    
    return self;
}



@end
