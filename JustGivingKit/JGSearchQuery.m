//
//  JGSearchQuery.m
//  JustGivingKit
//
//  Created by Joel Trew on 30/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import "JGSearchQuery.h"

@implementation JGSearchQuery

+ (instancetype)createQueryWithSearchTerm:(NSString *)searchTerm groupResults:(BOOL)groupResults searchIndex:(JGSearchQueryIndex)index limit:(NSNumber *)limit offset:(NSNumber *)offset countryCode:(NSString *)countryCode
{
     JGSearchQuery *query = [[self alloc]init];
    
     query.searchTerm = searchTerm;
     query.groupResultsByIndex = groupResults;
     query.index = index;
     query.limit = limit;
     query.offset = offset;
     query.countryCode = countryCode;
    
     return query;
}

- (NSString *)stringForSearchQueryIndex:(JGSearchQueryIndex)searchQueryIndex
{
    switch (searchQueryIndex) {
        case JGSearchQueryIndexCharity:
        {
            return @"charity";
            break;
        }
            
        case JGSearchQueryIndexEvent:
        {
            return @"event";
            break;
        }
            
        case JGSearchQueryIndexFundraiser:
        {
            return @"fundraiser";
            break;
        }
            
        case JGSearchQueryIndexGlobalproject:
        {
            return @"globalproject";
            break;
        }
            
        case JGSearchQueryIndexCrowdfunding:
        {
            return @"crowdfunding";
            break;
        }
            
        default:
            break;
    }

}

- (NSString *)requestAddress
{
    NSString *address = [NSString stringWithFormat:@"onesearch"];
    
    if(self.searchTerm) {
        address = [address stringByAppendingString:[NSString stringWithFormat:@"?q=%@",self.searchTerm]];
    }
    
    if (self.groupResultsByIndex) {
        address = [address stringByAppendingString:@"&g=true"];
    } else {
        address = [address stringByAppendingString:@"&g=false"];
    }
    
    if (self.index) {
       address = [address stringByAppendingString:[NSString stringWithFormat:@"&i=%@", [self stringForSearchQueryIndex:self.index]]];
    }
    
    if (self.limit) {
        address = [address stringByAppendingString:[NSString stringWithFormat:@"&limit=%@",[self.limit stringValue]]];
    }
    
    if (self.offset) {
        address = [address stringByAppendingString:[NSString stringWithFormat:@"&offset=%@",[self.offset stringValue]]];
    }
    
    if (self.countryCode) {
        address = [address stringByAppendingString:[NSString stringWithFormat:@"&country=%@",self.countryCode]];
    }
    
    if (self.charityId) {
        address = [address stringByAppendingString:[NSString stringWithFormat:@"&charityId=%@",self.charityId]];
    }
    
    if (self.eventId) {
        address = [address stringByAppendingString:[NSString stringWithFormat:@"&eventId=%@",self.eventId]];
    }
    
    if (self.campaignId) {
        address = [address stringByAppendingString:[NSString stringWithFormat:@"&campaignId=%@",self.campaignId]];
    }
    
    if (self.companyAppealId) {
        address = [address stringByAppendingString:[NSString stringWithFormat:@"&companyAppealId=%@",self.companyAppealId]];
    }
    
    if (self.causeId) {
        address = [address stringByAppendingString:[NSString stringWithFormat:@"&causeId=%@",self.causeId]];
    }
    
    return address;
}

@end
