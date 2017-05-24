//
//  HCSCollectionViewCell.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/25.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSCollectionViewCell.h"
#import "HCSCityItem.h"
#import <MJExtension/MJExtension.h>
#import "HCSDailyForecastItem.h"
#import "NSDate+date.h"
#import "HCSCondDailyItem.h"
#import "HCSTmpDailyItem.h"
#import "HCSWindDaityItem.h"


@interface HCSCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cellBackgroudImageView;
@property (weak, nonatomic) IBOutlet UILabel *weekDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherStatusMorningLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherStatusMorningIcon;
@property (weak, nonatomic) IBOutlet UILabel *maxTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *minTemperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherStatusLateIcon;
@property (weak, nonatomic) IBOutlet UILabel *weatherStatusLateLabel;
@property (weak, nonatomic) IBOutlet UILabel *windRankLabel;
@property (weak, nonatomic) IBOutlet UILabel *windStatusLabel;

@end

@implementation HCSCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.autoresizingMask = UIViewAutoresizingNone;
    self.cellBackgroudImageView.image = [HCSResizeImageTool HCSResizeImageWithImageName:@"sun_carrule_bg"];
    
    
}

- (void)setDailyAllForecastItem:(HCSDailyForecastItem *)dailyAllForecastItem
{
    _dailyAllForecastItem = dailyAllForecastItem;
  
    // 获取日期对象
    // NSDateFormatter:日期字符串转 日期 ， 日期 转 日期字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 2015-08-24
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *createDate = [fmt dateFromString:dailyAllForecastItem.date];
    _weekDayLabel.text = [createDate isThisDay]? @"今天" : [self getWeekDay:dailyAllForecastItem.date];
    
    NSRange rangeM = NSMakeRange(5, 2);
    NSString *dateNumberStrM = [dailyAllForecastItem.date substringWithRange:rangeM];
    NSRange rangeD = NSMakeRange(8, 2);
    NSString *dateNumberStrD = [dailyAllForecastItem.date substringWithRange:rangeD];
    _dateDayLabel.text = [NSString stringWithFormat:@"%@/%@",dateNumberStrM,dateNumberStrD];
    
    _weatherStatusMorningLabel.text = dailyAllForecastItem.cond.txt_d;
    
//    NSDictionary *weatherCodeDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weatherCode" ofType:@"plist"]];
    NSString *codeStr1 = dailyAllForecastItem.cond.code_d;

    _weatherStatusMorningIcon.image = [UIImage imageNamed:codeStr1]?[UIImage imageNamed:codeStr1] : [UIImage imageNamed:@"w44"];
    
    _maxTemperatureLabel.text = [NSString stringWithFormat:@"%@°",dailyAllForecastItem.tmp.max];
    
    _minTemperatureLabel.text = [NSString stringWithFormat:@"%@°",dailyAllForecastItem.tmp.min];
    
    NSString *codeStr2 = dailyAllForecastItem.cond.code_n;

    _weatherStatusLateIcon.image = [UIImage imageNamed:codeStr2]?[UIImage imageNamed:codeStr2] : [UIImage imageNamed:@"w44"];
    
    _weatherStatusLateLabel.text = dailyAllForecastItem.cond.txt_n;
    
    _windStatusLabel.text = dailyAllForecastItem.wind.dir;
    
    _windRankLabel.text = [NSString stringWithFormat:@"%@级",dailyAllForecastItem.wind.sc];

}

- (NSString *)getWeekDay:(NSString *)dateString
{
//    NSString *dateString = @"2016-05-31"; //NSMakeRange(0, 4); NSMakeRange(5, 2); NSMakeRange(8, 2);
    
    NSInteger dateNumber = 0;
    NSArray *array = [NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSRange rangeY = NSMakeRange(0, 4);
    dateNumber = [[dateString substringWithRange:rangeY] integerValue];
    [comps setYear:dateNumber];
    
    NSRange rangeM = NSMakeRange(5, 2);
    dateNumber = [[dateString substringWithRange:rangeM] integerValue];
    [comps setMonth:dateNumber];
    
    NSRange rangeD = NSMakeRange(8, 2);
    dateNumber = [[dateString substringWithRange:rangeD] integerValue];
    [comps setDay:dateNumber];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekday = [weekdayComponents weekday];
    
    return [array objectAtIndex:weekday - 1];
}


@end
