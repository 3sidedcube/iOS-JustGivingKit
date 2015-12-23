//
//  JGFundraisingController.m
//  JustGivingKit
//
//  Created by Sam Houghton on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

@import ThunderRequest;

#import "JGFundraisingController.h"
#import "JGFundraisingPage.h"
#import "JGSession.h"
#import "JGDonation.h"
#import <JustGivingKit/JustGivingKit-Swift.h>

@implementation JGFundraisingController

- (void)getFundraisingPagesWithCharityId:(NSString *)charityId forUser:(JGUser *)user withCompletion:(JGFetchPagesCompletion)completion
{
    NSString *userEmail = @"";
    
    if (user) {
        userEmail = user.email;
    }
    
    [self getFundraisingPagesWithCharityId:charityId forUserEmail:userEmail withCompletion:^(NSArray *pages, NSError *error) {
        
        if (completion) {
            if (!error) {
                
                completion(pages, error);
            }
        }
    }];
}

- (void)getFundraisingPagesWithCharityId:(NSString *)charityId forUserEmail:(NSString *)userEmail withCompletion:(JGFetchPagesCompletion)completion
{
    NSString *encodedEmail = [userEmail stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *getAddress = [NSString stringWithFormat:@"account/%@/pages?charityid=%@",encodedEmail, charityId];
    
    [self requestPagesWithAddress:getAddress WithCompletion:^(NSArray *pages, NSError *error) {
        if (completion) {
            if (!error) {
                
                completion(pages, error);
            }
        }
    }];
}

- (void)getFundraisingPagesWithCompletion:(JGFetchPagesCompletion)completion
{
    [self requestPagesWithAddress:@"fundraising/pages" WithCompletion:^(NSArray *pages, NSError *error) {
        if (completion) {
            if (!error) {
                
                completion(pages, error);
            }
        }
    }];
}

- (void)getMoreDetailsForFundraisingPage:(JGFundraisingPage *)fundraisingPage withCompletion:(JGFetchPageDetailCompletion)completion
{
    if (fundraisingPage.pageShortName && [fundraisingPage.pageShortName isEqualToString:@""]) {
        
        NSError *emptyError = [NSError errorWithDomain:@"com.threesidedcube.JustGivingKit" code:400 userInfo:@{NSLocalizedDescriptionKey: @"Unable to search using a blank page name. Please provide a valid fundraising page object with a real page short name"}];
        completion(nil, emptyError);
        return;
    }
    
    NSString *getAddress = [NSString stringWithFormat:@"fundraising/pages/%@",fundraisingPage.pageShortName];
    
    [[JGSession sharedSession].requestController get:getAddress completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error || response.status != 200) {
            
            completion(nil, error);
            return;
        }
        
        JGFundraisingPage *page = [[JGFundraisingPage alloc] initWithDictionary:response.dictionary];
        completion(page, error);
    }];
}

- (void)getAvailabilityOfFundraisingPageShortName:(nonnull NSString *)shortName completion:(nonnull JGShortPageNameAvailabilityCompletion)completion
{
    JGFundraisingPage *fundraisingPage = [JGFundraisingPage new];
    fundraisingPage.pageShortName = shortName;
    
    if ([shortName isEqualToString:@""]) {
        
        NSError *emptyError = [NSError errorWithDomain:@"com.threesidedcube.JustGivingKit" code:400 userInfo:@{NSLocalizedDescriptionKey: @"Unable to search using a blank page name. Please provide a valid string to search for"}];
        completion(NO, emptyError);
        return;
    }
    
    [self getMoreDetailsForFundraisingPage:fundraisingPage withCompletion:^(JGFundraisingPage *page, NSError *error) {
        
        if ((error && error.code != 404) || page) {
            completion(NO, error);
            return;
        }
        
        completion(YES, nil);
        
    }];
    
}

- (void)getDonationsForFundraisingPage:(JGFundraisingPage *)fundraisingPage withCompletion:(JGFetchPageDonationsCompletion)completion
{
    NSString *getAddress = [NSString stringWithFormat:@"fundraising/pages/%@/donations",fundraisingPage.pageShortName];
    
    [[JGSession sharedSession].requestController get:getAddress completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            
            completion(nil, error);
            return;
        }
        
        NSMutableArray *donations = [NSMutableArray new];
        
        for (NSDictionary *donationDictionary in response.dictionary[@"donations"]) {
            [donations addObject:[[JGDonation alloc] initWithDictionary:donationDictionary]];
        }
        
        completion([NSArray arrayWithArray:donations], nil);
    }];
}

- (void)getSuggestedPageShortNamesWithPreferredString:(nonnull NSString *)preferredString completion:(nonnull JGSuggestedNamesCompletion)completion
{
    [[JGSession sharedSession].requestController get:@"fundraising/pages/suggest?preferredName=(:preferredName)" withURLParamDictionary:@{@"preferredName":preferredString} completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
       
        if (error) {
            
            completion(nil, error);
            return;
        }
        
        if (response.dictionary && [response.dictionary isKindOfClass:[NSDictionary class]] && response.dictionary[@"Names"] && [response.dictionary[@"Names"] isKindOfClass:[NSArray class]]) {
            
            completion(response.dictionary[@"Names"], nil);
            return;
        }
        
        completion(nil, [NSError errorWithDomain:@"com.threesidedcube.JustGivingKit" code:500 userInfo:@{NSLocalizedDescriptionKey: @"The server returned an invalid response"}]);
        
    }];
}

