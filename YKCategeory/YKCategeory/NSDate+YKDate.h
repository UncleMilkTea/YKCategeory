//
//  NSDate+YKDate.h
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/5.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (YKDate)

@property (readonly, nonatomic) BOOL isToday;
@property (readonly, nonatomic) BOOL isYesToday;
@property (readonly, nonatomic) BOOL isThisYear;

@property (readonly, nonatomic) NSInteger yk_year;
@property (readonly, nonatomic) NSInteger yk_month;
@property (readonly, nonatomic) NSInteger yk_day;
@property (readonly, nonatomic) NSInteger yk_weekday;
@property (readonly, nonatomic) NSInteger yk_weekOfYear;
@property (readonly, nonatomic) NSInteger yk_hour;
@property (readonly, nonatomic) NSInteger yk_minute;
@property (readonly, nonatomic) NSInteger yk_second;

@property (readonly, nonatomic) NSDate *yk_dateByIgnoringTimeComponents;
@property (readonly, nonatomic) NSDate *yk_firstDayOfMonth;
@property (readonly, nonatomic) NSDate *yk_lastDayOfMonth;
@property (readonly, nonatomic) NSDate *yk_firstDayOfWeek;
@property (readonly, nonatomic) NSDate *yk_middleOfWeek;
@property (readonly, nonatomic) NSDate *yk_tomorrow;
@property (readonly, nonatomic) NSDate *yk_yesterday;
@property (readonly, nonatomic) NSInteger yk_numberOfDaysInMonth;

+ (instancetype)yk_dateFromString:(NSString *)string format:(NSString *)format;
+ (instancetype)yk_dateFromString:(NSString *)string format:(NSString *)format isUTC:(BOOL)isUTC;
+ (instancetype)yk_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

- (NSDate *)yk_dateByAddingYears:(NSInteger)years;
- (NSDate *)yk_dateBySubtractingYears:(NSInteger)years;
- (NSDate *)yk_dateByAddingMonths:(NSInteger)months;
- (NSDate *)yk_dateBySubtractingMonths:(NSInteger)months;
- (NSDate *)yk_dateByAddingWeeks:(NSInteger)weeks;
- (NSDate *)yk_dateBySubtractingWeeks:(NSInteger)weeks;
- (NSDate *)yk_dateByAddingDays:(NSInteger)days;
- (NSDate *)yk_dateBySubtractingDays:(NSInteger)days;
- (NSInteger)yk_yearsFrom:(NSDate *)date;
- (NSInteger)yk_monthsFrom:(NSDate *)date;
- (NSInteger)yk_weeksFrom:(NSDate *)date;
- (NSInteger)yk_daysFrom:(NSDate *)date;

- (BOOL)yk_isEqualToDateForMonth:(NSDate *)date;
- (BOOL)yk_isEqualToDateForWeek:(NSDate *)date;
- (BOOL)yk_isEqualToDateForDay:(NSDate *)date;

- (NSString *)yk_stringWithFormat:(NSString *)format;
- (NSString *)yk_string;
//! 距现在多长时间
- (NSString*)timeDistenceNow:(NSString *)timeStr;

@end

@interface NSCalendar (YKDate)

+ (instancetype)yk_sharedCalendar;

@end

@interface NSDateFormatter (YKDate)

+ (instancetype)yk_sharedDateFormatter;

@end

@interface NSDateComponents (YKDate)

+ (instancetype)yk_sharedDateComponents;

@end

@interface NSString (YKDate)

- (NSDate *)yk_dateWithFmt:(NSString *)fmt;
//! 时间戳转换
- (NSString *)yk_integerWithFmt:(NSString *)fmt;
- (NSString *)yk_dateFmt:(NSString *)dateFmt toFmt:(NSString *)toFmt;

@end
NS_ASSUME_NONNULL_END
