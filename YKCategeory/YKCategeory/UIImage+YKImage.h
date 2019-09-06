//
//  UIImage+YKImage.h
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/8/29.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YKImage)
/*
 获取UIImage的类型
 return @"image/png"
 return @"image/gif"
 return @"image/tiff"
 **/
+ (NSString *)yk_typeForImageData:(NSData *)data;
/**
 *  在一张背景图上绘制文字并且居中
 *
 *  @param str       要绘制到图片上的文字
 *  @param image     背景图片
 *  @param fontSize  文字的大小
 *  @param textColor 文字颜色
 *
 *  @return 绘制上文字的图片
 */
+ (UIImage *)yk_createOtherMerchantImage:(NSString *)str imageSize:(CGSize)size withBgImage:(UIImage *)image withFont:(CGFloat)fontSize withTextColor:(UIColor *)textColor;
//! 用颜色生成一张图片
+ (UIImage *)yk_imageWithColor:(UIColor *)color;
/**
 修复拍照的原图旋转问题
 */
+ (UIImage *)yk_fixOrientation:(UIImage *)aImage;
/**
 裁切照片
 */
+ (UIImage *)yk_clipWithImageRect:(CGRect)clipRect clipImage:(UIImage *)clipImage;

/**
 合成图片
 
 @param image 原始图片
 @param waterImage 水印图片
 @param rect 位置
 @return image
 */
+ (UIImage *)yk_waterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect;
@end

@interface UIImage (ImageEffects)

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end

NS_ASSUME_NONNULL_END
