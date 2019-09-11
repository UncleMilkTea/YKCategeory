//
//  YKRightImageButton.m
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/11.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import "YKRightImageButton.h"

@implementation YKRightImageButton

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self setNeedsLayout];
}

- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state
{
    [super setAttributedTitle:title forState:state];
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
    
    _imageTitleMargin = _imageTitleMargin?_imageTitleMargin:4;
    
    CGFloat contentW = self.titleLabel.bounds.size.width + self.imageView.bounds.size.width + _imageTitleMargin;
    
    CGFloat margin = (self.bounds.size.width - contentW) * 0.5;
    
    self.titleLabel.frame = CGRectMake(margin, self.titleLabel.frame.origin.y, self.titleLabel.bounds.size.width, self.titleLabel.bounds.size.height);
    
    self.imageView.frame = CGRectMake(self.bounds.size.width - margin - self.imageView.bounds.size.width, self.imageView.frame.origin.y, self.imageView.bounds.size.width, self.imageView.bounds.size.height);
}

@end
