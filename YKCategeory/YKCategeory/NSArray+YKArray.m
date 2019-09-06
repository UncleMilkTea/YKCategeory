//
//  NSArray+YKArray.m
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/6.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import "NSArray+YKArray.h"

@implementation NSArray (YKArray)

@end

@implementation NSMutableArray (YKArray)


- (YKSafeArray)addObject
{
    return ^(id obj){
        if (obj) {
            [self addObject:obj];
        }else{
            NSLog(@"%@数组中插入了空数据", self);
        }
        return self;
    };
}

@end

@implementation NSPointerArray (YKArray)

- (BOOL)containsPointer:(void *)pointer
{
    BOOL contains = NO;
    
    for (NSUInteger i = 0; i < self.count; i++) {
        void * p = [self pointerAtIndex:i];
        if (p == pointer) {
            contains = YES;
            break;
        }
    }
    
    return contains;
}

- (void)removePointer:(void *)pointer
{
    if (pointer == NULL || pointer == nil) {
        return;
    }
    NSInteger index = NSNotFound;
    
    for (NSUInteger i = 0; i < self.count; i++) {
        void * p = [self pointerAtIndex:i];
        if (p == pointer) {
            index = i;
            break;
        }
    }
    
    if (index != NSNotFound) {
        [self removePointerAtIndex:index];
    }
}

@end
