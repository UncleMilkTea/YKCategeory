//
//  UIResponder+YKResponder.m
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/10.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import "UIResponder+YKResponder.h"

@implementation UIResponder (YKResponder)

- (void)superViewWillRecive:(NSString *)notifyName info:(id)userInfo
{
    if (self.nextResponder) {
        [[self nextResponder] superViewWillRecive:notifyName info:userInfo];
    }
}

- (void)frontControllerWillRecive:(NSString *)notifyName info:(id)userInfo
{
    // 获取到self所属的最外层的controller
    id selfVc = self;
    
    // (正常情况下的循环不会超过三次) 所以暂时不考虑性能
    while (![self isKindOfClass:[UIViewController class]] && ![[selfVc navigationController] isKindOfClass:[UINavigationController class]]) {
        selfVc = [selfVc nextResponder];
    }
    
    // 获取所在导航控制器下的所有子控制器
    NSArray<UIViewController *> *vcs = [[selfVc navigationController] viewControllers];
    NSUInteger index = [vcs indexOfObject:selfVc];
    
    // 能够找到 并且 不是根视图
    if (index != NSNotFound && index > 0) {
        
        // 获取上一个控制器
        UIViewController *vc = [vcs objectAtIndex:index - 1];
        // 发送消息
        [vc frontControllerWillRecive:notifyName info:userInfo];
    }
}
@end
