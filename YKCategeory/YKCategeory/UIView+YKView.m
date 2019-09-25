//
//  UIView+YKView.m
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/5.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import "UIView+YKView.h"
#import <objc/runtime.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation UIView (YKView)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width
{
    return self.bounds.size.width;
}

- (CGFloat)height
{
    return self.bounds.size.height;
}

- (CGSize)size
{
    return self.bounds.size;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)middleX
{
    return self.bounds.size.width * 0.5;
}

- (CGFloat)middleY
{
    return self.bounds.size.height * 0.5;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.bounds.size.height;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.bounds.size.width;
}

- (CGPoint)centerInSelf
{
    return CGPointMake(self.middleX, self.middleY);
}

- (NSString *)frameString
{
    return NSStringFromCGRect(self.frame);
}
- (void)setExtra:(NSDictionary *)extra
{
    objc_setAssociatedObject(self, @selector(extra), extra, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)extra
{
    return objc_getAssociatedObject(self, _cmd);
}

- (UIImage *)yk_captureImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    [[UIColor whiteColor] setFill];
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
+ (UIView *)yk_xibView
{
    NSString *className = NSStringFromClass([self class]);
    if (className) {
        return [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil].firstObject;
    }
    return nil;
}
- (UIViewController *)yk_viewController
{
    id vc = self;
    while (vc && [vc isKindOfClass:[UIViewController class]] == NO) {
        vc = [vc nextResponder];
    }
    return vc;
}
- (UINavigationController *)yk_navigationController{
    UIViewController *viewController = [self yk_viewController];
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)viewController;
    }
    return viewController?viewController.navigationController:nil;
}
- (void)setGradualChangeColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)(startColor.CGColor), (__bridge id)(endColor.CGColor)];
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = CGRectMake(0, 0, self.width, self.height);
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)yk_showAltertConfigure:(void (^)(YKAlterConfig * _Nonnull))configure sure:(void (^)(NSString *text))sure cancle:(void (^)(void))cancle
{
    YKAlterConfig *config = [[YKAlterConfig alloc]init];
    configure?configure(config):nil;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:config.title message:config.message delegate:self cancelButtonTitle:config.single == NO?@"取消":nil otherButtonTitles:@"确定", nil];
    if (config.addInput) {
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        config.textFieldBlock?config.textFieldBlock([alert textFieldAtIndex:0]):nil;
    }else{
        alert.alertViewStyle = config.v_style;
    }
    [alert.rac_buttonClickedSignal subscribeNext:^(id x) {
        if ([x intValue]) {
            UITextField *textField = [alert textFieldAtIndex:0];
            sure?sure(textField.text):nil;
        }else{
            cancle?cancle():nil;
        }
    }];
    
    [alert show];
}
@end



@implementation UIView (RoundingCorners)

@dynamic roundCorners;

- (void)setBorderColor:(UIColor *)borderColor
{
    if (!self.layer.borderWidth) {
        self.layer.borderWidth = 1.0f;
    }
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor
{
    if (self.layer.borderColor) {
        return [UIColor colorWithCGColor:self.layer.borderColor];
    }
    return self.backgroundColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}
- (void)setRoundCorners:(UIRectCorner)roundCorners
{
    [self setRoundCorners:roundCorners cornerRadii:CGSizeMake(4, 4)];
}

- (void)setRoundCorners:(UIRectCorner)roundCorners cornerRadii:(CGSize)size{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:roundCorners cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


- (void)setCircleWithRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    maskLayer.fillColor = fillColor.CGColor;
    maskLayer.lineJoin = kCALineJoinRound;
    maskLayer.lineCap = kCALineCapRound;
    [self.layer insertSublayer:maskLayer atIndex:0];
}

- (void)cornerRadiusWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType {
    CGSize size = self.bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cornerRadii = CGSizeMake(cornerRadius, cornerRadius);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIGraphicsBeginImageContextWithOptions(size, YES, scale);
        if (nil == UIGraphicsGetCurrentContext()) {
            return;
        }
        UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCornerType cornerRadii:cornerRadii];
        [cornerPath addClip];
        [image drawInRect:self.bounds];
        id processedImageRef = (__bridge id _Nullable)(UIGraphicsGetImageFromCurrentImageContext().CGImage);
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            self.layer.contents = processedImageRef;
        });
    });
}


- (void)createShadow
{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    // 设置阴影偏移量
    self.layer.shadowOffset = CGSizeMake(0,0);
    // 设置阴影透明度
    self.layer.shadowOpacity = 0.5;
    // 设置阴影半径
    self.layer.shadowRadius = self.cornerRadius;
    self.clipsToBounds = NO;
    self.layer.masksToBounds= YES;
}
@end
