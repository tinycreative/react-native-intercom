//
//  IntercomUserAttributesBuilder.m
//  RNIntercom
//
//  Created by James Treanor on 09/10/2017.
//  Copyright © 2017 Jason Brown. All rights reserved.
//

#import "IntercomUserAttributesBuilder.h"
#import <Intercom/Intercom.h>

@implementation IntercomUserAttributesBuilder

+ (ICMUserAttributes *)userAttributesFromDictionary:(NSDictionary *)attributesDict {
    ICMUserAttributes *attributes = [ICMUserAttributes new];
    if ([self stringValueForKey:@"email" inDictionary:attributesDict]) {
        attributes.email = [self stringValueForKey:@"email" inDictionary:attributesDict];
    }
    if ([self stringValueForKey:@"user_id" inDictionary:attributesDict]) {
        attributes.userId = [self stringValueForKey:@"user_id" inDictionary:attributesDict];
    }
    if ([self stringValueForKey:@"name" inDictionary:attributesDict]) {
        attributes.name = [self stringValueForKey:@"name" inDictionary:attributesDict];
    }
    if ([self stringValueForKey:@"phone" inDictionary:attributesDict]) {
        attributes.phone = [self stringValueForKey:@"phone" inDictionary:attributesDict];
    }
    if ([self stringValueForKey:@"language_override" inDictionary:attributesDict]) {
        attributes.languageOverride = [self stringValueForKey:@"language_override" inDictionary:attributesDict];
    }
    if ([self dateValueForKey:@"signed_up_at" inDictionary:attributesDict]) {
        attributes.signedUpAt = [self dateValueForKey:@"signed_up_at" inDictionary:attributesDict];
    }
    if ([self stringValueForKey:@"unsubscribed_from_emails" inDictionary:attributesDict]) {
        attributes.unsubscribedFromEmails = [[attributesDict objectForKey:@"unsubscribed_from_emails"] boolValue];
    }
    if (attributesDict[@"custom_attributes"]) {
        attributes.customAttributes = attributesDict[@"custom_attributes"];
    }
    if (attributesDict[@"companies"]) {
        NSMutableArray<ICMCompany *> *companies = [NSMutableArray new];
        for (NSDictionary *companyDict in attributesDict[@"companies"]) {
            [companies addObject:[self companyForDictionary:companyDict]];
        }
        attributes.companies = companies;
    }
    return attributes;
}

+ (ICMCompany *)companyForDictionary:(NSDictionary *)attributesDict {
    ICMCompany *company = [ICMCompany new];
    if ([self stringValueForKey:@"company_id" inDictionary:attributesDict]) {
        company.companyId = [self stringValueForKey:@"company_id" inDictionary:attributesDict];
    }
    if ([self stringValueForKey:@"name" inDictionary:attributesDict]) {
        company.name = [self stringValueForKey:@"name" inDictionary:attributesDict];
    }
    if ([self dateValueForKey:@"created_at" inDictionary:attributesDict]) {
        company.createdAt = [self dateValueForKey:@"created_at" inDictionary:attributesDict];
    }
    if ([self numberValueForKey:@"monthly_spend" inDictionary:attributesDict]) {
        company.monthlySpend = [self numberValueForKey:@"monthly_spend" inDictionary:attributesDict];
    }
    if ([self stringValueForKey:@"plan" inDictionary:attributesDict]) {
        company.plan = [self stringValueForKey:@"plan" inDictionary:attributesDict];
    }
    if (attributesDict[@"custom_attributes"]) {
        company.customAttributes = attributesDict[@"custom_attributes"];
    }
    return company;
}

+ (NSString *)stringValueForKey:(NSString *)key inDictionary:(NSDictionary *)dictionary {
    NSString *value = dictionary[key];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@", value];
    }
    if ([value isKindOfClass:[NSNull class]]) {
        return [ICMUserAttributes nullStringAttribute];
    }
    return nil;
}

+ (NSNumber *)numberValueForKey:(NSString *)key inDictionary:(NSDictionary *)dictionary {
    NSNumber *value = dictionary[key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    }
    if ([value isKindOfClass:[NSNull class]]) {
        return [ICMUserAttributes nullNumberAttribute];
    }
    return nil;
}

+ (NSDate *)dateValueForKey:(NSString *)key inDictionary:(NSDictionary *)dictionary {
    NSNumber *value = dictionary[key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
    }
    if ([value isKindOfClass:[NSNull class]]) {
        return [ICMUserAttributes nullDateAttribute];
    }
    return nil;
}

@end
