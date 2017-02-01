//
//  IntercomWrapper.m
//  Made
//
//  Created by Asa Miller on 7/9/15.
//  Copyright (c) 2015 Asa Miller. All rights reserved.
//

#import "IntercomWrapper.h"
#import <Intercom/Intercom.h>

@implementation IntercomWrapper

RCT_EXPORT_MODULE();

// Available as NativeModules.IntercomWrapper.registerIdentifiedUser
RCT_EXPORT_METHOD(registerIdentifiedUser:(NSDictionary*)options callback:(RCTResponseSenderBlock)callback) {
    NSLog(@"registerIdentifiedUser with %@", options);

    NSString* userId      = options[@"userId"];
    NSString* userEmail   = options[@"email"];

    if ([userId isKindOfClass:[NSNumber class]]) {
        userId = [(NSNumber *)userId stringValue];
    }

    if (userId.length > 0 && userEmail.length > 0) {
        [Intercom registerUserWithUserId:userId email:userEmail];
        callback(@[[NSNull null], @[userId]]);
    } else if (userId.length > 0) {
        [Intercom registerUserWithUserId:userId];
        callback(@[[NSNull null], @[userId]]);
    } else if (userEmail.length > 0) {
        [Intercom registerUserWithEmail:userEmail];
        callback(@[[NSNull null], @[userEmail]]);
    } else {
        NSLog(@"[Intercom] ERROR - No user registered. You must supply an email, a userId or both");
        callback(@[RCTMakeError(@"Error", nil, nil)]);
    }
};

// Available as NativeModules.IntercomWrapper.registerUnidentifiedUser
RCT_EXPORT_METHOD(registerUnidentifiedUser:(RCTResponseSenderBlock)callback) {
    NSLog(@"registerUnidentifiedUser");
    [Intercom registerUnidentifiedUser];
    callback(@[[NSNull null]]);
};

// Available as NativeModules.IntercomWrapper.reset
RCT_EXPORT_METHOD(reset:(RCTResponseSenderBlock)callback) {
    NSLog(@"reset");

    dispatch_async(dispatch_get_main_queue(), ^{
        [Intercom reset];
    });

    callback(@[[NSNull null]]);
};

// Available as NativeModules.IntercomWrapper.updateUser
RCT_EXPORT_METHOD(updateUser:(NSDictionary*)options callback:(RCTResponseSenderBlock)callback) {
    NSLog(@"updateUser with %@", options);
    NSDictionary* attributes = options;
    [Intercom updateUserWithAttributes:attributes];
    callback(@[[NSNull null]]);
};

// Available as NativeModules.IntercomWrapper.logEvent
RCT_EXPORT_METHOD(logEvent:(NSString*)eventName metaData:(NSDictionary*)metaData callback:(RCTResponseSenderBlock)callback) {
    NSLog(@"logEvent with %@", eventName);

    if (metaData.count > 0) {
        [Intercom logEventWithName:eventName metaData:metaData];
    } else {
        [Intercom logEventWithName:eventName];
    }

    callback(@[[NSNull null]]);
};

// Available as NativeModules.IntercomWrapper.handlePushMessage
RCT_EXPORT_METHOD(handlePushMessage:(RCTResponseSenderBlock)callback) {
    NSLog(@"handlePushMessage");

    // This is a stub. The iOS Intercom client automatically handles push notifications

    callback(@[[NSNull null]]);
}

// Available as NativeModules.IntercomWrapper.displayMessenger
RCT_EXPORT_METHOD(displayMessenger:(RCTResponseSenderBlock)callback) {
    NSLog(@"displayMessenger");

    dispatch_async(dispatch_get_main_queue(), ^{
        [Intercom presentMessenger];
    });

    callback(@[[NSNull null]]);
}

// Available as NativeModules.IntercomWrapper.hideMessenger
RCT_EXPORT_METHOD(hideMessenger:(RCTResponseSenderBlock)callback) {
    NSLog(@"hideMessenger");

    dispatch_async(dispatch_get_main_queue(), ^{
        [Intercom hideMessenger];
    });

    callback(@[[NSNull null]]);
}

// Available as NativeModules.IntercomWrapper.displayMessageComposer
RCT_EXPORT_METHOD(displayMessageComposer:(RCTResponseSenderBlock)callback) {
    NSLog(@"displayMessageComposer");

    dispatch_async(dispatch_get_main_queue(), ^{
        [Intercom presentMessageComposer];
    });

    callback(@[[NSNull null]]);
};

