//
//  IntercomUserAttributesBuilder.h
//  RNIntercom
//
//  Created by James Treanor on 09/10/2017.
//  Copyright © 2017 Jason Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ICMUserAttributes;

@interface IntercomUserAttributesBuilder : NSObject

+ (ICMUserAttributes *)userAttributesFromDictionary:(NSDictionary *)attributesDict;

@end
