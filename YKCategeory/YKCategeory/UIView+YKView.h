//
//  UIView+YKView.h
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/5.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YKView)
// 用来快速访问和设置View的常用属性
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGSize  size;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;
@property (nonatomic, readonly) CGPoint centerInSelf;
@property (nonatomic, readonly) CGFloat bottom;
@property (nonatomic, readonly) CGFloat left;
@property (nonatomic, readonly) CGFloat right;
@property (nonatomic, readonly) CGFloat top;
@property (nonatomic, readonly) NSString *frameString;
//! 扩展传值
@property (nonatomic, strong) NSDictionary *extra;
/**
 截取当前的view为图片
 @return 图片
 */
- (UIImage *)yk_captureImage;

/*  allow this name to get xib(UINib) instance  获取同名的xibview
*
*  @return view
*/
+ (__kindof UIView *)yk_xibView;
/**
 *  get this view's viewController (获取当前view所在的控制器)
 *
 *  @return UIViewController
 */
- (__kindof  UIViewController *)yk_viewController;
/**
 *  get this view's navigationController (获取当前view所在的导航控制器)
 *
 *  @return UINavigationController
 */
- (__kindof  UINavigationController *)yk_navigationController;
//! 设置渐变色
- (void)setGradualChangeColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end

@interface UIView (RoundingCorners)
/**
 边框颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

/**
 边框宽度
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/**
 圆角
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 单个圆角设置
 */
@property (nonatomic, assign) UIRectCorner roundCorners;
/**
 指定圆角 + 尺寸
 
 @param roundCorners 圆角 多个用 |
 @param size 圆角尺寸
 */
- (void)setRoundCorners:(UIRectCorner)roundCorners cornerRadii:(CGSize)size;
/**
 添加阴影
 */
- (void)createShadow;

- (void)setCircleWithRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor;

//! 设置圆角图片
- (void)cornerRadiusWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;
@end

NS_ASSUME_NONNULL_END
