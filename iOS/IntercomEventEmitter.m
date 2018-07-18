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

- (NSDictionary<NSString *, NSString *> *)constantsToExport {
    return @{@"UNREAD_CHANGE_NOTIFICATION": IntercomUnreadConversationCountDidChangeNotification};
}

- (NSArray<NSString *> *)supportedEvents {
    return @[IntercomUnreadConversationCountDidChangeNotification];
}

-(void)startObserving {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateUnreadCount:) name:IntercomUnreadConversationCountDidChangeNotification object:nil];
}

- (void)stopObserving {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

@end
