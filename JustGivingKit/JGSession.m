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
@property (nonatomic, copy) NSString *oauthCallbackUrl;

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
        
        self.requestController.sharedRequestHeaders[@"Authorization"] = credential.authorizationToken;

        [self loginWithCredential:credential completion:^(NSObject *user, NSError *error) {
            if (!error) {
                
                [self willChangeValueForKey:@"loggedIn"];
                _loggedIn = YES;
                [self didChangeValueForKey:@"loggedIn"];
            }
        }];
    }
}

- (void)logoutCurrentUser
{
    [TSCRequestCredential deleteCredentialWithIdentifier:@"JGUserLogin"];
}

- (void)requestUserAuthentication
{
    NSString *kickoutUrl = [NSString stringWithFormat:@"%@/connect/authorize?client_id=%@&response_type=code&scope=openid+profile+email+account+fundraise+offline_access&redirect_uri=", JGAPIAuthBaseAddress, self.applicationId];
    
    NSString *callbackIdentifier = [NSString stringWithFormat:@"%@.JGAuthUrl", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]];
    
    NSArray *urlTypes = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"];
    
    NSString *callBackUrl;
    
    if (urlTypes && urlTypes.count > 0) {
        
        for (NSDictionary *urlInfoDictionary in urlTypes) {
            
            if (urlInfoDictionary && urlInfoDictionary[@"CFBundleURLName"]
                && [urlInfoDictionary[@"CFBundleURLName"] isEqualToString:callbackIdentifier]) {
                
                NSArray *urlSchemes = urlInfoDictionary[@"CFBundleURLSchemes"];
                
                if (urlSchemes && urlSchemes.count > 0) {
                    callBackUrl = urlSchemes.firstObject;
                }
            }
        }
    }
    
    if (!callBackUrl) {
        NSLog(@"No Auth callback url implmented please add to url types");
        return;
    }
    
    self.oauthCallbackUrl = [NSString stringWithFormat:@"%@://oauth", callBackUrl];
    
    callBackUrl = [self.oauthCallbackUrl urlEncodedString];
    
    kickoutUrl = [NSString stringWithFormat:@"%@%@&nonce=ba3c9a58dff94a86aa633e71e6afc4e3", kickoutUrl, callBackUrl];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kickoutUrl]];
}

- (void)handleAuthenticationCallbackWithUrl:(NSURL *)url
{
    NSMutableDictionary *queryStringDictionary = [[NSMutableDictionary alloc] init];
    NSArray *urlComponents = [[url.absoluteString componentsSeparatedByString:@"?"].lastObject componentsSeparatedByString:@"&"];
    
    for (NSString *keyValuePair in urlComponents)
    {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
        NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];
        
        [queryStringDictionary setObject:value forKey:key];
    }
    
    NSString *authCode = queryStringDictionary[@"code"];
    
    TSCRequestController *authRequestController = [[TSCRequestController alloc] initWithBaseAddress:JGAPIAuthBaseAddress];
    
    NSMutableDictionary *postDictionary = [NSMutableDictionary new];
    [postDictionary setValue:authCode forKey:@"code"];
    [postDictionary setValue:@"authorization_code" forKey:@"grant_type"];
    [postDictionary setValue:self.oauthCallbackUrl forKey:@"redirect_uri"];
    
    NSMutableDictionary *requestHeaders = [NSMutableDictionary new];
    
    NSString *baseEncodedAppDetails = [[[NSString stringWithFormat:@"%@:%@", [[NSBundle mainBundle] infoDictionary][@"JGApplicationId"], [[NSBundle mainBundle] infoDictionary][@"JGApplicationSecret"]] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:kNilOptions];
    
    [requestHeaders setValue:[NSString stringWithFormat:@"Basic %@", baseEncodedAppDetails] forKey:@"Authorization"];
    
    [authRequestController setSharedRequestHeaders:requestHeaders];
    
    [authRequestController post:@"connect/token" withURLParamDictionary:nil bodyParams:postDictionary contentType:TSCRequestContentTypeFormURLEncoded completion:^(TSCRequestResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
        }
    }];
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
            
            self.currentUser = user;
            
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
