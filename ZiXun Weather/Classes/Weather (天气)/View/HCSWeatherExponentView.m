//
//  HCSWeatherExponentView.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/26.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSWeatherExponentView.h"
#import "HCSExponentContentViewCell.h"
#import "HCSCityItem.h"
#import <MJExtension/MJExtension.h>
#import "HCSSuggestionItem.h"

#import "HCScomfSuggestionItem.h"
#import "HCSCwSuggestion.h"
#import "HCSDrsgSuggestion.h"
#import "HCSFlusuggestion.h"
#import "HCSSportsuggestion.h"
#import "HCSTravsuggestion.h"
#import "HCSUvsuggestion.h"

#import "HCSDailyForecastItem.h"
#import "HCSAstroDailyItem.h"

static NSString * const exponentID = @"exponentCell";
static NSInteger const collectionViewCellCount = 8;

@interface HCSWeatherExponentView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *sunSetLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunRiseLabel;

@property (weak, nonatomic) IBOutlet UIView *exponentContentView;
@property (weak, nonatomic) IBOutlet UIImageView *exponentBackgroudImageView;
@property (nonatomic,weak) UICollectionView *collectionView;

@property (nonatomic,strong) HCSSuggestionItem *suggestionItem;

@end

@implementation HCSWeatherExponentView

+ (instancetype)loadExponentCellView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.exponentBackgroudImageView.image = [HCSResizeImageTool HCSResizeImageWithImageName:@"hour_info_bg"];
    
    [self setupBottomView];
    
//    [self setUpData];
}

- (void)setUpData
{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guangzhou.plist" ofType:nil]];
    
    NSArray *dictArray = dict[@"HeWeather data service 3.0"];
    
    NSArray *cityItemArray = [HCSCityItem mj_objectArrayWithKeyValuesArray:dictArray];
    
    HCSCityItem *cityItem = [cityItemArray firstObject];
    
    self.suggestionItem = cityItem.suggestion;
    
    NSArray *dailyForecastItemArray = cityItem.daily_forecast;
    
    HCSDailyForecastItem *dailyItem = [dailyForecastItemArray firstObject];
    
    _sunRiseLabel.text = [NSString stringWithFormat:@"日出 %@",dailyItem.astro.sr];
    _sunSetLabel.text = [NSString stringWithFormat:@"日落 %@",dailyItem.astro.ss];
}

- (void)setCityItem:(HCSCityItem *)cityItem
{
    _cityItem = cityItem;
    
    self.suggestionItem = cityItem.suggestion;
    
    NSArray *dailyForecastItemArray = cityItem.daily_forecast;
    
    HCSDailyForecastItem *dailyItem = [dailyForecastItemArray firstObject];
    
    _sunRiseLabel.text = [NSString stringWithFormat:@"日出 %@",dailyItem.astro.sr];
    _sunSetLabel.text = [NSString stringWithFormat:@"日落 %@",dailyItem.astro.ss];
}

// 搭建底部view
- (void)setupBottomView
{
    CGFloat itemCount = (CGFloat)collectionViewCellCount;
    CGFloat itemColumn = 2.0;
    CGFloat space = 1;
    CGFloat itemRow = itemCount / itemColumn;
    CGFloat itemSizeWidth = (self.exponentContentView.hcs_width - space) / itemColumn;
    CGFloat itemSizeHeight = (self.exponentContentView.hcs_height - itemRow - 1) / itemRow;
    // 设置布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemSizeWidth, itemSizeHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = space;
    layout.minimumLineSpacing = space;
    
    // 指示器，cell间距，分页
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.exponentContentView.bounds collectionViewLayout:layout];
    _collectionView = collectionView;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.bounces = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    [self.exponentContentView addSubview:collectionView];
    
    // 注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"HCSExponentContentViewCell" bundle:nil] forCellWithReuseIdentifier:exponentID];
}

#pragma mark - UICollectionViewDataSource
// 有多少个子控制器就有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

// 只要有新的cell显示的时候才会调用
// 返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCSExponentContentViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:exponentID forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.comfSuggestionItem = _suggestionItem.comf;
    }else if (indexPath.row == 1)
    {
        cell.cwSuggestionItem = _suggestionItem.cw;
    }else if (indexPath.row == 2)
    {
        cell.drsgSuggestionItem = _suggestionItem.drsg;
    }else if (indexPath.row == 3)
    {
        cell.fluSuggestionItem = _suggestionItem.flu;
    }else if (indexPath.row == 4)
    {
        cell.travSuggestionItem = _suggestionItem.trav;
    }else if (indexPath.row == 5)
    {
        cell.sportSuggestionItem = _suggestionItem.sport;
    }else if (indexPath.row == 6)
    {
        cell.uvSuggestionItem = _suggestionItem.uv;
    }else
    {
        cell = nil;
    }

    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *urlStr = _bottomNewsItem.url;
//    
    // 创建通知
    NSNotification *note = [NSNotification notificationWithName:@"expontCollection" object:nil userInfo:@{@"NewUrl" : @"cvdf"}];
    // 发布通知
    [[NSNotificationCenter defaultCenter] postNotification:note];

    
}


@end
