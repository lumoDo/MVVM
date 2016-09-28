//
//  NSDictionary+GetValue.m
//  HexunFund
//
//  Created by 宁采花 宁 on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+GetValue.h"


@implementation NSDictionary (GetValueAdditions)

-(BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
	return [self objectForKey:key]==[NSNull null]? defaultValue:[[self objectForKey:key]boolValue];
}

-(int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue
{
	return [self objectForKey:key]==[NSNull null]? defaultValue:[[self objectForKey:key]intValue];
}

-(time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue
{
	NSString *stringTime=[self objectForKey:key];
	if ((id)stringTime==[NSNull null]) {
		stringTime=@"";
	}
	
	struct tm created;
	if (stringTime) {
		if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL) {
			strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
		}
		return mktime(&created);
	}
	return defaultValue;
}

-(long long)getLongLongValueForKey:(NSString *)key defaultValue:(long long)defaultValue
{
	return [self objectForKey:key] == [NSNull null] ? defaultValue : [[self objectForKey:key] longLongValue];
}

-(NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
	return [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null] ? defaultValue : [self objectForKey:key];
}

-(id)heHuoRenObjectForKey:(id)key
{
    if (self == nil) {
        return @"";
    }
    if (key == nil) {
        return @"";
    }
    id object = [self objectForKey:key];
    if (object == nil) {
        return @"";
    }
    if (object == NULL) {
        return @"";
    }
    if (object == [NSNull null]) {
        return @"";
    }
    if ([object isKindOfClass:[NSNumber class]]) {
        return [object stringValue];
    }
    if ([object isKindOfClass:[NSString class]] && [object isEqualToString:@"(null)"]) {
        return @"";
    }
    return [self objectForKey:key];
}


-(BOOL)boolObjectOfData:(id)key
{
    if (self == nil) {
        return NO;
    }
    if (key == nil) {
        return NO;
    }
    id object = [self objectForKey:key];
    if (object == nil) {
        return NO;
    }
    if (object == NULL) {
        return NO;
    }
    if (object == [NSNull null]) {
        return NO;
    }
    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *arr = (NSArray *)object;
        if (arr.count == 0) {
            return NO;
        }
    }
    if ([object isKindOfClass:[NSString class]] && [object isEqualToString:@"(null)"]) {
        return NO;
    }
    if ([object isKindOfClass:[NSString class]] && [object isEqualToString:@"<null>"]) {
        return NO;
    }
    if ([object isKindOfClass:[NSString class]] && [object isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

@end
