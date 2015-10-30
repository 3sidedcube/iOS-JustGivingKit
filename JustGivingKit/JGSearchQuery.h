//
//  JGSearchQuery.h
//  JustGivingKit
//
//  Created by Joel Trew on 30/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGSearchQuery : NSObject

typedef NS_ENUM(NSUInteger, JGSearchQueryIndex) {
    JGSearchQueryIndexCharity,
    JGSearchQueryIndexEvent,
    JGSearchQueryIndexFundraiser,
    JGSearchQueryIndexGlobalproject,
    JGSearchQueryIndexCrowdfunding
};

/**
 @abstract Your search term or terms
 */
@property (nonatomic, copy) NSString *searchTerm;

/**
 @abstract Boolean to group search results by index
 */
@property (nonatomic) BOOL groupResultsByIndex;

/**
 @abstract Narrow search results by index: Charity, Event, Fundraiser, Globalproject, Crowdfunding
 */
@property (nonatomic)JGSearchQueryIndex index;

/**
 @abstract Maximum number of search results to return
 */
@property (nonatomic) NSNumber *limit;

/**
 @abstract The result paging offset
 */
@property (nonatomic) NSNumber *offset;

/**
 @abstract Two letter ISO country code for localised results
 */
@property (nonatomic, copy) NSString *countryCode;

/**
 @abstract charityId to narrow search
 */
@property (nonatomic, copy) NSString *charityId;

/**
 @abstract eventId to narrow search
 */
@property (nonatomic, copy) NSString *eventId;

/**
 @abstract campaignId to narrow search
 */
@property (nonatomic, copy) NSString *campaignId;

/**
 @abstract companyAppealId to narrow search
 */
@property (nonatomic, copy) NSString *companyAppealId;

/**
 @abstract causeId to narrow search
 */
@property (nonatomic, copy) NSString *causeId;

/**
 @abstract Creates a search query object with specific properties
 @discussion Use this method to create a search query object which can then be give to a peformQuery function
 @param searchTerm The search term you are looking for
 @param groupResults A boolean which determines if results should be grouped or not
 @param index An enum containing a specified search filter
 @param limit The limit of rsults you expect back
 @param offset The result paging offset
 @param countryCode A two letter ISO country code for localised results
 
 */
+ (instancetype)createQueryWithSearchTerm:(NSString *)searchTerm groupResults:(BOOL)groupResults searchIndex:(JGSearchQueryIndex)index limit:(NSNumber *)limit offset:(NSNumber *)offset countryCode:(NSString *)countryCode;

/**
 @abstract Returns a string version of the search index enum
 @discussion This function is used when creating a get request address
 @param searchQueryIndex The enum to convert to string
 */
- (NSString *)stringForSearchQueryIndex:(JGSearchQueryIndex)searchQueryIndex;

/**
 @abstract Returns a get address string with params based on the search query object values
 @discussion This function is used when creating a get request address
 */
- (NSString *)requestAddress;
@end


