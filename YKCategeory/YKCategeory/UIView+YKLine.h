//
//  UIView+YKLine.h
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/6.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YKLineView : UIView

/**
 设置左边距
 */
@property (nonatomic, assign) CGFloat leftMargin;

/**
 设置右边距
 */
@property (nonatomic, assign) CGFloat rightMargin;

/**
 设置线高
 */
@property (nonatomic, assign) CGFloat lineHeight;

/**
 设置线的颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

@end

@interface UIView (YKLine)
// xib支持
@property (nonatomic, assign) IBInspectable BOOL showTopLine;
@property (nonatomic, assign) IBInspectable CGPoint topLineMargin;
@property (nonatomic, assign) IBInspectable BOOL showBottomLine;
@property (nonatomic, assign) IBInspectable CGPoint bottomLineMargin;

- (void)yk_makeTopLine:(void (^)(YKLineView *lineView))make;
- (void)yk_makeBottomLine:(void (^)(YKLineView *lineView))make;

/**
 @return 上边线
 */
- (YKLineView *)topLine;

/**
 @return 下边线
 */
- (YKLineView *)bottomLine;

@end

NS_ASSUME_NONNULL_END
