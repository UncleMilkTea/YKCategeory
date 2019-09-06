//
//  NSDictionary+YKDictionary.h
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/6.
//  Copyright © 2019 houyukun. All rights reserved.
//  安全字典

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NSMutableDictionary * _Nonnull (^YKSafeDict) (id value, NSString *key);
@interface NSDictionary (YKDictionary)

- (NSString *)stringForKey:(id)key;
- (NSInteger)integerForKey:(id)key;
- (int)intForKey:(id)key;
- (double)doubleForKey:(id)key;
- (BOOL)booleanForKey:(id)key;
- (long)longForKey:(id)key;
- (long long)longLongForKey:(id)key;
- (NSArray *)arrayForKey:(id)key;
- (NSDictionary *)dictForKey:(id)key;
- (id)safeObjectForKey:(id)key;

@end

@interface NSMutableDictionary (YKDictionary)

@property (nonatomic, readonly) YKSafeDict setObjectForKey;

@end
NS_ASSUME_NONNULL_END
