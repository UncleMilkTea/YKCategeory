//
//  NSString+YKString.m
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/6.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import "NSString+YKString.h"

@implementation NSString (YKString)

- (NSUInteger)unicodeLength
{
    NSUInteger length = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        int ch = [self characterAtIndex:i];
        // 如果是汉字 +2
        if (isascii(ch)){
            length += 1;
        }else{
            length += 2;
        }
    }
    return length;
}

- (BOOL)isDiffToString:(NSString *)str
{
    return ![self isEqualToString:str];
}

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSAssert(font != nil, @"font不能为空!!");
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSUInteger)trimLength
{
    return self.trim.length;
}

- (BOOL)contains:(NSString *)string
{
    if (string.trimLength == 0) {
        return NO;
    }
    
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0) {
        return [self containsString:string];
    }
    
    return (BOOL)([self rangeOfString:string].length > 0);
}

- (BOOL)containsStringIgnoreCase:(NSString *)string
{
    return [self rangeOfStringIgnoreCase:string].length;
}

- (NSRange)rangeOfStringIgnoreCase:(NSString *)searchString
{
    return [self.lowercaseString rangeOfString:searchString.lowercaseString];
}

- (NSString *)documentPath
{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    if ([self rangeOfString:@"//"].length > 0){
        NSLog(@"路径不合法");
        return nil;
    }
    return [document stringByAppendingPathComponent:self];
}

- (NSString *)cachePath
{
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    if ([self rangeOfString:@"//"].length > 0) {
        NSLog(@"路径不合法");
        return nil;
    }
    return [cache stringByAppendingPathComponent:self];
}

- (NSString *)tempPath
{
    NSString *temp = NSTemporaryDirectory();
    if ([self rangeOfString:@"//"].length > 0) {
        NSLog(@"路径不合法");
        return nil;
    }
    return [temp stringByAppendingPathComponent:self];
}

- (NSInteger)fileSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    // 文件\文件夹不存在
    if (exists == NO) return 0;
    
    if (dir) { // self是一个文件夹
        // 遍历caches里面的所有内容 --- 直接和间接内容
        NSArray *subpaths = [mgr subpathsAtPath:self];
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
            if (dir == NO) { // 文件
                totalByteSize += [[mgr attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // self是一个文件
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
}
@end

@implementation NSMutableString (YKString)

- (NSMutableString * (^)(NSString *))aps
{
    return ^(NSString *str){
        if (str.length == 0) {
            return self;
        }
        if ([self respondsToSelector:@selector(appendString:)]) {
            [self appendString:str];
        }
        return self;
    };
}

@end


@implementation NSAttributedString (YKString)

+ (instancetype)attributedString:(NSString *)string color:(UIColor *)color fontsize:(CGFloat)fontsize alignment:(NSTextAlignment)alignment
{
    return [self attributedString:string color:color fontsize:fontsize alignment:alignment isbold:NO];
}

+ (instancetype)attributedString:(NSString *)string color:(UIColor *)color fontsize:(CGFloat)fontsize alignment:(NSTextAlignment)alignment isbold:(BOOL)isbold
{
    if (!string.length) {
        return nil;
    }
    NSAssert(color != nil, @"颜色不能为空!!");
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = alignment;
    UIFont *font = isbold ? [UIFont boldSystemFontOfSize:fontsize] : [UIFont systemFontOfSize:fontsize];
    return [[self alloc] initWithString:string attributes:
            @{
              NSFontAttributeName : font,
              NSForegroundColorAttributeName : color,
              NSParagraphStyleAttributeName:paragraphStyle
              }];
}

@end

@implementation NSMutableAttributedString (YKString)

- (void)setLineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = lineSpacing;
    [self addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.length)];
}

- (CGFloat)lineSpacing
{
    NSRange range = NSMakeRange(0, self.length);
    NSMutableParagraphStyle *style = [self attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:&range];
    if (style) {
        return style.lineSpacing;
    }
    return 0.0;
}

- (void)setParagraphSpacing:(CGFloat)paragraphSpacing
{
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.paragraphSpacing = paragraphSpacing;
    [self addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.length)];
}

- (CGFloat)paragraphSpacing
{
    NSRange range = NSMakeRange(0, self.length);
    NSMutableParagraphStyle *style = [self attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:&range];
    if (style) {
        return style.paragraphSpacing;
    }
    return 0.0;
}

- (NSMutableAttributedString *)appendString:(NSString *)string color:(UIColor *)color fontsize:(CGFloat)fontsize alignment:(NSTextAlignment)alignment
{
    return  [self appendString:string color:color fontsize:fontsize alignment:alignment isBold:NO];
}

- (NSMutableAttributedString *)appendString:(NSString *)string color:(UIColor *)color fontsize:(CGFloat)fontsize alignment:(NSTextAlignment)alignment isBold:(BOOL)isBold{
    NSAttributedString *str = [NSAttributedString attributedString:string color:color fontsize:fontsize alignment:alignment isbold:isBold];
    if (str.length) {
        [self appendAttributedString:str];
    }else{
        NSLog(@"%@ 插入的字符串为空", self);
    }
    return self;
}
@end
