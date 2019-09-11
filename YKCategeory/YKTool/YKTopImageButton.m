//
//  YKTopImageButton.m
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/11.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import "YKTopImageButton.h"

@implementation YKTopImageButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

/**
 *  进行初始化设置
 */
- (void)setUp
{
    _imageTitleMargin = 4;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self setNeedsLayout];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat totalHeight = self.imageView.bounds.size.height + self.titleLabel.bounds.size.height + _imageTitleMargin;
    CGFloat space = (self.bounds.size.height - totalHeight) * 0.5;
    
    self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, space, self.imageView.bounds.size.width, self.imageView.bounds.size.height);
    self.imageView.center = CGPointMake(self.bounds.size.width * 0.5, self.imageView.center.y);
    self.titleLabel.frame = CGRectMake(0, self.bounds.size.height - space - self.titleLabel.bounds.size.height, self.bounds.size.width, self.titleLabel.bounds.size.height);
}

-(void)setImageTitleMargin:(CGFloat)imageTitleMargin
{
    _imageTitleMargin = imageTitleMargin;
    [self setNeedsLayout];
}

@end
