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
    
    [self sendEventWithName:IntercomUnreadConversationCountDidChangeNotification body:@{@"count": [NSNumber numberWithUnsignedInteger: [Intercom unreadConversationCount]]}];
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

@end
