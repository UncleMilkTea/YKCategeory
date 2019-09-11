//
//  UIViewController+YKViewController.m
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/10.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import "UIViewController+YKViewController.h"

@implementation UIViewController (YKViewController)



- (void)setTitle:(NSString *)title{
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor=[UIColor blackColor];
    label.text = title;
    [label sizeToFit];
    self.navigationItem.titleView = label;
}

@end
