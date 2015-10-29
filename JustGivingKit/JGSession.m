//
//  JGSession.m
//  JustGivingKit
//
//  Created by Sam Houghton on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import "JGSession.h"
@import ThunderBasics;
@import ThunderRequest;
#import "JGDefines.h"

@interface JGSession ()

@property (nonatomic, strong) NSString *applicationId;

@end

@implementation JGSession

static JGSession *sharedSession = nil;

+ (JGSession *)sharedSession
{
    @synchronized(self) {
        if (sharedSession == nil) {
            sharedSession = [[self alloc] init];
        }
    }
    
    return sharedSession;
}

- (id)init
{
    if (self = [super init]) {
        
        self.requestController = [[TSCRequestController alloc] initWithBaseAddress:JGAPIBaseAddress];
        self.applicationId = [[NSBundle mainBundle] infoDictionary][@"JGApplicationId"];
    }
    
    return self;
}

- (void)restoreLoggedInState
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *credentials = [userDefaults objectForKey:BKAuthorizationCredentials];
    
    if (credentials) {
        
        if ([credentials[@"timestamp"] intValue] > [[NSDate date] timeIntervalSince1970]) {
            
            self.authorizationToken = credentials[@"token"];
            self.requestController.sharedRequestHeaders[@"Authorization"] = self.authorizationToken;
            _loggedIn = YES;
        }
    }
}

- (void)loginWithEmail:(NSString *)email password:(NSString *)password completion:(JGSessionLoginCompletion)completion
{
    [self.requestController post:@"/(:appId)/v1/account/validate" withURLParamDictionary:@{@"appID":self.applicationId} bodyParams:@{@"email":email, @"password":password} completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error || response.status != 200) {
            
            NSError *responseError = nil;
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:@"Unable to login" forKey:NSLocalizedDescriptionKey];
            responseError = [NSError errorWithDomain:JGAPIBaseAddress code:response.status userInfo:errorDetail];
            
            completion(nil, responseError);
            return;
        }
        
        TSCRequestCredential *credential = [[TSCRequestCredential alloc] initWithUsername:email password:password];
        credential.authorizationToken = [NSString stringWithFormat:@"Basic %@", [[[NSString stringWithFormat:@"%@:%@", email, password] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedDataWithOptions:kNilOptions]];
        self.requestController.sharedRequestCredential = credential;
        
        [self willChangeValueForKey:@"loggedIn"];
        _loggedIn = YES;
        [self didChangeValueForKey:@"loggedIn"];
        
        TSCre
        
    }];
}

@end
