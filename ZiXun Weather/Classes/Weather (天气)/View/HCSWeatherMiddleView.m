//
//  HCSWeatherMiddleView.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/25.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSWeatherMiddleView.h"
#import "HCSCollectionViewCell.h"
#import "HCSCityItem.h"
#import <MJExtension/MJExtension.h>
#import "HCSDailyForecastItem.h"



static NSString * const ID = @"collectionViewCell";

@interface HCSWeatherMiddleView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *weatherContentView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroudImageView;
@property (nonatomic,strong) NSArray *dailyForecastItemArray;


@end

@implementation HCSWeatherMiddleView

+ (instancetype)loadMiddleCellView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.backgroudImageView.image = [HCSResizeImageTool HCSResizeImageWithImageName:@"hour_info_bg"];

    [self setupBottomView];
    
//    [self setUpData];
}

- (void)setUpData
{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guangzhou.plist" ofType:nil]];
    
    NSArray *dictArray = dict[@"HeWeather data service 3.0"];
    
    NSArray *cityItemArray = [HCSCityItem mj_objectArrayWithKeyValuesArray:dictArray];
    
    HCSCityItem *cityItem = [cityItemArray firstObject];
    
    _dailyForecastItemArray = cityItem.daily_forecast;
    
}

- (void)setCityItem:(HCSCityItem *)cityItem
{
    _cityItem = cityItem;
    
    _dailyForecastItemArray = cityItem.daily_forecast;
}

// 搭建底部view
- (void)setupBottomView
{
    CGFloat itemSizeWidth = self.weatherContentView.hcs_width / 5.0;
    // 设置布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemSizeWidth, self.weatherContentView.hcs_height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 1;
    
    // 指示器，cell间距，分页
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.weatherContentView.bounds collectionViewLayout:layout];
    _collectionView = collectionView;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.bounces = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    [self.weatherContentView addSubview:collectionView];
    
    // 注册cell

    [collectionView registerNib:[UINib nibWithNibName:@"HCSCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
}

#pragma mark - UICollectionViewDataSource
// 有多少个子控制器就有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dailyForecastItemArray.count;
}

// 只要有新的cell显示的时候才会调用
// 返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCSCollectionViewCell *cocell =  [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cocell.dailyAllForecastItem = self.dailyForecastItemArray[indexPath.row];
    
    return cocell;
}



@end
