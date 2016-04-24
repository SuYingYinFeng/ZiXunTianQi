//
//  HCSAddCityViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/4/24.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSAddCityViewController.h"
#import "HCSResizeImageTool.h"

#define HCSSearchViewSize self.hcs_searchView.bounds.size
#define HCSColorWith(R,G,B) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:1]

static CGFloat const spaceViews = 10;
static CGFloat const buttonHeight = 30;
static NSInteger const maxCols = 3;
static CGFloat const LabelHeight = 30;

@interface HCSAddCityViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *hcs_searchView;

@property (weak, nonatomic) IBOutlet UIScrollView *hcs_scrollView;

@end

@implementation HCSAddCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *cityNameArray = @[@"北京",
                               @"上海",
                               @"广州",
                               @"深圳",
                               @"哈尔滨",
                               @"天津",
                               @"重庆",
                               @"沈阳",
                               @"大连",
                               @"长春",
                               @"郑州",
                               @"武汉",
                               @"长沙",
                               @"成都",
                               @"南京",
                               @"台北",
                               @"福州",
                               @"海口"];
    
    NSArray *resortNameArray = @[@"故宫博物馆",
                                 @"东方明珠塔",
                                 @"黄果树瀑布",
                                 @"黄山风景区",
                                 @"庐山风景区",
                                 @"清明上河园",
                                 @"布达拉宫",
                                 @"秦始皇陵",
                                 @"云冈石窟",
                                 @"镜泊湖",
                                 @"桃花源",
                                 @"黄鹤楼",
                                 @"丽江古城",
                                 @"乐山大佛",
                                 @"南京夫子庙"];
    
    NSInteger totalCityRow = (cityNameArray.count + 1) / maxCols;
    NSInteger totalResortRow = (resortNameArray.count + 1) / maxCols;
    
    //SearchView背景图片
    UIImage *hcs_image = [UIImage imageNamed:@"city_searchbar_background"];
    hcs_image = [hcs_image stretchableImageWithLeftCapWidth:hcs_image.size.width * 0.3 topCapHeight:hcs_image.size.height * 0.5];
    self.hcs_searchView.image = hcs_image;
    self.hcs_searchView.userInteractionEnabled = YES;
    
    //搜索内部TextField
    UITextField *hcs_TextField = [[UITextField alloc] initWithFrame:CGRectMake(HCSSearchViewSize.width * 0.05, 0, HCSSearchViewSize.width * 0.75, HCSSearchViewSize.height)];
    hcs_TextField.placeholder = @"搜索城市";
    [self.hcs_searchView addSubview:hcs_TextField];
    
    //热门ContentView
    UIView *hcs_View = [[UIView alloc] init];
    hcs_View.frame = CGRectMake(0, 0, self.hcs_scrollView.bounds.size.width,580);
    [self.hcs_scrollView addSubview:hcs_View];
    self.hcs_scrollView.contentSize = hcs_View.bounds.size;
    self.hcs_scrollView.bounces = NO;
    hcs_View.userInteractionEnabled = YES;
    
    //热门城市Label
    UILabel *hotCityLabel = [[UILabel alloc] init];
    hotCityLabel.frame = CGRectMake(0, spaceViews * 2, hcs_View.bounds.size.width, LabelHeight);
    hotCityLabel.text = @"热门城市";
    hotCityLabel.textAlignment = NSTextAlignmentCenter;
    hotCityLabel.font = [UIFont systemFontOfSize:15];
    hotCityLabel.textColor = [UIColor grayColor];
    [hcs_View addSubview:hotCityLabel];
    
    //热门城市View
    UIView *hotCityView = [[UIView alloc] init];
    CGFloat hotCityViewW = hcs_View.bounds.size.width * 0.8;
    CGFloat hotCityViewX = hcs_View.center.x - hotCityViewW * 0.5;
    CGFloat hotCityViewY = CGRectGetMaxY(hotCityLabel.frame);
    CGFloat hotCityViewH = (spaceViews + buttonHeight) * totalCityRow + spaceViews;
    hotCityView.frame = CGRectMake(hotCityViewX, hotCityViewY, hotCityViewW, hotCityViewH);
    hotCityView.backgroundColor = [UIColor whiteColor];
    [hcs_View addSubview:hotCityView];
    
    //热门城市按钮
    NSInteger totalCount = cityNameArray.count;
    CGFloat buttonW = (hotCityView.bounds.size.width - (maxCols + 1) * spaceViews) / maxCols;
    
    for (NSInteger i = 0 ; i < totalCount; i++) {
        
        NSInteger col = i % maxCols;
        CGFloat buttonX = (spaceViews + buttonW) * col + spaceViews;
        NSInteger row = i / maxCols;
        CGFloat buttonY = (spaceViews + buttonHeight) * row + spaceViews;
        
        UIButton *cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cityButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonHeight);
        cityButton.tag = i;
        
        NSString *cityNameStr = cityNameArray[i];
        
        [cityButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"add_city_btn_normal"] forState:UIControlStateNormal];
        [cityButton setTitle:cityNameStr forState:UIControlStateNormal];
        cityButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [cityButton setTitleColor:HCSColorWith(121, 126, 140) forState:UIControlStateNormal];
        
        [cityButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"add_city_btn_select"] forState:UIControlStateHighlighted];
        [cityButton setTitle:cityNameStr forState:UIControlStateHighlighted];
        [cityButton setTitleColor:HCSColorWith(63, 169, 226) forState:UIControlStateHighlighted];
        [hotCityView addSubview:cityButton];
        
    }
    
    //热门景点Label
    UILabel *hotResortLabel = [[UILabel alloc] init];
    CGFloat hotResortLabelY = CGRectGetMaxY(hotCityView.frame);
    hotResortLabel.frame = CGRectMake(0, spaceViews * 2 + hotResortLabelY, hcs_View.bounds.size.width, LabelHeight);
    hotResortLabel.text = @"热门景区";
    hotResortLabel.textAlignment = NSTextAlignmentCenter;
    hotResortLabel.font = [UIFont systemFontOfSize:15];
    hotResortLabel.textColor = [UIColor grayColor];
    [hcs_View addSubview:hotResortLabel];
    
    //热门景点View
    UIView *hotResortView = [[UIView alloc] init];
    CGFloat hotResortViewW = hcs_View.bounds.size.width * 0.8;
    CGFloat hotResortViewX = hcs_View.center.x - hotCityViewW * 0.5;
    CGFloat hotResortViewY = CGRectGetMaxY(hotResortLabel.frame);
   
    CGFloat hotResortViewH = (spaceViews + buttonHeight) * totalResortRow + spaceViews;
    hotResortView.frame = CGRectMake(hotResortViewX, hotResortViewY, hotResortViewW, hotResortViewH);
    hotResortView.backgroundColor = [UIColor whiteColor];
    [hcs_View addSubview:hotResortView];
    
    //热门景点按钮
    NSInteger totalResortCount = resortNameArray.count;
    CGFloat buttonResortW = (hotResortView.bounds.size.width - (maxCols + 1) * spaceViews) / maxCols;
    
    for (NSInteger i = 0 ; i < totalResortCount; i++) {
        
        NSInteger col = i % maxCols;
        CGFloat buttonResortX = (spaceViews + buttonResortW) * col + spaceViews;
        NSInteger row = i / maxCols;
        CGFloat buttonResortY = (spaceViews + buttonHeight) * row + spaceViews;
        
        UIButton *resortButton = [UIButton buttonWithType:UIButtonTypeCustom];
        resortButton.frame = CGRectMake(buttonResortX, buttonResortY, buttonResortW, buttonHeight);
        resortButton.tag = i + 100;
        
        NSString *resortNameStr = resortNameArray[i];
        
        [resortButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"add_city_btn_normal"] forState:UIControlStateNormal];
        [resortButton setTitle:resortNameStr forState:UIControlStateNormal];
        resortButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [resortButton setTitleColor:HCSColorWith(121, 126, 140) forState:UIControlStateNormal];
        
        [resortButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"add_city_btn_select"] forState:UIControlStateHighlighted];
        [resortButton setTitle:resortNameStr forState:UIControlStateHighlighted];
        [resortButton setTitleColor:HCSColorWith(63, 169, 226) forState:UIControlStateHighlighted];
        [hotResortView addSubview:resortButton];
        
    }
    

}



@end
