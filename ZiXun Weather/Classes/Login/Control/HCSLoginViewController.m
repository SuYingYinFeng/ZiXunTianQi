//
//  HCSLoginViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/13.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSLoginViewController.h"
#import "HCSResizeImageTool.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "HCSBoolSpecialModeTool.h"
#import "HCSMineItem.h"
#import "HCSFindPasswordViewController.h"
#import "HCSFinePasswordByEmailViewController.h"
#import "HCSPhoneNumberFastLoginViewController.h"

#define angle2Radio(angle) ((angle) * M_PI / 180.0)

@interface HCSLoginViewController ()<UIAlertViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *accountTipsLabel;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation HCSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置密码输入框代理
    self.passwordTextField.delegate = self;
    
    self.accountTextField.placeholderColor = [UIColor lightGrayColor];
    self.passwordTextField.placeholderColor = [UIColor lightGrayColor];
  
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    //拉伸登录按钮背景图片
    [self.loginButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"account_login_normal"] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"account_login_press"] forState:UIControlStateHighlighted];
    
    self.accountTipsLabel.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //去掉提示框
    [SVProgressHUD dismiss];
    
    // 注意:如果使用此方法停止倒计时，那么想继续使用的话，要重新实例化_timer
    [_timer invalidate];
    
    _timer = nil;
    
    self.accountTipsLabel.hidden = YES;
    
    [self.view endEditing:YES];
}

#pragma mark - buttonClickToDo
- (IBAction)backButtonClick:(UIButton *)sender {
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)forgetPasswordButtonClick:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请选择一种找回密码的方式" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"通过手机号码找回",@"通过邮箱找回", nil];
    [alertView show];
    
}


- (IBAction)loginButtonClick:(UIButton *)sender {
    
    //判断账号输入框逻辑
    if (self.accountTextField.text.length == 0) {
        [self changeAccountTipsLabelText:@"账号不能为空"];
        return;
    }else
    {
        BOOL isEmailAddress = [HCSBoolSpecialModeTool boolSpecialModeToolValidateEmail:self.accountTextField.text];
        BOOL isPhoneNumber = [HCSBoolSpecialModeTool boolSpecialModeToolValidateMobile:self.accountTextField.text];
        
        if ((isEmailAddress||isPhoneNumber) == NO) { //不是邮箱地址或手机号
            [self changeAccountTipsLabelText:@"账号必须为邮箱地址或手机号"];
            return;
        }
    }
    
    //判断密码输入框逻辑
    if (self.passwordTextField.text.length == 0) {
        [self changeAccountTipsLabelText:@"密码不能为空"];
        return;
    }
  
    [HCSSaveTool setObject:self.accountTextField.text forKey:accountNameKey];
    
    [SVProgressHUD showWithStatus:@"登录中"];
    
    [self addLoginTimer];
    
}

//改变ccountTipsLabelText
- (void)changeAccountTipsLabelText:(NSString *)expectText
{
    self.accountTipsLabel.text = expectText;
    self.accountTipsLabel.hidden = NO;
    //帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(angle2Radio(-3)),@(angle2Radio(3)),@(angle2Radio(-3))];
    anim.repeatCount = 3;
    
    [self.accountTipsLabel.layer addAnimation:anim forKey:nil];
}

- (IBAction)phoneNumberLoginClick:(id)sender {
   
    HCSPhoneNumberFastLoginViewController *phoneNumberFastLoginVc = [[HCSPhoneNumberFastLoginViewController alloc] init];
    [self.navigationController pushViewController:phoneNumberFastLoginVc animated:YES];
    
}

- (IBAction)weiboClick:(id)sender {
    [SVProgressHUD showWithStatus:@"微博账号登录中"];
    [HCSSaveTool setObject:@"微博用户" forKey:accountNameKey];
    [self addLoginTimer];
}

- (IBAction)qqClick:(id)sender {
    [SVProgressHUD showWithStatus:@"QQ账号登录中"];
    [HCSSaveTool setObject:@"QQ用户" forKey:accountNameKey];
    [self addLoginTimer];
}

- (IBAction)weixinClick:(id)sender {
    [SVProgressHUD showWithStatus:@"微信账号登录中"];
    [HCSSaveTool setObject:@"微信用户" forKey:accountNameKey];
    [self addLoginTimer];
}

#pragma mark - addTimer
- (void)addLoginTimer
{
    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(backButtonClick:) userInfo:nil repeats:NO];
    // 注意：要加入到运行循环当中
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

}

#pragma mark - 密码输入框代理实现->控制密码长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location <= 15) {
       return YES;
    }
    return NO;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        HCSFindPasswordViewController *findPasswordVc = [[HCSFindPasswordViewController alloc] init];
   
        [self.navigationController pushViewController:findPasswordVc animated:YES];
    }else if (buttonIndex == 2)
    {
        HCSFinePasswordByEmailViewController *findPasswordByEmailVc = [[HCSFinePasswordByEmailViewController alloc] init];
        [self.navigationController pushViewController:findPasswordByEmailVc animated:YES];
    }
}

@end
