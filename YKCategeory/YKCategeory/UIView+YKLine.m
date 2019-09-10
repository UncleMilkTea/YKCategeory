//
//  UIView+YKLine.m
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/6.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import "UIView+YKLine.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

#define YKLineViewDefaultHeight 1
#define YKLineViewDefaultColor UIColor.lightGrayColor


@implementation YKLineView
{
    // 是不是topLine
    BOOL isTopLine;
}

- (void)setLineHeight:(CGFloat)lineHeight
{
    _lineHeight = lineHeight;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(lineHeight);
    }];
}

- (void)setLeftMargin:(CGFloat)leftMargin
{
    _leftMargin = leftMargin;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.superview).offset(-leftMargin);
    }];
}

- (void)setRightMargin:(CGFloat)rightMargin
{
    _rightMargin = rightMargin;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.superview).offset(rightMargin);
    }];
    
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
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(YKLineViewDefaultHeight);
        }];
        objc_setAssociatedObject(self, @selector(topLine), line, OBJC_ASSOCIATION_ASSIGN);
        lineV = line;
    }
    make?make(lineV):NULL;
}

- (void)yk_makeBottomLine:(void (^)(YKLineView *))make
{
    YKLineView *lineV = self.bottomLine;
    if (lineV == nil) {
        YKLineView *line = [[YKLineView alloc] init];
        line.backgroundColor = YKLineViewDefaultColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(YKLineViewDefaultHeight);
        }];
        objc_setAssociatedObject(self, @selector(bottomLine), line, OBJC_ASSOCIATION_ASSIGN);
        lineV = line;
    }
    make?make(lineV):NULL;
    
}

- (YKLineView *)topLine
{
    return objc_getAssociatedObject(self, _cmd);
}

- (YKLineView *)bottomLine
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
    [self yk_makeTopLine:^(YKLineView *lineView) {
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
    [self yk_makeBottomLine:^(YKLineView *lineView) {
        lineView.leftMargin = bottomLineMargin.x;
        lineView.rightMargin = bottomLineMargin.y;
    }];
}

- (CGPoint)bottomLineMargin
{
    return CGPointMake(self.bottomLine.leftMargin, self.bottomLine.rightMargin);
}

@end
