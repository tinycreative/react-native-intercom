//
//  IntercomWrapper.m
//  Made
//
//  Created by Asa Miller on 7/9/15.
//  Copyright (c) 2015 Asa Miller. All rights reserved.
//

#import "IntercomWrapper.h"
#import "IntercomUserAttributesBuilder.h"
#import <Intercom/Intercom.h>

@implementation IntercomWrapper

RCT_EXPORT_MODULE();

// Available as NativeModules.IntercomWrapper.registerIdentifiedUser
RCT_EXPORT_METHOD(registerIdentifiedUser:(NSDictionary*)options resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    NSLog(@"registerIdentifiedUser with %@", options);

    NSString* userId      = options[@"userId"];
    NSString* userEmail   = options[@"email"];

    if ([userId isKindOfClass:[NSNumber class]]) {
        userId = [(NSNumber *)userId stringValue];
    }

    if (userId.length > 0 && userEmail.length > 0) {
        [Intercom registerUserWithUserId:userId email:userEmail];
        resolve(userId);
    } else if (userId.length > 0) {
        [Intercom registerUserWithUserId:userId];
        resolve(userId);
    } else if (userEmail.length > 0) {
        [Intercom registerUserWithEmail:userEmail];
        resolve(userEmail);
    } else {
        NSLog(@"[Intercom] ERROR - No user registered. You must supply an email, a userId or both");
        reject(@"", @"No user registered. You must supply an email, a userId or both", nil);
    }
};

// Available as NativeModules.IntercomWrapper.sendTokenToIntercom
RCT_EXPORT_METHOD(sendTokenToIntercom:(NSString*)token resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    NSLog(@"sendTokenToIntercom");

    // This is a stub. The iOS Intercom client sends the deviceToken instead of FCM token in:
    // - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //    [Intercom setDeviceToken:deviceToken];
    // }

    resolve([NSNull null]);
}

// Available as NativeModules.IntercomWrapper.registerUnidentifiedUser
RCT_EXPORT_METHOD(registerUnidentifiedUser :(RCTPromiseResolveBlock)resolve :(RCTPromiseRejectBlock)reject) {
    NSLog(@"registerUnidentifiedUser");
    [Intercom registerUnidentifiedUser];
    resolve([NSNull null]);
};

// Available as NativeModules.IntercomWrapper.logout
RCT_EXPORT_METHOD(logout :(RCTPromiseResolveBlock)resolve :(RCTPromiseRejectBlock)reject) {
    NSLog(@"logout");

    dispatch_async(dispatch_get_main_queue(), ^{
        [Intercom logout];
    });

    resolve([NSNull null]);
};

// Available as NativeModules.IntercomWrapper.updateUser
RCT_EXPORT_METHOD(updateUser:(NSDictionary*)options resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    NSLog(@"updateUser with %@", options);
    NSDictionary* attributes = options;
    [Intercom updateUser:[IntercomUserAttributesBuilder userAttributesFromDictionary:attributes]];
    resolve([NSNull null]);
};

// Available as NativeModules.IntercomWrapper.logEvent
RCT_EXPORT_METHOD(logEvent:(NSString*)eventName metaData:(NSDictionary*)metaData resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    NSLog(@"logEvent with %@", eventName);

    if (metaData.count > 0) {
        [Intercom logEventWithName:eventName metaData:metaData];
    } else {
        [Intercom logEventWithName:eventName];
    }

    resolve([NSNull null]);
};

// Available as NativeModules.IntercomWrapper.handlePushMessage
RCT_EXPORT_METHOD(handlePushMessage :(RCTPromiseResolveBlock)resolve :(RCTPromiseRejectBlock)reject) {
    NSLog(@"handlePushMessage");

    // This is a stub. The iOS Intercom client automatically handles push notifications

    resolve([NSNull null]);
}

// Available as NativeModules.IntercomWrapper.displayMessenger
RCT_EXPORT_METHOD(displayMessenger :(RCTPromiseResolveBlock)resolve :(RCTPromiseRejectBlock)reject) {
    NSLog(@"displayMessenger");

    dispatch_async(dispatch_get_main_queue(), ^{
        [Intercom presentMessenger];
    });

    resolve([NSNull null]);
}

// Available as NativeModules.IntercomWrapper.hideMessenger
RCT_EXPORT_METHOD(hideMessenger :(RCTPromiseResolveBlock)resolve :(RCTPromiseRejectBlock)reject) {
    NSLog(@"hideMessenger");

    dispatch_async(dispatch_get_main_queue(), ^{
        [Intercom hideMessenger];
    });

    resolve([NSNull null]);
}

