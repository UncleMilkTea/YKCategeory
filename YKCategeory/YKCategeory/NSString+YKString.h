//
//  NSString+YKString.h
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/6.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (YKString)
/**
 @return 纯字符长度
 */
- (NSUInteger)unicodeLength;

/**
 和匹配的字符串不相同
 
 @param str 需要比较的字符串
 @return 结果
 */
- (BOOL)isDiffToString:(NSString *)str;

/**
 根据字号计算文字大小(一行)
 
 @param font 字号
 @return 大小
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

/**
 根据字号计算文字大小(一行)
 
 @param font 字号
 @return 大小
 */
- (CGSize)sizeWithFont:(UIFont *)font;

/**
 去除空格
 
 @return 去除空格后的字符串
 */
- (NSString *)trim;

/**
 去除空格之后的长度
 */
- (NSUInteger)trimLength;

/**
 判断是否包含某个字符串
 */
- (BOOL)contains:(NSString *)string;

/**
 判断是否包含某个字符串,忽略大小写
 
 @param string 忽略大小写
 @return 查找结果
 */
- (BOOL)containsStringIgnoreCase:(NSString *)string;

/**
 判断字符串的范围,忽略大小写
 
 @param searchString 要查找的字符串
 @return 范围
 */
- (NSRange)rangeOfStringIgnoreCase:(NSString *)searchString;
/**
 *  拼接为文档的路径
 */
- (NSString *)documentPath;

/**
 *  拼接为缓存的路径
 */
- (NSString *)cachePath;

/**
 *  拼接为临时文件的路径
 */
- (NSString *)tempPath;

/**
 *  计算当前文件\文件夹的内容大小 B
 */
- (NSInteger)fileSize;
@end

@interface NSMutableString (YKString)

/**
    拼接字符串
 */
- (NSMutableString * (^)(NSString *str))aps;

@end


@interface NSAttributedString (YKString)

/**
 快速创建属性字符串
 
 @param color 颜色
 @param fontsize 字号
 @return 属性字符串
 */
+ (instancetype)attributedString:(NSString *)string color:(UIColor *)color fontsize:(CGFloat)fontsize alignment:(NSTextAlignment)alignment;
+ (instancetype)attributedString:(NSString *)string color:(UIColor *)color fontsize:(CGFloat)fontsize alignment:(NSTextAlignment)alignment isbold:(BOOL)isbold;

@end

@interface NSMutableAttributedString (YKString)

/**
 行间距
 */
@property(nonatomic, assign) CGFloat lineSpacing;

/**
 段间距
 */
@property(nonatomic, assign) CGFloat paragraphSpacing;

/**
 拼接字符串
 
 @param string 字符串
 @param color 颜色
 @param fontsize 字号
 @return 新的字符串
 */
- (NSMutableAttributedString *)appendString:(NSString *)string color:(UIColor *)color fontsize:(CGFloat)fontsize alignment:(NSTextAlignment)alignment;

- (NSMutableAttributedString *)appendString:(NSString *)string color:(UIColor *)color fontsize:(CGFloat)fontsize alignment:(NSTextAlignment)alignment isBold:(BOOL)isBold;


@end

NS_ASSUME_NONNULL_END
