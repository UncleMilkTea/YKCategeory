//
//  UIResponder+YKResponder.h
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/10.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (YKResponder)
/**
 *  重写父视图的这个方法会收到子视图传递来的数据,可以通过定义不同的key来区分子控件
 *
 *  @param notifyName key 用来区分不同的子控件事件
 *  @param userInfo       传递来的数据
 */
- (void)superViewWillRecive:(NSString *)notifyName info:(id)userInfo;

/**
 *  适用于导航控制器下的传值
 *
 *  @param notifyName key 用来区分不同的子控件事件
 *  @param userInfo       传递来的数据
 */
- (void)frontControllerWillRecive:(NSString *)notifyName info:(id)userInfo;

@end

NS_ASSUME_NONNULL_END
