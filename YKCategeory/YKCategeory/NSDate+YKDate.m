//
//  NSDate+YKDate.m
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/9/5.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import "NSDate+YKDate.h"

@implementation NSDate (YKDate)

- (BOOL)isToday
{
    NSDate *date = [NSDate date];
    return [self yk_day] == [date yk_day] && [self yk_month] == [date yk_month] && [self yk_year] == [date yk_year];
}

- (BOOL)isYesToday
{
    NSDate *date = [NSDate date];
    NSDate *cmpDate = [self yk_dateByAddingDays:1];
    return [cmpDate yk_day] == [date yk_day] && [cmpDate yk_month] == [date yk_month] && [cmpDate yk_year] == [date yk_year];
}

- (BOOL)isThisYear
{
    return [self yk_year] == [[NSDate date] yk_year];
}

- (NSInteger)yk_year
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitYear fromDate:self];
    return component.year;
}

- (NSInteger)yk_month
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitMonth
                                              fromDate:self];
    return component.month;
}

- (NSInteger)yk_day
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitDay
                                              fromDate:self];
    return component.day;
}

- (NSInteger)yk_weekday
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return component.weekday;
}

- (NSInteger)yk_weekOfYear
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekOfYear fromDate:self];
    return component.weekOfYear;
}

- (NSInteger)yk_hour
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitHour
                                              fromDate:self];
    return component.hour;
}

- (NSInteger)yk_minute
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitMinute
                                              fromDate:self];
    return component.minute;
}

- (NSInteger)yk_second
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitSecond
                                              fromDate:self];
    return component.second;
}

- (NSDate *)yk_dateByIgnoringTimeComponents
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    return [calendar dateFromComponents:components];
}

- (NSDate *)yk_firstDayOfMonth
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth| NSCalendarUnitDay fromDate:self];
    components.day = 1;
    return [calendar dateFromComponents:components];
}

- (NSDate *)yk_lastDayOfMonth
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    components.month++;
    components.day = 0;
    return [calendar dateFromComponents:components];
}

- (NSDate *)yk_firstDayOfWeek
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSDateComponents *componentsToSubtract = [NSDateComponents yk_sharedDateComponents];
    componentsToSubtract.day = - (weekdayComponents.weekday - calendar.firstWeekday);
    NSDate *beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:beginningOfWeek];
    beginningOfWeek = [calendar dateFromComponents:components];
    componentsToSubtract.day = NSIntegerMax;
    return beginningOfWeek;
}

- (NSDate *)yk_middleOfWeek
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSDateComponents *componentsToSubtract = [NSDateComponents yk_sharedDateComponents];
    componentsToSubtract.day = - (weekdayComponents.weekday - calendar.firstWeekday) + 3;
    NSDate *middleOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:middleOfWeek];
    middleOfWeek = [calendar dateFromComponents:components];
    componentsToSubtract.day = NSIntegerMax;
    return middleOfWeek;
}

- (NSDate *)yk_tomorrow
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    components.day++;
    return [calendar dateFromComponents:components];
}

- (NSDate *)yk_yesterday
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    components.day--;
    return [calendar dateFromComponents:components];
}

- (NSInteger)yk_numberOfDaysInMonth
{
    NSCalendar *c = [NSCalendar yk_sharedCalendar];
    NSRange days = [c rangeOfUnit:NSCalendarUnitDay
                           inUnit:NSCalendarUnitMonth
                          forDate:self];
    return days.length;
}

+ (instancetype)yk_dateFromString:(NSString *)string format:(NSString *)format
{
    return [self yk_dateFromString:string format:format isUTC:NO];
}

+ (instancetype)yk_dateFromString:(NSString *)string format:(NSString *)format isUTC:(BOOL)isUTC
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (isUTC) {
        [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    }
    formatter.dateFormat = format;
    return [formatter dateFromString:string];
}

+ (instancetype)yk_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *components = [NSDateComponents yk_sharedDateComponents];
    components.year = year;
    components.month = month;
    components.day = day;
    NSDate *date = [calendar dateFromComponents:components];
    components.year = NSIntegerMax;
    components.month = NSIntegerMax;
    components.day = NSIntegerMax;
    return date;
}

- (NSDate *)yk_dateByAddingYears:(NSInteger)years
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *components = [NSDateComponents yk_sharedDateComponents];
    components.year = years;
    NSDate *date = [calendar dateByAddingComponents:components toDate:self options:0];
    components.year = NSIntegerMax;
    return date;
}

