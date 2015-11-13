//
//  JGDonation.h
//  JustGivingKit
//
//  Created by Sam Houghton on 03/11/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGDonation : NSObject

/**
 @abstract The amount that was donated
 */
@property (nonatomic, copy) NSNumber *donationAmount;

/**
 @abstract The date of the donation
 */
@property (nonatomic, strong) NSDate *donationDate;

/**
 @abstract The display name of the donor
 */
@property (nonatomic, copy) NSString *donorDisplayName;

/**
 @abstract The donors real full name
 */
@property (nonatomic, copy) NSString *donorRealName;

/**
 @abstract The message the donor left when giving the donation
 */
@property (nonatomic, copy) NSString *donorMessage;

/**
 @abstract The donors profile image url
 */
@property (nonatomic, strong) NSURL *donorProfileImageUrl;

/**
 @abstract Unique page identifier that teh donation belongs to
 */
@property (nonatomic, copy)NSString *pageShortName;

/**
 @abstract Initialises the object with a dictionary representation of itself
 @param dictionary A dictionary representation of `JGDonation`.
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end