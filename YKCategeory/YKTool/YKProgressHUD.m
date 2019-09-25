//
//  YKProgressHUD.m
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/19.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import "YKProgressHUD.h"
#import <objc/runtime.h>
#import <Masonry.h>
#define YKWindow [UIApplication sharedApplication].windows.firstObject
#define YKDelay 1.5

@interface YKProgressHUD : MBProgressHUD
@end

@implementation YKProgressHUD

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        self.offset = CGPointMake(0, -100);
        self.label.font = [UIFont systemFontOfSize:14];
        self.label.numberOfLines = 0;
        self.minSize = CGSizeMake(130, 50);
    }
    return self;
}
@end


@implementation UIViewController (YKHUD)

- (void)showLoading
{
    if ([self isKindOfClass:[UITableViewController class]]) {
        [MBProgressHUD showLoading:@"加载中"];
    }else{
        [self.view showLoading:@"加载中"];
    }
}

- (void)showLoading:(NSString *)loadingInfo
{
    if ([self isKindOfClass:[UITableViewController class]]) {
        [MBProgressHUD showLoading:loadingInfo];
    }else{
        [self.view showLoading:loadingInfo];
    }
}

- (void)showTip:(NSString *)tip
{
    if ([self isKindOfClass:[UITableViewController class]]) {
        [MBProgressHUD showTip:tip];
    }else{
        [self.view showTip:tip];
    }
}


- (void)showSuccess:(NSString *)successInfo
{
    if ([self isKindOfClass:[UITableViewController class]]) {
        [MBProgressHUD showSuccess:successInfo];
    }else{
        [self.view showSuccess:successInfo];
    }
}

- (void)showError
{
    if ([self isKindOfClass:[UITableViewController class]]) {
        [MBProgressHUD showError];
    }else{
        [self.view showError];
    }
}

- (void)showError:(NSString *)errorInfo
{
    if ([self isKindOfClass:[UITableViewController class]]) {
        [MBProgressHUD showError:errorInfo];
    }else{
        [self.view showError:errorInfo];
    }
}

- (void)dismiss
{
    if ([self isKindOfClass:[UITableViewController class]]) {
        [MBProgressHUD dismiss];
    }else{
        [self.view dismiss];
    }
}
@end

@implementation UIView (YKHUD)

- (void)showLoading
{
    [self showLoading:@"加载中"];
}

- (void)showLoading:(NSString *)loadingInfo
{
    [self dismiss];
    YKProgressHUD *hud = [YKProgressHUD showHUDAddedTo:self animated:YES];
    hud.label.text = loadingInfo.length?loadingInfo:@"加载中";
}

- (void)showTip:(NSString *)tip
{
    [self dismiss];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    hud.offset = CGPointMake(0, -80);
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.label.numberOfLines = 0;
    hud.minSize = CGSizeMake(130, 44);
    hud.mode = MBProgressHUDModeText;
    hud.label.text = tip.length?tip:@"系统异常";
    [hud hideAnimated:YES afterDelay:YKDelay];
}

- (void)showSuccess:(NSString *)successInfo
{
    [self dismiss];
    YKProgressHUD *hud = [YKProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [UIImage imageNamed:@"Checkmark"];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.label.text = successInfo.length?successInfo:@"成功";
    [hud hideAnimated:YES afterDelay:YKDelay];
}

- (void)showError
{
    [self showError:@""];
}

- (void)showError:(NSString *)errorInfo
{
    [self showTip:errorInfo.length?errorInfo:@"网络加载失败"];
}

- (void)dismiss
{
    [YKProgressHUD hideHUDForView:self animated:YES];
}

- (void)startLoading
{
    [self addSubview:self.loadingV];
    [self.loadingV mas_makeConstraints:^(MASConstraintMaker *make) {
           make.width.height.equalTo(self);
           make.center.equalTo(self);
    }];
    [(UIActivityIndicatorView *)[self.loadingV viewWithTag:10] startAnimating];
}
- (void)stopLoading
{
    [self.loadingV removeFromSuperview];
    
    [(UIActivityIndicatorView *)[self.loadingV viewWithTag:10] stopAnimating];
}

- (UIView *)loadingV
{
    UIView *loadingV = objc_getAssociatedObject(self, _cmd);
    if (loadingV == nil) {
        loadingV = [UIView new];
        loadingV.backgroundColor = [UIColor clearColor];
        UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        act.tag = 10;
        act.translatesAutoresizingMaskIntoConstraints = NO;
        [loadingV addSubview:act];
        [act mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.center.equalTo(loadingV);
        }];
        objc_setAssociatedObject(self, _cmd, loadingV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return loadingV;
}

- (BOOL)isLoading
{
    UIView *loadingV = objc_getAssociatedObject(self, @selector(loadingV));
    return loadingV?(loadingV.superview?YES:NO):NO;
}
@end

@implementation MBProgressHUD (YKHUD)

+ (void)showLoading
{
    [YKWindow showLoading:@"加载中"];
}

+ (void)showLoading:(NSString *)loadingInfo
{
    [YKWindow showLoading:loadingInfo];
}

+ (void)showTip:(NSString *)tip
{
    [YKWindow showTip:tip];
}
+ (void)showSuccess:(NSString *)successInfo
{
    [YKWindow showSuccess:successInfo];
}

+ (void)showError
{
    [YKWindow showError];
}

+ (void)showError:(NSString *)errorInfo
{
    [YKWindow showError:errorInfo];
}

+ (void)dismiss
{
    [YKWindow dismiss];
}
@end
