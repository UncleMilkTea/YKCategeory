//
//  UIBarButtonItem+YKBarButtonItem.m
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/10.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import "UIBarButtonItem+YKBarButtonItem.h"

@implementation UIBarButtonItem (YKBarButtonItem)

+ (instancetype)itemWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBounds:CGRectMake(0, 0, 56, 44)];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (instancetype)itemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action {
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitleColor:titleColor?titleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    [btn setBounds:CGRectMake(0, 0, MAX(56, btn.bounds.size.width + 20), 44)];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
+ (instancetype)itemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor image:(UIImage *)image target:(id)target action:(SEL)action {
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitleColor:titleColor?titleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    [btn setBounds:CGRectMake(0, 0, MAX(56, btn.bounds.size.width + 20), 44)];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