RCT_EXPORT_METHOD(displayMessageComposerWithInitialMessage:(NSString*)message callback:(RCTResponseSenderBlock)callback) {
    NSLog(@"displayMessageComposerWithInitialMessage");

    dispatch_async(dispatch_get_main_queue(), ^{
        [Intercom presentMessageComposerWithInitialMessage:message];
    });

    callback(@[[NSNull null]]);
};

// Available as NativeModules.IntercomWrapper.displayConversationsList
RCT_EXPORT_METHOD(displayConversationsList:(RCTResponseSenderBlock)callback) {
    NSLog(@"displayConversationsList");

    dispatch_async(dispatch_get_main_queue(), ^{
        [Intercom presentConversationList];
    });

    callback(@[[NSNull null]]);
};

// Available as NativeModules.IntercomWrapper.getUnreadConversationCount
RCT_EXPORT_METHOD(getUnreadConversationCount:(RCTResponseSenderBlock)callback) {
    NSLog(@"getUnreadConversationCount");

    NSNumber *unread_conversations = [NSNumber numberWithUnsignedInteger:[Intercom unreadConversationCount]];

    callback(@[[NSNull null], unread_conversations]);
}

// Available as NativeModules.IntercomWrapper.setLauncherVisibility
RCT_EXPORT_METHOD(setLauncherVisibility:(NSString*)visibilityString callback:(RCTResponseSenderBlock)callback) {
    NSLog(@"setVisibility with %@", visibilityString);
    BOOL visible = NO;
    if ([visibilityString isEqualToString:@"VISIBLE"]) {
        visible = YES;
    }
    [Intercom setLauncherVisible:visible];

    callback(@[[NSNull null]]);
};

// Available as NativeModules.IntercomWrapper.setInAppMessageVisibility
RCT_EXPORT_METHOD(setInAppMessageVisibility:(NSString*)visibilityString callback:(RCTResponseSenderBlock)callback) {
    NSLog(@"setVisibility with %@", visibilityString);
    BOOL visible = YES;
    if ([visibilityString isEqualToString:@"GONE"]) {
        visible = NO;
    }
    [Intercom setInAppMessagesVisible:visible];

    callback(@[[NSNull null]]);
};

// Available as NativeModules.IntercomWrapper.setupAPN
RCT_EXPORT_METHOD(setupAPN:(NSString*)deviceToken callback:(RCTResponseSenderBlock)callback) {
    NSLog(@"setupAPN with %@", deviceToken);
    [Intercom setDeviceToken:[deviceToken dataUsingEncoding:NSUTF8StringEncoding]];
    callback(@[[NSNull null]]);
};

// Available as NativeModules.IntercomWrapper.registerForPush
RCT_EXPORT_METHOD(registerForPush:(RCTResponseSenderBlock)callback) {
    NSLog(@"registerForPush");

    UIApplication *application = [UIApplication sharedApplication];
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]){ // iOS 8 (User notifications)
        [application registerUserNotificationSettings:
         [UIUserNotificationSettings settingsForTypes:
          (UIUserNotificationTypeBadge |
           UIUserNotificationTypeSound |
           UIUserNotificationTypeAlert)
                                           categories:nil]];
        [application registerForRemoteNotifications];
    } else { // iOS 7 (Remote notifications)
        [application registerForRemoteNotificationTypes:
         (UIRemoteNotificationType)
         (UIRemoteNotificationTypeBadge |
          UIRemoteNotificationTypeSound |
          UIRemoteNotificationTypeAlert)];
    }

    callback(@[[NSNull null]]);
};

// Available as NativeModules.IntercomWrapper.setHMAC
RCT_EXPORT_METHOD(setHMAC:(NSString*)hmac data:(NSString*)data callback:(RCTResponseSenderBlock)callback) {
    [Intercom setHMAC:hmac data:data];
    callback(@[[NSNull null]]);
};

// Available as NativeModules.IntercomWrapper.setBottomPadding
RCT_EXPORT_METHOD(setBottomPadding:(CGFloat)padding callback:(RCTResponseSenderBlock)callback) {
    [Intercom setBottomPadding:padding];
    callback(@[[NSNull null]]);
};

@end
