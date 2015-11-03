//
//  JGDonation.h
//  JustGivingKit
//
//  Created by Sam Houghton on 03/11/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGDonation : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong) NSNumber *donationAmount;
@property (nonatomic, strong) NSString *donorDisplayName;
@property (nonatomic, strong) NSString *donorRealName;
@property (nonatomic, strong) NSString *donorMessage;

@end