// Available as NativeModules.IntercomWrapper.displayMessageComposer
RCT_EXPORT_METHOD(displayMessageComposer :(RCTPromiseResolveBlock)resolve :(RCTPromiseRejectBlock)reject) {
    NSLog(@"displayMessageComposer");

    dispatch_async(dispatch_get_main_queue(), ^{
        [Intercom presentMessageComposer];
    });

    resolve([NSNull null]);
};

RCT_EXPORT_METHOD(displayMessageComposerWithInitialMessage:(NSString*)message resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    NSLog(@"displayMessageComposerWithInitialMessage");

    dispatch_async(dispatch_get_main_queue(), ^{
        [Intercom presentMessageComposerWithInitialMessage:message];
    });

    resolve([NSNull null]);
};

// Available as NativeModules.IntercomWrapper.displayConversationsList
RCT_EXPORT_METHOD(displayConversationsList :(RCTPromiseResolveBlock)resolve :(RCTPromiseRejectBlock)reject) {
    NSLog(@"displayConversationsList");

    dispatch_async(dispatch_get_main_queue(), ^{
        [Intercom presentConversationList];
    });

    resolve([NSNull null]);
};

// Available as NativeModules.IntercomWrapper.getUnreadConversationCount
RCT_EXPORT_METHOD(getUnreadConversationCount :(RCTPromiseResolveBlock)resolve :(RCTPromiseRejectBlock)reject) {
    NSLog(@"getUnreadConversationCount");

    NSNumber *unread_conversations = [NSNumber numberWithUnsignedInteger:[Intercom unreadConversationCount]];

    resolve(unread_conversations);
}

// Available as NativeModules.IntercomWrapper.displayHelpCenter
RCT_EXPORT_METHOD(displayHelpCenter :(RCTPromiseResolveBlock)resolve :(RCTPromiseRejectBlock)reject) {
    NSLog(@"displayHelpCenter");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [Intercom presentHelpCenter];
    });
    
    resolve([NSNull null]);
};

// Available as NativeModules.IntercomWrapper.setLauncherVisibility
RCT_EXPORT_METHOD(setLauncherVisibility:(NSString*)visibilityString resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    NSLog(@"setVisibility with %@", visibilityString);
    BOOL visible = NO;
    if ([visibilityString isEqualToString:@"VISIBLE"]) {
        visible = YES;
    }
    [Intercom setLauncherVisible:visible];

    resolve([NSNull null]);
};

// Available as NativeModules.IntercomWrapper.setInAppMessageVisibility
RCT_EXPORT_METHOD(setInAppMessageVisibility:(NSString*)visibilityString resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    NSLog(@"setVisibility with %@", visibilityString);
    BOOL visible = YES;
    if ([visibilityString isEqualToString:@"GONE"]) {
        visible = NO;
    }
    [Intercom setInAppMessagesVisible:visible];

    resolve([NSNull null]);
};

// Available as NativeModules.IntercomWrapper.setupAPN
RCT_EXPORT_METHOD(setupAPN:(NSString*)deviceToken resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    NSLog(@"setupAPN with %@", deviceToken);
    [Intercom setDeviceToken:[deviceToken dataUsingEncoding:NSUTF8StringEncoding]];
    resolve([NSNull null]);
};

// Available as NativeModules.IntercomWrapper.registerForPush
RCT_EXPORT_METHOD(registerForPush :(RCTPromiseResolveBlock)resolve :(RCTPromiseRejectBlock)reject) {
    NSLog(@"registerForPush");

    dispatch_async(dispatch_get_main_queue(), ^{
        UIApplication *application = [UIApplication sharedApplication];
        [application registerUserNotificationSettings:
        [UIUserNotificationSettings settingsForTypes:
        (UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert)
                                        categories:nil]];
        [application registerForRemoteNotifications];
    });

    resolve([NSNull null]);
};

// Available as NativeModules.IntercomWrapper.setUserHash
RCT_EXPORT_METHOD(setUserHash:(NSString*)userHash resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [Intercom setUserHash:userHash];
    resolve([NSNull null]);
};

// Available as NativeModules.IntercomWrapper.setBottomPadding
RCT_EXPORT_METHOD(setBottomPadding:(CGFloat)padding resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [Intercom setBottomPadding:padding];
    resolve([NSNull null]);
};

@end