- (void)requestPagesWithAddress:(NSString *)address WithCompletion:(JGFetchPagesCompletion)completion
{
    [[JGSession sharedSession].requestController get:address completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error || response.status != 200) {
            
            completion(nil, error);
            return;
        }
        
        NSMutableArray *pages = [NSMutableArray new];
        
        for (NSDictionary *pageInfo in response.array) {
            
            NSLog(@"pageinfo: %@",pageInfo);
            JGFundraisingPage *page = [[JGFundraisingPage alloc]initWithDictionary:pageInfo];
            [pages addObject:page];
        }
        
        completion([pages copy],error);
    }];
}

- (void)totalFundsRaisedByUser:(JGUser *)user ForCharityId:(NSString *)charityId completion:(JGRaisedAmountCompletion)completion
{
    __block double totalRaised = 0;
    [self getFundraisingPagesWithCharityId:charityId forUser:user withCompletion:^(NSArray *pages, NSError *error) {
        
        for (JGFundraisingPage *page in pages) {
            
            if (page.raisedAmount) {
                
                double raisedAmount = page.raisedAmount.doubleValue;
                totalRaised += raisedAmount;
            }
        }
        
        completion([NSNumber numberWithDouble:totalRaised], error);
    }];
}

- (void)createFundraisingPage:(JGFundraisingPage *)fundraisingPage withCompletion:(JGCreateFundraisingPageCompletion)completion
{
    NSMutableDictionary *payload = [NSMutableDictionary new];
    
    payload[@"charityId"] = fundraisingPage.charityId;
    payload[@"pageShortName"] = fundraisingPage.pageShortName;
    payload[@"pageTitle"] = fundraisingPage.pageTitle;
    payload[@"eventId"] = fundraisingPage.eventId;
    if (fundraisingPage.targetAmount) { payload[@"targetAmount"] = [fundraisingPage.targetAmount stringValue]; }
    payload[@"justGivingOptIn"] = @"false";
    payload[@"charityOptIn"] = @"false";
    payload[@"charityFunded"] = @"false";
    if (fundraisingPage.activityType) {
        payload[@"activityType"] = [JGFormatter stringForActivityType:fundraisingPage.activityType];
    }
    
    [[JGSession sharedSession].requestController put:@"fundraising/pages" bodyParams:payload completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error || response.status != 201) {
            
            if (response.status == 409) {
                
                // Page was not created
                completion(nil, error);
                return;
                
            } else {
                
                completion(nil, error);
            }
            
        } else {
            
            // If the page has been successfully created then we'll go get the full details for it
            [self getMoreDetailsForFundraisingPage:fundraisingPage withCompletion:^(JGFundraisingPage *page, NSError *error) {
                
                if (error) {
                    completion(nil, error);
                    
                } else {
                    completion(page, error);
                }
            }];
        }
    }];
}

- (void)createFundraisingPage:(nonnull JGFundraisingPage *)fundraisingPage image:(nonnull UIImage *)fundraisingImage completion:(nullable JGCreateFundraisingPageCompletion)completion
{
    [self createFundraisingPage:fundraisingPage withCompletion:^(JGFundraisingPage *page, NSError *error) {
        
        if (error || !fundraisingPage) {
            
            if (completion) {
                completion(fundraisingPage, error);
            }
            return;
        }
        
        [self uploadImage:fundraisingImage caption:nil toFundraisingPage:fundraisingPage isDefault:true completion:^(NSError * _Nullable error) {
            
            if (completion) {
                completion(fundraisingPage, error);
            }
            
        }];
        
    }];
    
}

- (void)deleteFundraisingPage:(JGFundraisingPage *)fundraisingPage withCompletion:(JGDeleteFundraisingPageCompletion)completion;
{
    [self deleteFundraisingPageWithShortName:fundraisingPage.pageShortName withCompletion:^(NSError *error) {
        
        if (error) {
            completion(error);
        } else {
            completion(nil);
        }
    }];
}

- (void)deleteFundraisingPageWithShortName:(NSString *)pageShortName withCompletion:(JGDeleteFundraisingPageCompletion)completion
{
    [[JGSession sharedSession].requestController delete:[NSString stringWithFormat:@"fundraising/pages/%@", pageShortName] completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            completion(error);
        } else {
            completion(nil);
        }
    }];
}

- (void)uploadImage:(nonnull UIImage *)fundraisingImage caption:(nullable NSString *)imageCaption toFundraisingPage:(nonnull JGFundraisingPage *)fundraisingPage isDefault:(BOOL)isDefault completion:(nullable JGUploadImageCompletion)uploadCompletion
{
    [[JGSession sharedSession].requestController post:@"fundraising/pages/(:pageShortName)/images/(:isDefault)?caption=(:imageCaption)" withURLParamDictionary:@{@"pageShortName":fundraisingPage.pageShortName, @"isDefault": isDefault ? @"default" : @"", @"imageCaption" : imageCaption ?: @""} bodyParams:@{@"image":fundraisingImage} contentType:TSCRequestContentTypeImagePNG completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
        if (uploadCompletion) {
            uploadCompletion(error);
        }
        
    }];
}

@end
