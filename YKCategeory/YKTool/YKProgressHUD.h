//
//  YKProgressHUD.h
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/19.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
NS_ASSUME_NONNULL_BEGIN

@protocol YKHUDProtocol <NSObject>

- (void)showLoading;

- (void)showLoading:(NSString *)loadingInfo;

- (void)showTip:(NSString *)tip;

- (void)showSuccess:(NSString *)successInfo;

- (void)showError:(NSString *)errorInfo;

- (void)showError;

- (void)dismiss;

@end

@interface UIViewController (YKHUD) <YKHUDProtocol>
#warning (特殊警告 : 在开发中尽量不要使用UITableViewController . 因为UITableViewController的view就是tableView, 可定制化程度低. 在面对需求修改时会有无力感,还会有意想不到的bug, 建议是UIViewController + tableView,如要使用请直接MBProgressHUD的类方法直接调用不要使用分类方法 )

@end

@interface UIView (YKHUD) <YKHUDProtocol>

@property (nonatomic, assign, readonly) BOOL isLoading;

- (void)startLoading;

- (void)stopLoading;
@end

@interface MBProgressHUD (YKHUD)

+ (void)showLoading;

+ (void)showLoading:(NSString *)loadingInfo;

+ (void)showTip:(NSString *)tip;

+ (void)showSuccess:(NSString *)successInfo;

+ (void)showError:(NSString *)errorInfo;

+ (void)showError;

+ (void)dismiss;
@end
NS_ASSUME_NONNULL_END
