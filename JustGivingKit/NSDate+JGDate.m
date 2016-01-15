//
//  NSDate+JGDate.m
//  JustGivingKit
//
//  Created by Sam Houghton on 03/11/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import "NSDate+JGDate.h"

@implementation NSDate (JGDate)

+ (NSDate *)dateWithODataString:(NSString *)oDataString
{
    // Setup an NSError object to catch any failures
    NSError *error = nil;
    
    // create the NSRegularExpression object and initialize it with a pattern
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]+(?:[0-9]*)?" options:NSRegularExpressionCaseInsensitive error:&error];
    
    //Find the location of the match of our regex in the string
    NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:oDataString options:0 range:NSMakeRange(0, [oDataString length])];
    
    //Check that we have actually found something
    if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
        
        //Get the string at the substring our regex found
        NSString *substringForFirstMatch = [oDataString substringWithRange:rangeOfFirstMatch];
        
        // return the matching string
        return [NSDate dateWithTimeIntervalSince1970:substringForFirstMatch.doubleValue/1000];
    }
    
    //Error, return nothing
    return nil;
}

@end
