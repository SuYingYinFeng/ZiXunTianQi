//
//  HCSTabBarController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/7.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSTabBarController.h"
#import "HCSMineViewController.h"
#import "HCSNewsViewController.h"
#import "HCSWeatherViewController.h"
#import "UIImage+OriginalImage.h"
#import "HCSNavigationController.h"

@interface HCSTabBarController ()

//用于保存tabBarItem
@property (nonatomic,strong) NSMutableArray *tabBarItemArray;

@end

@implementation HCSTabBarController

+ (void)load
{
    // 获取全局的tabBarItem
    UITabBarItem *item = [UITabBarItem appearance];
    // 设置选中状态下tabBarButton
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    // 颜色
    attr[NSForegroundColorAttributeName] = [UIColor blackColor];
    // 设置选中状态的tabBarButton
    [item setTitleTextAttributes:attr forState:UIControlStateSelected];
    
    // 设置正常状态下tabBarButton
    NSMutableDictionary *attrNormal = [NSMutableDictionary dictionary];
    // 字体:设置tabBar上按钮字体，只能通过正常状态下
    attrNormal[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    // 设置正常状态的tabBarButton
    [item setTitleTextAttributes:attrNormal forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view endEditing:YES];
    
    // 1 添加所有的子控制器：有多少个按钮，就有多少个子控制器
    [self setUpAllchlidViewContrller];
//    // 2.设置tabBar上所有按钮的内容:由对应的子控制器的tabBarItem属性决定
    [self setUpAllTabBarButton];
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    bgView.alpha = 0.3;
    [self.tabBar insertSubview:bgView atIndex:0];
    
}

#pragma mark - 设置tabBar上所有按钮的内容
- (void)setUpAllTabBarButton
{
    //weather 天气
    UINavigationController *nav0 = self.childViewControllers[0];
    nav0.tabBarItem.title = @"天气";
    nav0.tabBarItem.image = [UIImage imageNamed:@"tabbar_weather_normal"];
    nav0.tabBarItem.selectedImage = [UIImage imageWithOriginalImageName:@"tabbar_weather_select"];
    //news  资讯
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"资讯";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabbar_live_normal"];
    
    nav1.tabBarItem.selectedImage = [UIImage imageWithOriginalImageName:@"tabbar_live_select"];
    
    //mine  我
    UINavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"我";
    nav2.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile_normal"];
    nav2.tabBarItem.selectedImage = [UIImage imageWithOriginalImageName:@"tabbar_profile_select"];
    
}

#pragma mark - 添加所有的子控制器
- (void)setUpAllchlidViewContrller
{
    //weather 天气
    HCSWeatherViewController *weatherVc = [[HCSWeatherViewController alloc] init];
    UINavigationController *navWeatherVc = [[UINavigationController alloc] initWithRootViewController:weatherVc];
    [self addChildViewController:navWeatherVc];
    
    //news  资讯
    HCSNewsViewController *newsVc = [[HCSNewsViewController alloc] init];
    HCSNavigationController *navNewsVc = [[HCSNavigationController alloc] initWithRootViewController:newsVc];
    [self addChildViewController:navNewsVc];

    //mine  我
    HCSMineViewController *mineVc = [[HCSMineViewController alloc] init];
    HCSNavigationController *navMineVc = [[HCSNavigationController alloc] initWithRootViewController:mineVc];
    [self addChildViewController:navMineVc];
    
}



@end
