//
//  IntercomEventEmitter.m
//  RNIntercom
//
//  Created by Roger Chapman on 4/11/16.
//  Copyright © 2016 Jason Brown. All rights reserved.
//

#import "IntercomEventEmitter.h"
#import <Intercom/Intercom.h>

@implementation IntercomEventEmitter

RCT_EXPORT_MODULE();

- (void)handleUpdateUnreadCount:(NSNotification *)notification {
    __weak IntercomEventEmitter *weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        IntercomEventEmitter *strongSelf = weakSelf;
        NSUInteger unreadCount = [Intercom unreadConversationCount];
        NSNumber *unreadCountNumber = [NSNumber numberWithUnsignedInteger: unreadCount];
        NSDictionary *body = @{@"count": unreadCountNumber};
        [strongSelf sendEventWithName:IntercomUnreadConversationCountDidChangeNotification body:body];
    });
}

- (void)handleWindowDidHideNotification:(NSNotification *)notification {
  __weak IntercomEventEmitter *weakSelf = self;
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    IntercomEventEmitter *strongSelf = weakSelf;
    [strongSelf sendEventWithName:IntercomWindowDidHideNotification body:@"Window Was Hidden"];
  });
}

- (void)handleWindowDidShowNotification:(NSNotification *)notification {
  __weak IntercomEventEmitter *weakSelf = self;
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    IntercomEventEmitter *strongSelf = weakSelf;
    [strongSelf sendEventWithName:IntercomWindowDidShowNotification body:@"Window Was Shown"];
  });
}

- (NSDictionary<NSString *, NSString *> *)constantsToExport {
    return @{@"UNREAD_CHANGE_NOTIFICATION": IntercomUnreadConversationCountDidChangeNotification,
             @"WINDOW_DID_HIDE_NOTIFICATION": IntercomWindowDidHideNotification,
             @"WINDOW_DID_SHOW_NOTIFICATION": IntercomWindowDidShowNotification
         };
}

- (NSArray<NSString *> *)supportedEvents {
    return @[IntercomUnreadConversationCountDidChangeNotification, IntercomWindowDidHideNotification, IntercomWindowDidShowNotification];
}

-(void)startObserving {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateUnreadCount:) name:IntercomUnreadConversationCountDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWindowDidHideNotification:) name:IntercomWindowDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWindowDidShowNotification:) name:IntercomWindowDidShowNotification object:nil];
}

- (void)stopObserving {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

@end
