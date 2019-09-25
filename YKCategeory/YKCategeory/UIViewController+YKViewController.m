//
//  UIViewController+YKViewController.m
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/10.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import "UIViewController+YKViewController.h"



@implementation YKAlterConfig

@end


@implementation UIViewController (YKViewController)

- (void)yk_presentAltertConfigure:(void (^)(YKAlterConfig *config))configure sure:(void (^)(NSString *text))sure cancle:(void (^)(void))cancle
{
    YKAlterConfig *config = [[YKAlterConfig alloc]init];
    configure?configure(config):nil;
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:config.title message:config.message preferredStyle:config.style == 0?UIAlertControllerStyleAlert:UIAlertControllerStyleActionSheet];
    
    if (config.addInput) {
        [vc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            config.textFieldBlock?config.textFieldBlock(textField):nil;
        }];
    }
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sure?sure(vc.textFields.firstObject.text):nil;
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancle?cancle():nil;
    }];
    if (config.single == NO) {
        [vc addAction:cancleAction];
    }
    [vc addAction:sureAction];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)setTitle:(NSString *)title{
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor=[UIColor blackColor];
    label.text = title;
    [label sizeToFit];
    self.navigationItem.titleView = label;
}

@end
