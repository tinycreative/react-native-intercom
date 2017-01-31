//
//  IntercomEventEmitter.h
//  RNIntercom
//
//  Created by Roger Chapman on 4/11/16.
//  Copyright © 2016 Jason Brown. All rights reserved.
//

#if __has_include(<React/RCTAssert.h>)
#import <React/RCTEventEmitter.h>
#else // back compatibility for RN version < 0.40
#import "RCTEventEmitter.h"
#endif

@interface IntercomEventEmitter : RCTEventEmitter

@end
