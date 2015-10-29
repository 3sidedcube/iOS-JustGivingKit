//
//  JGUser.m
//  JustGivingKit
//
//  Created by Sam Houghton on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import "JGUser.h"

@implementation JGUser

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        if (dictionary[@"firstName"]) {
            self.firstName = dictionary[@"firstName"];
        }
        
        if (dictionary[@"lastName"]) {
            self.lastName = dictionary[@"lastName"];
        }
        
        if (dictionary[@"profileImageUrls"]) {
            
            for (NSDictionary *imageDictionary in dictionary[@"profileImageUrls"]) {
                
                if (imageDictionary[@"Value"]) {
                    self.profileUrl = [NSURL URLWithString:imageDictionary[@"Value"]];
                }
                
                if (imageDictionary[@"Key"] && [imageDictionary[@"Key"] isEqualToString:@"Size150x150Face"] && self.profileUrl) {
                    break;
                }
            }
        }
    }
    
    return self;
}

@end
