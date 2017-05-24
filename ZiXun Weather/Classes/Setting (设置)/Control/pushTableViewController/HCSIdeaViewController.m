//
//  HCSIdeaViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/14.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSIdeaViewController.h"
#import <MBProgressHUD+XMG.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface HCSIdeaViewController ()
@property (weak, nonatomic) IBOutlet UITextView *ideaTextView;
@property (weak, nonatomic) IBOutlet UIButton *ideaCommitButton;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation HCSIdeaViewController
- (IBAction)buttonClick:(id)sender {
    if (self.ideaTextView.text == nil) {
        [MBProgressHUD showError:@"不能为空"];
    }else
    {
        [SVProgressHUD showWithStatus:@"提交中"];
        
        [self addLoginTimer:@selector(getGetEmailAd)];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"意见反馈";
    
    [self.ideaTextView becomeFirstResponder];
}

- (void)getGetEmailAd
{
    [SVProgressHUD showSuccessWithStatus:@"提交成功,谢谢您的意见和建议"];
    [_timer invalidate];
    _timer = nil;
    
    [self addLoginTimer:@selector(DoneGetEmailAd)];
}

- (void)DoneGetEmailAd
{
    [SVProgressHUD dismiss];
    [_timer invalidate];
    _timer = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - addTimer
- (void)addLoginTimer:(SEL)selector
{
    _timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:selector userInfo:nil repeats:NO];
    // 注意：要加入到运行循环当中
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    //拉伸登录按钮背景图片
    [self.ideaCommitButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"account_login_normal"] forState:UIControlStateNormal];
    [self.ideaCommitButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"account_login_press"] forState:UIControlStateHighlighted];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
