//
//  HCSWeatherTopView.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/25.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSWeatherTopView.h"
#import "HCSWeatherViewController.h"
#import <MJExtension/MJExtension.h>

#import "HCSCityItem.h"
#import "HCSApiItem.h"
#import "HCSCityApiItem.h"

#import "HCSDailyForecastItem.h"
#import "HCSCondDailyItem.h"
#import "HCSTmpDailyItem.h"

#import "HCSNowItem.h"
#import "HCSCondNowItem.h"
#import "HCSWindNowItem.h"

@interface HCSWeatherTopView ()

@property (weak, nonatomic) IBOutlet UIImageView *airWeatherIcon;
@property (weak, nonatomic) IBOutlet UIButton *airValueButton;
@property (weak, nonatomic) IBOutlet UIImageView *warningWeatherIcon;
@property (weak, nonatomic) IBOutlet UIButton *warningWeatherButton;
@property (weak, nonatomic) IBOutlet UILabel *todayTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayweatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowWeatherLabel;
@property (weak, nonatomic) IBOutlet UIImageView *todayWeatherIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tomorrowWeatherIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nowWindLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowhumidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowBodyFeedTemparetureLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowUltravioletRaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowAirPressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowWeatherStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowTemperatureLabel;
@property (weak, nonatomic) IBOutlet UIButton *todayButton;
@property (weak, nonatomic) IBOutlet UIButton *tomorrowButton;

@end
@implementation HCSWeatherTopView

- (void)awakeFromNib {
    // Initialization code

    self.autoresizingMask = UIViewAutoresizingNone;
    
    [self setUpButtonBackgroudImage];

//    [self setUpWeatherData];
    
    
}

- (void)setUpButtonBackgroudImage
{
    
    [self.todayButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"index_bg_press"] forState:UIControlStateNormal];
    [self.todayButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"index_bg"] forState:UIControlStateHighlighted];
    
    [self.tomorrowButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"index_bg_press"] forState:UIControlStateNormal];
    [self.tomorrowButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"index_bg"] forState:UIControlStateHighlighted];
    
    [self.airValueButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"air_status_bg_pressed"] forState:UIControlStateNormal];
    [self.airValueButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"air_status_bg_white_pressed"] forState:UIControlStateHighlighted];
    
    [self.warningWeatherButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"air_status_bg_pressed"] forState:UIControlStateNormal];
    [self.warningWeatherButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"air_status_bg_white_pressed"] forState:UIControlStateHighlighted];

}

- (void)setUpWeatherData
{

        
//        HCSWeatherViewController *weatherVc = [[HCSWeatherViewController alloc] init];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guangzhou.plist" ofType:nil]];
    
    NSArray *dictArray = dict[@"HeWeather data service 3.0"];

    NSArray *cityItemArray = [HCSCityItem mj_objectArrayWithKeyValuesArray:dictArray];
        
    HCSCityItem *cityItem = [cityItemArray firstObject];
    
    _warningWeatherButton.hidden = YES;
    _warningWeatherIcon.hidden = YES;
    
    _airValueButton.titleLabel.text = [NSString stringWithFormat:@"%@  %@",cityItem.aqi.city.aqi,cityItem.aqi.city.qlty];
    
    HCSDailyForecastItem *firstDailyForecastItem = [cityItem.daily_forecast firstObject];
    _todayTemperatureLabel.text = [NSString stringWithFormat:@"%@/%@ °C",firstDailyForecastItem.tmp.max,firstDailyForecastItem.tmp.min];
    _todayweatherLabel.text = firstDailyForecastItem.cond.txt_d;

   NSDictionary *weatherCodeDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weatherCode" ofType:@"plist"]];
    NSString *codeStr1 = firstDailyForecastItem.cond.code_d;
    if (weatherCodeDict[codeStr1]) {
        _todayWeatherIconImageView.image = [UIImage imageNamed:weatherCodeDict[codeStr1]];
    }else
    {
        _todayWeatherIconImageView.image = [UIImage imageNamed:@"w44"];

    }
    
    HCSDailyForecastItem *secondDailyForecastItem = [cityItem.daily_forecast objectAtIndex:1];
    _tomorrowTemperatureLabel.text = [NSString stringWithFormat:@"%@/%@ °C",secondDailyForecastItem.tmp.max,secondDailyForecastItem.tmp.min];
    _tomorrowWeatherLabel.text = secondDailyForecastItem.cond.txt_d;
    NSString *codeStr2 = secondDailyForecastItem.cond.code_d;
    _todayWeatherIconImageView.image = [UIImage imageNamed:weatherCodeDict[codeStr2]];
    
    _nowWindLabel.text = [NSString stringWithFormat:@"%@ %@级",cityItem.now.wind.dir,cityItem.now.wind.sc];
    _nowhumidityLabel.text = [NSString stringWithFormat:@"湿度 %@%%",cityItem.now.hum];
    _nowBodyFeedTemparetureLabel.text = [NSString stringWithFormat:@"体感 %@°C",cityItem.now.fl];
    _nowUltravioletRaysLabel.text = [NSString stringWithFormat:@"能见度 %@km",cityItem.now.vis];
    _nowAirPressureLabel.text = [NSString stringWithFormat:@"气压 %@hPa",cityItem.now.pres];
    _nowWeatherStatusLabel.text = cityItem.now.cond.txt;
    _nowTemperatureLabel.text = [NSString stringWithFormat:@"%@°C",cityItem.now.tmp];
    
    
}

