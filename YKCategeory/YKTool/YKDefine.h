//
//  YKDefine.h
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/11.
//  Copyright © 2019 houyukun. All rights reserved.
//

#ifndef YKDefine_h
#define YKDefine_h

#define YKScreenWidth [UIScreen mainScreen].bounds.size.width
#define YKScreenHeight [UIScreen mainScreen].bounds.size.height
//状态栏
#define YKStatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏
#define YKNavHeight self.navigationController.navigationBar.height


#define YKColor(r, g, b, a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a * 1.0]
#define YKRandomColor COLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define YKHexColor(value,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a*1.0]

#define YKNotificationCenter [NSNotificationCenter defaultCenter]
#define YKKeyPath(OBJ, PATH) \
(((void)(NO && ((void)OBJ.PATH, NO)), #PATH)) // KVO获取key

//----------循环引用----------
#define WS(weakSelf) __weak __typeof(&*self)   weakSelf  = self;
#define SS(strongSelf)  __strong __typeof(&*self) strongSelf = weakSelf;
/**
 *  方块跳转页面
 */
#define LBPushCubeAnimationController(vc,direction)\
CATransition *anima = [CATransition animation];\
anima.type = @"cube";\
anima.subtype = direction; \
anima.duration = 0.5f;\
[[UIApplication sharedApplication].keyWindow.layer addAnimation:anima forKey:@"revealAnimation"];\
[self.navigationController pushViewController:vc animated:NO];
/**
 *  方块pop页面
 */
#define LBPopCubeAnimationController(direction)\
CATransition *anima = [CATransition animation];\
anima.type = @"cube";\
anima.subtype = direction; \
anima.duration = 0.5f;\
[[UIApplication sharedApplication].keyWindow.layer addAnimation:anima forKey:@"revealAnimation"];\
[self.navigationController popViewControllerAnimated:NO];

#pragma mark - 单例模式
//! 单例.h
#define sharedInstanceH + (instancetype)sharedInstance;

//! 单例.m
#if __has_feature(objc_arc)

#define sharedInstanceM \
static id _instace; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
return _instace; \
} \
\
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [[self alloc] init]; \
}); \
return _instace; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instace; \
}

#else

#define sharedInstanceM \
static id _instace; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
return _instace; \
} \
\
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [[self alloc] init]; \
}); \
return _instace; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instace; \
} \
\
- (oneway void)release { } \
- (id)retain { return self; } \
- (NSUInteger)retainCount { return 1;} \
- (id)autorelease { return self;}

#endif
#endif /* YKDefine_h */
