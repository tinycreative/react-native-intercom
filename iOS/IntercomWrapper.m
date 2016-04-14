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
    callback(@[[NSNull null], @[userId]]);
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
  [Intercom reset];
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

// Available as NativeModules.IntercomWrapper.displayMessageComposer
RCT_EXPORT_METHOD(displayMessageComposer:(RCTResponseSenderBlock)callback) {
  NSLog(@"displayMessageComposer");
  
  dispatch_async(dispatch_get_main_queue(), ^{
    [Intercom presentMessageComposer];
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

// Available as NativeModules.IntercomWrapper.setVisibility
RCT_EXPORT_METHOD(setVisibility:(NSString*)visibilityString callback:(RCTResponseSenderBlock)callback) {
  NSLog(@"setVisibility with %@", visibilityString);
  BOOL hidden = NO;
  if ([visibilityString isEqualToString:@"GONE"]) {
    hidden = YES;
  }
  [Intercom setMessagesHidden:hidden];

  callback(@[[NSNull null]]);
};

// Available as NativeModules.IntercomWrapper.setPreviewPosition
RCT_EXPORT_METHOD(setPreviewPosition:(NSString*)positionString callback:(RCTResponseSenderBlock)callback) {
  NSLog(@"setPreviewPosition with %@", positionString);

  ICMPreviewPosition previewPosition = ICMPreviewPositionBottomLeft;
  if ([positionString isEqualToString:@"BOTTOM_RIGHT"]) {
    previewPosition = ICMPreviewPositionBottomRight;
  } else if ([positionString isEqualToString:@"TOP_RIGHT"]) {
    previewPosition = ICMPreviewPositionBottomRight;
  } else if ([positionString isEqualToString:@"TOP_LEFT"]) {
    previewPosition = ICMPreviewPositionBottomLeft;
  }
  [Intercom setPreviewPosition:previewPosition];

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


@end
