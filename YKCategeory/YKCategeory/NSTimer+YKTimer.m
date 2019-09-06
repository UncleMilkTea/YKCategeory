//
//  NSTimer+YKTimer.m
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/5.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import "NSTimer+YKTimer.h"

@implementation NSTimer (YKTimer)
-(void)pauseTimer{
    
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
    
}
-(void)resumeTimer{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}
@end