- (void)setCityItem:(HCSCityItem *)cityItem
{
    _cityItem = cityItem;
    
    _warningWeatherButton.hidden = YES;
    _warningWeatherIcon.hidden = YES;
    
    if (cityItem.aqi.city.aqi&&cityItem.aqi.city.qlty) {
        
        _airWeatherIcon.hidden = NO;
        _airValueButton.hidden = NO;
        
        NSDictionary *weatherAqiDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weatherAqiIcon" ofType:@"plist"]];
        NSString *aqiStr = cityItem.aqi.city.qlty;
        
        _airWeatherIcon.image = weatherAqiDict[aqiStr]? [UIImage imageNamed:weatherAqiDict[aqiStr]] : [UIImage imageNamed:@"weather_aqi_icon_level_100"];
        
        [_airValueButton setTitle:[NSString stringWithFormat:@"%@  %@",cityItem.aqi.city.aqi,cityItem.aqi.city.qlty] forState:UIControlStateNormal];
    }else
    {
        _airWeatherIcon.hidden = YES;
        _airValueButton.hidden = YES;
    }

    
    HCSDailyForecastItem *firstDailyForecastItem = [cityItem.daily_forecast firstObject];
    _todayTemperatureLabel.text = [NSString stringWithFormat:@"%@/%@ °C",firstDailyForecastItem.tmp.max,firstDailyForecastItem.tmp.min];
    _todayweatherLabel.text = firstDailyForecastItem.cond.txt_d;
    
//    NSDictionary *weatherCodeDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weatherCode" ofType:@"plist"]];
    NSString *codeStr1 = firstDailyForecastItem.cond.code_d;
    
    _todayWeatherIconImageView.image = [UIImage imageNamed:codeStr1]? [UIImage imageNamed:codeStr1] : [UIImage imageNamed:@"w44"];
    
    HCSDailyForecastItem *secondDailyForecastItem = [cityItem.daily_forecast objectAtIndex:1];
    _tomorrowTemperatureLabel.text = [NSString stringWithFormat:@"%@/%@ °C",secondDailyForecastItem.tmp.max,secondDailyForecastItem.tmp.min];
    _tomorrowWeatherLabel.text = secondDailyForecastItem.cond.txt_d;
    NSString *codeStr2 = secondDailyForecastItem.cond.code_d;

    _tomorrowWeatherIconImageView.image = [UIImage imageNamed:codeStr2]? [UIImage imageNamed:codeStr2] : [UIImage imageNamed:@"w44"];
    
    _nowWindLabel.text = [NSString stringWithFormat:@"%@ %@级",cityItem.now.wind.dir,cityItem.now.wind.sc];
    _nowhumidityLabel.text = [NSString stringWithFormat:@"湿度 %@%%",cityItem.now.hum];
    _nowBodyFeedTemparetureLabel.text = [NSString stringWithFormat:@"体感 %@°C",cityItem.now.fl];
    _nowUltravioletRaysLabel.text = [NSString stringWithFormat:@"能见度 %@km",cityItem.now.vis];
    _nowAirPressureLabel.text = [NSString stringWithFormat:@"气压 %@hPa",cityItem.now.pres];
    _nowWeatherStatusLabel.text = cityItem.now.cond.txt;
    _nowTemperatureLabel.text = [NSString stringWithFormat:@"%@°C",cityItem.now.tmp];
}

+ (instancetype)loadTopCellView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
