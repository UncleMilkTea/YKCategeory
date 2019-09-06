//
//  YKCategeory.h
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/8/29.
//  Copyright © 2019 houyukun. All rights reserved.
//

#ifndef YKCategeory_h
#define YKCategeory_h

//----------屏幕----------
#define kScreenWidth          ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight         ([UIScreen mainScreen].bounds.size.height)
//状态栏
#define StatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏
#define NavHeight self.navigationController.navigationBar.height

//----------循环引用----------
#define WS(weakSelf)    __weak __typeof(&*self)   weakSelf  = self;
#define SS(strongSelf)  __strong __typeof(&*self) strongSelf = weakSelf;

#define RGBATOCOLOR(rgb,alphaValue) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:alphaValue]



#import "UIImage+YKImage.h"
#import "UIView+YKView.h"
#import "NSTimer+YKTimer.h"
#import "NSArray+YKArray.h"
#import "NSString+YKString.h"
#import "NSDate+YKDate.h"

#endif /* YKCategeory_h */
