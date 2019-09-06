//
//  NSArray+YKArray.h
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/6.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSMutableArray * _Nullable (^YKSafeArray)(id obj);

@interface NSArray (YKArray)

@end

@interface NSMutableArray (YKArray)

@property (nonatomic, readonly) YKSafeArray addObject;

@end

@interface NSPointerArray (YKArray)

/**
 是否包含某个指针
 
 @param pointer 指针
 @return 是否包含
 */
- (BOOL)containsPointer:(void *)pointer;

/**
 删除指针
 
 @param pointer 指针
 */
- (void)removePointer:(void *)pointer;

@end
NS_ASSUME_NONNULL_END
