//
//  NSDictionary+YKDictionary.m
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/6.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import "NSDictionary+YKDictionary.h"

@implementation NSDictionary (YKDictionary)

- (NSString *)stringForKey:(id)key
{
    id value = [self safeObjectForKey:key];
    if ([value isKindOfClass:[NSString class]]){
        return value;
    }else if ([value respondsToSelector:@selector(stringValue)]) {
        return [value stringValue];
    }else{
        return nil;
    }
}
- (int)intForKey:(id)key
{
    id value = [self safeObjectForKey:key];
    if (value && [value respondsToSelector:@selector(intValue)]) {
        return [value intValue];
    }
    return 0;
}
- (NSInteger)integerForKey:(id)key
{
    id value = [self safeObjectForKey:key];
    if (value && [value respondsToSelector:@selector(integerValue)]) {
        return [value integerValue];
    }
    return 0;
}

- (double)doubleForKey:(id)key
{
    id value = [self safeObjectForKey:key];
    if (value && [value respondsToSelector:@selector(doubleValue)]) {
        return [value doubleValue];
    }
    return 0.0;
}

- (BOOL)booleanForKey:(id)key
{
    id value = [self safeObjectForKey:key];
    if (value && [value respondsToSelector:@selector(boolValue)]) {
        return [value boolValue];
    }
    return NO;
}

- (long)longForKey:(id)key
{
    id value = [self safeObjectForKey:key];
    if (value && [value respondsToSelector:@selector(longValue)]) {
        return [value longValue];
    }
    return 0;
}

- (long long)longLongForKey:(id)key
{
    id value = [self safeObjectForKey:key];
    if (value && [value respondsToSelector:@selector(longLongValue)]) {
        return [value longLongValue];
    }
    return 0;
}

- (NSArray *)arrayForKey:(id)key
{
    id value = [self safeObjectForKey:key];
    if (value && [value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}
- (NSDictionary *)dictForKey:(id)key
{
    id value = [self safeObjectForKey:key];
    if (value && [value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (id)safeObjectForKey:(id)key
{
    id value = [self objectForKey:key];
    if (!value || [value isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return value;
}
@end

@implementation NSMutableDictionary (YKDictionary)

- (YKSafeDict)setObjectForKey
{
    return ^(id value, NSString *key){
        if (key.length && value) {
            [self setObject:value forKey:key];
        }else{
            NSLog(@"插入了空数据<key=%@,value=%@>.... 没崩溃", key, value);
        }
        return self;
    };
}

@end
