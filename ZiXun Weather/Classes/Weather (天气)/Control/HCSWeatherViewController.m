//
//  HCSWeatherViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/7.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSWeatherViewController.h"
#import "UIBarButtonItem+Item.h"
#import "HCSWeatherCell.h"
#import "HCSAddCityViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "HCSWeatherTopView.h"
#import "HCSWeatherMiddleView.h"
#import "HCSWeatherExponentView.h"
#import "HCSCityItem.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "HCSExpontViewController.h"

typedef enum : NSUInteger {
    HCSWeatherLoadDataStatusFirstTime,
    HCSWeatherLoadDataStatusHeaderRefresh,
    HCSWeatherLoadDataStatusFooterRefresh,
} HCSWeatherLoadDataStatus;

static NSString * const Weather_ID = @"Weather_cell";

@interface HCSWeatherViewController ()

@property (nonatomic, strong)AFHTTPSessionManager *manager;
@property (nonatomic,strong) NSArray *cityArray;
@property (nonatomic,strong) NSArray *cityItemArray;
@property (nonatomic,weak) HCSWeatherTopView *topCellView;
@property (nonatomic,weak) HCSWeatherMiddleView *middleCellView;
@property (nonatomic,weak) HCSWeatherExponentView *exponentCellView;
@property (nonatomic,assign) NSUInteger index;
@property (nonatomic,assign) HCSWeatherLoadDataStatus weatherLoadDataStatus;

@end

@implementation HCSWeatherViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    self.cityArray = [HCSSaveTool objectForKey:@"cityItem"];
    
    //设置整个视图的背景图片
    self.view.layer.contents = (id)[UIImage imageNamed:@"bg_na.jpg"].CGImage;
    
    [self setUpNavigationItem];
    
//    [self getNetWorkData];
//    [self test];
    

    [self loadTableView];

    // 添加下拉刷新
    [self setupheaderRefreshView];
    
    //监听通知-tip详情点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observerGetTheNotification:) name:@"expontCollection" object:nil];

    
}

// 添加下拉刷新控件
- (void)setupheaderRefreshView
{
    // 创建下拉刷新控件
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(beginHeaderRefreshView)];
    
    // 控制下拉刷新显示,最开始位置透明度0，完全透明
    header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_header = header;
    
    // 使用MJRefresh一定要记得在请求成功的时候，结束刷新
    [header beginRefreshing];
    
}

//开始下拉刷新
- (void)beginHeaderRefreshView
{
    //请求数据
    [self getNetWorkData];
    
}

- (void)test
{

    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guangzhou.plist" ofType:nil]];
    
    NSArray *dictArray = dict[@"HeWeather data service 3.0"];
    
    _cityItemArray = [HCSCityItem mj_objectArrayWithKeyValuesArray:dictArray];
    
    
}

- (void)getNetWorkData
{
    _manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"cityid"] = [_cityArray objectAtIndex:2];
    parameters[@"key"] = @"d6b63605b8b24f58a737a53171d5304c";
    

    [_manager GET:@"https://api.heweather.com/x3/weather" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
    NSArray *dictArray = responseObject[@"HeWeather data service 3.0"];
    
    _cityItemArray = [HCSCityItem mj_objectArrayWithKeyValuesArray:dictArray];
        
    // 请求完成
    [self.tableView.mj_header endRefreshing];
    
    [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"%@",error);
            [self.tableView.mj_header endRefreshing];
            [self getDataFailure];
        }
    }];

}

- (void)getDataFailure
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请求数据失败，请检查网络" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
    [alertView show];
    
}



- (void)setUpNavigationItem
{
    //标题View
    self.navigationItem.titleView = [self setUpTitleView];
    
    //导航栏背景图片
    [self.navigationController.navigationBar setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"sun_carrule_bg"] forBarMetrics:UIBarMetricsDefault];
    
    //左边UIBarButtonItem
    UIBarButtonItem *itemLeft = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"profile_homepage_icon"] HighlightedImage:[UIImage imageNamed:@"profile_homepage_icon"] target:self action:@selector(selectCity)];
    self.navigationItem.leftBarButtonItem = itemLeft;
    
    //右边UIBarButtonItem
    UIBarButtonItem *itemright = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"ws_home_morebtn"] HighlightedImage:[UIImage imageNamed:@"ws_home_morebtn_press"] target:self action:@selector(Random)];
    self.navigationItem.rightBarButtonItem = itemright;
    

}

- (UIView *)setUpTitleView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    UILabel *cityName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 28)];
    cityName.text = [self.cityArray objectAtIndex:0];
    cityName.font = [UIFont systemFontOfSize:18];
    cityName.textColor = HCSColorWith(239, 239, 244);
    cityName.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:cityName];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 28, 100, 10)];
    dateLabel.text = [self getTitleViewLabelTodayText];
    dateLabel.font = [UIFont systemFontOfSize:12];
    dateLabel.textColor = HCSColorWith(190, 190, 190);
    dateLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:dateLabel];
    
    return titleView;
}

- (NSString *)getTitleViewLabelTodayText
{
    // 获取日历对象
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    // 获取当前日期组件
    NSDateComponents *cmpCurrent = [currentCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    
    NSArray *array = [NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:cmpCurrent];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekday = [weekdayComponents weekday];
    
    NSString *weekDayStr = [array objectAtIndex:weekday - 1];
    
    return [NSString stringWithFormat:@"%ld月%ld日 %@",cmpCurrent.month,cmpCurrent.day,weekDayStr];
}

- (void)loadTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HCSWeatherCell" bundle:nil] forCellReuseIdentifier:Weather_ID];
}

- (void)selectCity
{
    HCSAddCityViewController *addVc = [[HCSAddCityViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = addVc;


}

- (void)Random
{
    HCSFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    HCSWeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:Weather_ID forIndexPath:indexPath];

    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (_cityItemArray.count) {
        
        if (indexPath.row == 0) {
            HCSWeatherTopView *topCellView = [HCSWeatherTopView loadTopCellView];
            topCellView.frame = CGRectMake(0, 0, 375, 375);
            topCellView.cityItem = [_cityItemArray firstObject];
            [cell.contentView addSubview:topCellView];
            _topCellView = topCellView;
        }else if (indexPath.row == 1)
        {
            HCSWeatherMiddleView *middleCellView = [HCSWeatherMiddleView loadMiddleCellView];
            middleCellView.frame = CGRectMake(0, 0, 375, 375);
            middleCellView.cityItem = [_cityItemArray firstObject];
            [cell.contentView addSubview:middleCellView];
            _middleCellView = middleCellView;
            
        }else
        {
            HCSWeatherExponentView *exponentCellView = [HCSWeatherExponentView loadExponentCellView];
            exponentCellView.frame = CGRectMake(0, 0, 375, 375);
            exponentCellView.cityItem = [_cityItemArray firstObject];
            [cell.contentView addSubview:exponentCellView];
            _exponentCellView = exponentCellView;
        }
    }
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 375;
 
}


//监听到通知调用
- (void)observerGetTheNotification:(NSNotification *)note
{
    HCSExpontViewController *expontVc = [[HCSExpontViewController alloc] init];

    expontVc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:expontVc animated:YES completion:nil];
}
- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
