//
//  JGFundraisingPage.h
//  JustGivingKit
//
//  Created by Joel Trew on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGFundraisingPage : NSObject

/**
 @abstract A unique fundraising page Id
 */
@property (nonatomic, copy) NSString *pageId;

/**
 @abstract The title of the fundraising page
 */
@property (nonatomic, copy) NSString *pageTitle;

/**
 @abstract A unique identifier for the fundraising page that is used to make requests
 */
@property (nonatomic, copy) NSString *pageShortName;

/**
 @abstract The total amount raised for a given fundraising page
 */
@property (nonatomic, copy) NSNumber *raisedAmount;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
