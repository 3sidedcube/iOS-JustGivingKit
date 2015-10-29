//
//  JGUser.h
//  JustGivingKit
//
//  Created by Sam Houghton on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGUser : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 @abstract The users first name
 */
@property (nonatomic, copy) NSString *firstName;

/**
 @abstract The users first name
 */
@property (nonatomic, copy) NSString *lastName;

/**
 @abstract The url to the users profile image
 */
@property (nonatomic, strong) NSURL *profileUrl;

@end