- (NSDate *)yk_dateBySubtractingYears:(NSInteger)years
{
    return [self yk_dateByAddingYears:-years];
}

- (NSDate *)yk_dateByAddingMonths:(NSInteger)months
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *components = [NSDateComponents yk_sharedDateComponents];
    components.month = months;
    NSDate *date = [calendar dateByAddingComponents:components toDate:self options:0];
    components.month = NSIntegerMax;
    return date;
}

- (NSDate *)yk_dateBySubtractingMonths:(NSInteger)months
{
    return [self yk_dateByAddingMonths:-months];
}

- (NSDate *)yk_dateByAddingWeeks:(NSInteger)weeks
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *components = [NSDateComponents yk_sharedDateComponents];
    components.weekOfYear = weeks;
    NSDate *date = [calendar dateByAddingComponents:components toDate:self options:0];
    components.weekOfYear = NSIntegerMax;
    return date;
}

-(NSDate *)yk_dateBySubtractingWeeks:(NSInteger)weeks
{
    return [self yk_dateByAddingWeeks:-weeks];
}

- (NSDate *)yk_dateByAddingDays:(NSInteger)days
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *components = [NSDateComponents yk_sharedDateComponents];
    components.day = days;
    NSDate *date = [calendar dateByAddingComponents:components toDate:self options:0];
    components.day = NSIntegerMax;
    return date;
}

- (NSDate *)yk_dateBySubtractingDays:(NSInteger)days
{
    return [self yk_dateByAddingDays:-days];
}

- (NSInteger)yk_yearsFrom:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear
                                               fromDate:date
                                                 toDate:self
                                                options:0];
    return components.year;
}

- (NSInteger)yk_monthsFrom:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth
                                               fromDate:date
                                                 toDate:self
                                                options:0];
    return components.month;
}

- (NSInteger)yk_weeksFrom:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekOfYear
                                               fromDate:date
                                                 toDate:self
                                                options:0];
    return components.weekOfYear;
}

- (NSInteger)yk_daysFrom:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar yk_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                               fromDate:date
                                                 toDate:self
                                                options:0];
    return components.day;
}

- (NSString *)yk_stringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [NSDateFormatter yk_sharedDateFormatter];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *)yk_string
{
    return [self yk_stringWithFormat:@"yyyyMMdd"];
}


- (BOOL)yk_isEqualToDateForMonth:(NSDate *)date
{
    return self.yk_year == date.yk_year && self.yk_month == date.yk_month;
}

- (BOOL)yk_isEqualToDateForWeek:(NSDate *)date
{
    return self.yk_year == date.yk_year && self.yk_weekOfYear == date.yk_weekOfYear;
}

- (BOOL)yk_isEqualToDateForDay:(NSDate *)date
{
    return self.yk_year == date.yk_year && self.yk_month == date.yk_month && self.yk_day == date.yk_day;
}

- (NSString*)timeDistenceNow:(NSString *)timeStr
{
    NSDateFormatter * dateFormater = [[NSDateFormatter alloc]init];
    dateFormater.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * beforeDate = [dateFormater dateFromString:timeStr];
    NSDate * nowDate = [NSDate date];
    
    //1、判断是否处在同一年
    NSDateComponents * beforeDatecomp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:beforeDate];
    NSDateComponents * nowDateComp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:nowDate];
    NSInteger  beforeYear = [beforeDatecomp year];
    NSInteger nowYear = [nowDateComp year];
    NSString * distanceStr = nil;
    if (beforeYear == nowYear) {
        //同一年
        NSTimeInterval beTime=[beforeDate timeIntervalSince1970];
        NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
        double distanceTime = now - beTime;
        if (distanceTime < 60*60) {
            if (distanceTime < 60) {
                distanceStr = @"1分钟前";
            }else{
                distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
            }
        }else if (distanceTime < 60*60*24){
            distanceStr=[NSString stringWithFormat:@"%ld小时前",(long)distanceTime/(60*60)];
        }else if (distanceTime < 60*60*24*7){
            distanceStr=[NSString stringWithFormat:@"%ld天前",(long)distanceTime/(24*60*60)];
        }else{
            distanceStr = [NSString stringWithFormat:@"%zd-%zd",[beforeDatecomp month],[beforeDatecomp day]];
        }
        
    }else{
        //不在同一年
        distanceStr = [NSString stringWithFormat:@"%zd-%zd-%zd",beforeYear,[beforeDatecomp month],[beforeDatecomp day]];
    }
    
    return distanceStr;
}
@end

