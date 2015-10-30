//
//  JGFundraisingPageEvent.h
//  JustGivingKit
//
//  Created by Joel Trew on 30/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import "JGFundraisingPage.h"

@interface JGFundraisingPageEvent : JGFundraisingPage

/**
 @abstract The unqiue event identifier
 */
@property (nonatomic, copy) NSString *eventId;

/**
 @abstract The event's name
 */
@property (nonatomic, copy) NSString *eventName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
