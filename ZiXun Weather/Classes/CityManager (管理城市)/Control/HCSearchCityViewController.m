//
//  HCSearchCityViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/4/24.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSearchCityViewController.h"
#import "HCSResizeImageTool.h"
#import "HCSCityResultViewController.h"
#import "HCSTipsViewController.h"

#define HCSSearchView_Size self.searchView.bounds.size
@interface HCSearchCityViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *searchView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic,weak) UITextField *hcsTextField;

@end

@implementation HCSearchCityViewController

//addtopViewContent
- (void)addtopViewContent
{
    //SearchView背景图片
    UIImage *hcs_image = [HCSResizeImageTool HCSResizeImageWithImageName:@"city_searchbar_background_active"];
    self.searchView.image = hcs_image;
    self.searchView.userInteractionEnabled = YES;
    
    //搜索内部TextField
    UITextField *hcsTextField = [[UITextField alloc] initWithFrame:CGRectMake(HCSSearchView_Size.width * 0.05, 0, HCSSearchView_Size.width * 0.95 , HCSSearchView_Size.height)];
    hcsTextField.placeholder = @"搜索城市";
    [hcsTextField becomeFirstResponder];
    hcsTextField.delegate = self;
    [self.searchView addSubview:hcsTextField];
    self.hcsTextField = hcsTextField;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //addtopViewContent
    [self addtopViewContent];

    [self setUpChildViewController];

    NSLog(@"self.childViewControllers[0]--%@******self.childViewControllers[1]--%@",self.childViewControllers[0],self.childViewControllers[1]);
    
    [self setUpSearchResultView:nil];
    
}

//添加结果View
- (void)setUpSearchResultView:(NSString *)string
{
    if (string == nil) {
        NSLog(@"string == nil");
        [self setUpResultView];
    }else
    {
        NSLog(@"%@",string);
    }

}

- (void)setUpResultView
{
    for (UIView *childView in self.contentView.subviews) {
        [childView removeFromSuperview];
    }
    
    UIViewController *hcsVc = self.childViewControllers[0];
    CGFloat hcsViewW = self.contentView.hcs_width * 0.4;
    CGFloat hcsViewX = self.contentView.hcs_width * 0.5 - hcsViewW * 0.5;
    hcsVc.view.frame = CGRectMake(hcsViewX, 30, hcsViewW, hcsViewW);
    [self.contentView addSubview:hcsVc.view];
}

// 添加所有的子控制器
- (void)setUpChildViewController
{
    HCSTipsViewController *tipsVc = [[HCSTipsViewController alloc] init];
    tipsVc.title = @"提示界面";
    [self addChildViewController:tipsVc];
    
    HCSCityResultViewController *cityResultVc = [[HCSCityResultViewController alloc] init];
    cityResultVc.title = @"城市搜索结果";
    [self addChildViewController:cityResultVc];
 
}

- (IBAction)cancelButtonClick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dshjf");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"%zd--%zd",range.location,range.length);
    NSLog(@"%@",string);
    [self setUpSearchResultView:string];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}



@end
