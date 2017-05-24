//
//  HCSNavigationController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/10.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSNavigationController.h"
#import "HCSResizeImageTool.h"

@interface HCSNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation HCSNavigationController

+ (void)load
{
    // 只想修改当前导航控制器下导航条，
    // 获取全局导航条
    
    // appearanceWhenContainedIn:获取某个类下面全局外观，获取XMGNavigationController所有导航条
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    // 设置导航条标题 变大变宽 => 导航条
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    navBar.titleTextAttributes = attr;
    
    // 设置导航条背景图片:一定要使用Default
    [navBar setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"NLArenaNavBar64"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    // 添加Pan,全屏
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
//    [self.view addGestureRecognizer:pan];
//    
//    // 不允许边缘手势触发
//    self.interactivePopGestureRecognizer.enabled = NO;
//    // 实现滑动返回功能
//    pan.delegate = self;
}

//#pragma mark - UIGestureRecognizerDelegate
//// 控制手势是否触发
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    return self.childViewControllers.count > 1;
//}



#pragma mark - 拦截系统Puch方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) {// 根控制器不需要设置返回按钮  // 非根控制器
        
        //设置返回按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"left_button_back_blue"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"left_button_back_blue_press"] forState:UIControlStateHighlighted];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        // 设置按钮文字颜色
        [backButton setTitleColor:HCSColorWith(24, 152, 221) forState:UIControlStateNormal];
        [backButton setTitleColor:HCSColorWith(17, 122, 177) forState:UIControlStateHighlighted];
   
        [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchDown];
        
        // 注意:一定要先计算按钮尺寸，再设置contentEdgeInsets
        [backButton sizeToFit];
        
        //设置contentEdgeInsets 目的：让按钮往左边挪动
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
        
        //要用自定义的button
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        //隐藏底部TabBar
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    
    // 注意。一定要记得调用super,
    [super pushViewController:viewController animated:animated];
    
}

- (void)backButtonClick
{
    [self popViewControllerAnimated:YES];
}

@end
