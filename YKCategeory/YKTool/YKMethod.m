//
//  YKMethod.m
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/11.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import "YKMethod.h"

@implementation YKMethod

id YKSBViewController(NSString *sbName)
{
    return [UIStoryboard storyboardWithName:sbName bundle:nil].instantiateInitialViewController;
}

UIView * YKXibView(NSString *xibName)
{
    return [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil].firstObject;
}

void YKAfter(NSTimeInterval time, YKVoidBlock block)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

void YKAsyncThread(YKVoidBlock block)
{
    if ([NSThread currentThread].isMainThread) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
    }else{
        (!block)?:block();
    }
}

void YKMainThread(YKVoidBlock block)
{
    if ([NSThread currentThread].isMainThread) {
        (!block)?:block();
    }else{
#warning 有没有可能死锁呢 deallock. 需要好好考虑. 如果使用dispatch_async肯定不会,但dispatch_async不能等block执行完成,会继续执行block外面的代码.现在的代码执行到这里时一定在子线程
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

void YKNotifacation(id observer, id nameOrNameArray, void (^notify)(NSNotification *notify))
{
    if ([nameOrNameArray isKindOfClass:[NSArray class]]){
        for (NSString *name in nameOrNameArray) {
            [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:name object:nil] takeUntil:[observer rac_willDeallocSignal]] subscribeNext:notify];
        }
    }
    else if ([nameOrNameArray isKindOfClass:[NSString class]]){
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:nameOrNameArray object:nil] takeUntil:[observer rac_willDeallocSignal]] subscribeNext:notify];
    }
}

@end
