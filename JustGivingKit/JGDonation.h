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

@property (nonatomic, copy) NSNumber *donationAmount;
@property (nonatomic, strong) NSDate *donationDate;
@property (nonatomic, copy) NSString *donorDisplayName;
@property (nonatomic, copy) NSString *donorRealName;
@property (nonatomic, copy) NSString *donorMessage;
@property (nonatomic, strong) NSURL *donorProfileImageUrl;

@end