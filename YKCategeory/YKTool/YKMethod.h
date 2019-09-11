//
//  YKMethod.h
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/11.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
NS_ASSUME_NONNULL_BEGIN

typedef void(^YKVoidBlock)(void);

@interface YKMethod : NSObject


/**
 快速获取sb的viewcontroller
 
 @param sbName sb'name
 @return 控制器
 */
id YKSBViewController(NSString *sbName);
/**
 开启异步线程
 
 @param block 需要执行的代码
 */
void YKAsyncThread(YKVoidBlock block);
/**
 回主线程
 
 @param block 需要执行的代码LN
 */
void YKMainThread(YKVoidBlock block);

/**
 通知中心 注意如果有self会循环引用
 <不需要移除通知 RAC willDeallocSigal自动移除>
 @param observer 监听者
 @param nameOrNameArray 通知名称或数组
 @param notify 通知对象
 */
void YKNotifacation(id observer, id nameOrNameArray, void (^notify)(NSNotification *notify));

/**
 延时block
 
 @param time 时间
 @param block 执行
 */
void YKAfter(NSTimeInterval time,YKVoidBlock block);
@end

NS_ASSUME_NONNULL_END
