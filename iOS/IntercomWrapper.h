//
//  IntercomWrapper.h
//  Made
//
//  Created by Asa Miller on 7/9/15.
//  Copyright (c) 2015 Asa Miller. All rights reserved.
//

#if __has_include(<React/RCTAssert.h>)
#import <React/RCTBridgeModule.h>
#import <React/RCTUtils.h>
#else // back compatibility for RN version < 0.40
#import "RCTBridgeModule.h"
#import "RCTUtils.h"
#endif


@interface IntercomWrapper : NSObject <RCTBridgeModule>
@end
