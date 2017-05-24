//
//  HCSNewsViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/7.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSNewsViewController.h"
#import "HCSLocalViewController.h"
#import "HCSHotNewsViewController.h"


@interface HCSNewsViewController ()

@end

@implementation HCSNewsViewController


#pragma mark
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"新闻资讯";
    
    // 添加所有的子控制器
    [self setUpAllTheChildViewController];
    
}

#pragma mark - 添加所有的子控制器
- (void)setUpAllTheChildViewController
{
 
    // 热点新闻
    HCSHotNewsViewController *hotNewsVc = [[HCSHotNewsViewController alloc] init];
    hotNewsVc.title = @"热点新闻";
    [self addChildViewController:hotNewsVc];
    
    // 本省新闻
    HCSLocalViewController *localVc = [[HCSLocalViewController alloc] init];
    NSString *titleText = [NSString stringWithFormat:@"%@新闻",[[HCSSaveTool objectForKey:@"cityItem"] objectAtIndex:3]];
    localVc.title = titleText;
    [self addChildViewController:localVc];
}


@end
