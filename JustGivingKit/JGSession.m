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
#import "JGUser.h"

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
        
        self.applicationId = [[NSBundle mainBundle] infoDictionary][@"JGApplicationId"];
        self.requestController = [[TSCRequestController alloc] initWithBaseAddress:[NSString stringWithFormat:@"%@/%@/v1", JGAPIBaseAddress, self.applicationId]];
        [self restoreLoggedInState];
    }
    
    return self;
}

- (void)restoreLoggedInState
{
    TSCRequestCredential *credential = [TSCRequestCredential retrieveCredentialWithIdentifier:@"JGUserLogin"];
    if (credential) {
        [self loginWithCredential:credential completion:^(NSObject *user, NSError *error) {
            if (!error) {
                [self willChangeValueForKey:@"loggedIn"];
                _loggedIn = YES;
                [self didChangeValueForKey:@"loggedIn"];
            }
        }];
    }
}

- (void)loginWithEmail:(NSString *)email password:(NSString *)password completion:(JGSessionLoginCompletion)completion
{
    [self.requestController post:@"account/validate" withURLParamDictionary:nil bodyParams:@{@"email":email, @"password":password} completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error || response.status != 200) {
            
            NSError *responseError = nil;
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:@"Unable to login" forKey:NSLocalizedDescriptionKey];
            responseError = [NSError errorWithDomain:JGAPIBaseAddress code:response.status userInfo:errorDetail];
            
            completion(nil, responseError);
            return;
        }
        
        TSCRequestCredential *credential = [[TSCRequestCredential alloc] initWithUsername:email password:password];
        credential.authorizationToken = [[[NSString stringWithFormat:@"%@:%@", email, password] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:kNilOptions];
        credential.authorizationToken = [NSString stringWithFormat:@"Basic %@", credential.authorizationToken];
        self.requestController.sharedRequestCredential = credential;
        
        self.requestController.sharedRequestHeaders = [[NSMutableDictionary alloc] initWithObjects:@[self.requestController.sharedRequestCredential.authorizationToken] forKeys:@[@"Authorization"]];
        
        if ([TSCRequestCredential storeCredential:credential withIdentifier:@"JGUserLogin"]) {
            [self willChangeValueForKey:@"loggedIn"];
            _loggedIn = YES;
            [self didChangeValueForKey:@"loggedIn"];
        }
        
        [self retrieveUserAccountInformationWithCompletion:^(JGUser *user, NSError *error) {
            if (error) {
                completion(nil, error);
                return;
            }
            
            completion(user, error);
        }];
    }];
}

- (void)loginWithCredential:(TSCRequestCredential *)credential completion:(JGSessionLoginCompletion)completion
{
    [self loginWithEmail:credential.username password:credential.password completion:completion];
}

- (void)retrieveUserAccountInformationWithCompletion:(JGSessionLoginCompletion)completion
{
    [self.requestController get:@"account" completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (!response.dictionary) {
            completion(nil, error);
            return;
        }
        
        completion([[JGUser alloc] initWithDictionary:response.dictionary], error);
    }];
}

@end
