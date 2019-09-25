//
//  UIViewController+YKViewController.h
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/10.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//Altert配置
@interface YKAlterConfig : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) UIAlertControllerStyle style;
@property (nonatomic, assign) UIAlertViewStyle v_style;
//! 单按钮
@property (nonatomic, assign) BOOL single;
//! 输入框
@property (nonatomic, assign) BOOL addInput;
//! 控件回调处理
@property (nonatomic, copy) void(^textFieldBlock)(UITextField *textField);
@end

@interface UIViewController (YKViewController)
/**
 Altert
 @param configure 配置
  @param sure 确定
  @param cancle 取消
 */
- (void)yk_presentAltertConfigure:(void (^)(YKAlterConfig *config))configure sure:(void (^)(NSString *text))sure cancle:(void (^)(void))cancle;

@end

NS_ASSUME_NONNULL_END
