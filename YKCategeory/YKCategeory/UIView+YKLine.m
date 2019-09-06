//
//  UIView+YKLine.m
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/6.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import "UIView+YKLine.h"
#import <objc/runtime.h>
#define YKLineViewDefaultHeight 1
#define YKLineViewDefaultColor  [UIColor colorWithHexString:@"#f5f5f5"]

@implementation YKLineView
{
    // 是不是topLine
    BOOL isTopLine;
}

- (void)setLineHeight:(CGFloat)lineHeight
{
    _lineHeight = lineHeight;
    
    self.sd_layout.heightIs(lineHeight);
}

- (void)setLeftMargin:(CGFloat)leftMargin
{
    _leftMargin = leftMargin;
    
    self.sd_layout.leftSpaceToView(self.superview, leftMargin);
}

- (void)setRightMargin:(CGFloat)rightMargin
{
    _rightMargin = rightMargin;
    
    self.sd_layout.rightSpaceToView(self, rightMargin);
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    self.backgroundColor = lineColor;
}

@end

@implementation UIView (YKLine)



- (void)yk_makeTopLine:(void (^)(YKLineView *))make
{
    YKLineView *lineV = self.topLine;
    if (lineV == nil) {
        YKLineView *line = [[YKLineView alloc] init];
        [line setValue:@YES forKey:@"isTopLine"];
        line.backgroundColor = YKLineViewDefaultColor;
        line.frame = CGRectMake(0, 0, self.bounds.size.width, YKLineViewDefaultHeight);
        [self addSubview:line];
        line.sd_layout.leftEqualToView(self).rightEqualToView(self).topEqualToView(self).heightIs(ZYLineViewDefaultHeight);
        objc_setAssociatedObject(self, @selector(topLine), line, OBJC_ASSOCIATION_ASSIGN);
        lineV = line;
    }
    make?make(lineV):NULL;
}

- (void)yk_makeBottomLine:(void (^)(YKLineView *))make
{
    ZYLineView *lineV = self.bottomLine;
    if (lineV == nil) {
        ZYLineView *line = [[ZYLineView alloc] init];
        line.backgroundColor = ZYLineViewDefaultColor;
        [self addSubview:line];
        line.sd_layout.leftEqualToView(self).rightEqualToView(self).bottomEqualToView(self).heightIs(ZYLineViewDefaultHeight);
        objc_setAssociatedObject(self, @selector(bottomLine), line, OBJC_ASSOCIATION_ASSIGN);
        lineV = line;
    }
    make?make(lineV):NULL;
    
}

- (ZYLineView *)topLine
{
    return objc_getAssociatedObject(self, _cmd);
}

- (ZYLineView *)bottomLine
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setShowTopLine:(BOOL)showTopLine
{
    if (showTopLine) {
        [self yk_makeTopLine:nil];
    }else{
        [self.topLine removeFromSuperview];
    }
}

- (BOOL)showTopLine
{
    return self.topLine?YES:NO;
}

- (void)setTopLineMargin:(CGPoint)topLineMargin
{
    [self yk_makeTopLine:^(ZYLineView *lineView) {
        lineView.leftMargin = topLineMargin.x;
        lineView.rightMargin = topLineMargin.y;
    }];
}

- (CGPoint)topLineMargin
{
    return CGPointMake(self.topLine.leftMargin, self.topLine.rightMargin);
}

- (void)setShowBottomLine:(BOOL)showBottomLine
{
    if (showBottomLine) {
        [self yk_makeBottomLine:nil];
    }else{
        [self.bottomLine removeFromSuperview];
    }
}

- (BOOL)showBottomLine
{
    return self.bottomLine?YES:NO;
}

- (void)setBottomLineMargin:(CGPoint)bottomLineMargin
{
    [self yk_makeBottomLine:^(ZYLineView *lineView) {
        lineView.leftMargin = bottomLineMargin.x;
        lineView.rightMargin = bottomLineMargin.y;
    }];
}

- (CGPoint)bottomLineMargin
{
    return CGPointMake(self.bottomLine.leftMargin, self.bottomLine.rightMargin);
}

@end
