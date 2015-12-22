//
//  JGSession.h
//  JustGivingKit
//
//  Created by Sam Houghton on 29/10/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TSCRequestController;
@class JGUser;

/**
 @class JGSession
 @abstract  A session is used to access endpoints and represent a user in the JustGiving API.
 */
@interface JGSession : NSObject

typedef void (^JGSessionLoginCompletion)(JGUser *user, NSError *error);
typedef void (^JGSessionAuthenticationCompletion)(NSError *error);

/**
 @abstract A request controller with a baseURL to the JustGiving API as defined in JGDefines.
 */
@property (nonatomic, strong) TSCRequestController *requestController;

/**
 @abstract Returns YES if a user is logged in.
 */
@property (nonatomic, readwrite, getter = isLoggedIn) BOOL loggedIn;

/**
 @abstract The current authenticated user
 */
@property (nonatomic, strong) JGUser *currentUser;

/**
 @abstract Returns a shared session. Use this by default.
 */
+ (JGSession *)sharedSession;

/**
 @abstract Logs a user into the JustGiving API.
 @param username The email of an existing account.
 @param password The password of an exisiting account.
 @param completion The completion block to be fired when the request is complete.
 */
- (void)loginWithEmail:(NSString *)email password:(NSString *)password completion:(JGSessionLoginCompletion)completion;

/**
@abstract Logs out the current user and removes any stored credentials from the keychain
*/
- (void)logoutCurrentUser;

- (void)requestUserAuthenticationWithCompletion:(JGSessionAuthenticationCompletion)completion;
- (void)handleAuthenticationCallbackWithUrl:(NSURL *)url;

@end
