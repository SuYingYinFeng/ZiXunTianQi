//
//  HCSPhoneNumberFastLoginViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/13.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSPhoneNumberFastLoginViewController.h"
#import "HCSBoolSpecialModeTool.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define angle2Radio(angle) ((angle) * M_PI / 180.0)

@interface HCSPhoneNumberFastLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberFastLoginTextField;
@property (weak, nonatomic) IBOutlet UITextField *checkNumberTextField;
@property (weak, nonatomic) IBOutlet UILabel *phoneFastLoginTipsLabel;
@property (weak, nonatomic) IBOutlet UIButton *fastLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *getCheckNumberButton;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation HCSPhoneNumberFastLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"手机号快速登录";
    
    self.phoneNumberFastLoginTextField.delegate = self;
    
    self.checkNumberTextField.delegate = self;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.phoneNumberFastLoginTextField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.phoneFastLoginTipsLabel.hidden = YES;
    
    self.getCheckNumberButton.hidden = YES;
    
    [self.fastLoginButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"account_submit_normal"] forState:UIControlStateNormal];
    [self.fastLoginButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"account_submit_press"] forState:UIControlStateHighlighted];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
    
    [_timer invalidate];
    
    _timer = nil;
}

- (IBAction)getCheckNumberButtonClick:(id)sender {
    
    [SVProgressHUD showWithStatus:@"获取中"];
    
    [self addLoginTimer:@selector(getGetCheckNumber)];
    
}


- (IBAction)fastLoginButtonClick:(id)sender {
    
    self.phoneFastLoginTipsLabel.hidden = YES;
    
    //判断账号输入框逻辑
    if (self.phoneNumberFastLoginTextField.text.length == 0) {
        [self changePhoneFastLoginTipsLabelText:@"手机号不能为空"];
        return;
    }else
    {
        BOOL isPhoneNumber = [HCSBoolSpecialModeTool boolSpecialModeToolValidateMobile:self.phoneNumberFastLoginTextField.text];
        if (isPhoneNumber == NO) { //不是手机号
            [self changePhoneFastLoginTipsLabelText:@"必须为手机号"];
            return;
        }
    }
    
    //判断密码输入框逻辑
    if (self.checkNumberTextField.text.length == 0) {
        [self changePhoneFastLoginTipsLabelText:@"验证码不能为空"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"登录中"];
    
    [self addLoginTimer:@selector(login)];
    
}



//改变ccountTipsLabelText
- (void)changePhoneFastLoginTipsLabelText:(NSString *)expectText
{
    self.phoneFastLoginTipsLabel.text = expectText;
    self.phoneFastLoginTipsLabel.hidden = NO;
    //帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(angle2Radio(-3)),@(angle2Radio(3)),@(angle2Radio(-3))];
    anim.repeatCount = 3;
    
    [self.phoneFastLoginTipsLabel.layer addAnimation:anim forKey:nil];
}

- (void)getGetCheckNumber
{
    [SVProgressHUD showErrorWithStatus:@"未知错误"];
    [_timer invalidate];
    _timer = nil;
    
    [self addLoginTimer:@selector(DoneGetEmailAd)];
}

- (void)login
{
    [SVProgressHUD showErrorWithStatus:@"验证码不正确"];
    [_timer invalidate];
    _timer = nil;
    
    [self addLoginTimer:@selector(DoneGetEmailAd)];
}


- (void)DoneGetEmailAd
{
    [SVProgressHUD dismiss];
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - addTimer
- (void)addLoginTimer:(SEL)selector
{
    _timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:selector userInfo:nil repeats:NO];
    // 注意：要加入到运行循环当中
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneNumberFastLoginTextField) {
        if (range.location == 10 && range.length == 0) {
            NSString *curPhoneStr = [NSString stringWithFormat:@"%@%@",self.phoneNumberFastLoginTextField.text,string];
            BOOL isPhoneNumber = [HCSBoolSpecialModeTool boolSpecialModeToolValidateMobile:curPhoneStr];
            if (isPhoneNumber == YES) {
                self.getCheckNumberButton.hidden = NO;
            }
        }else if (range.location == 11 && range.length == 0)
        {
            BOOL isPhoneNumber = [HCSBoolSpecialModeTool boolSpecialModeToolValidateMobile:self.phoneNumberFastLoginTextField.text];
            if (isPhoneNumber == YES) {
                self.getCheckNumberButton.hidden = NO;
            }
        }else
        {
            self.getCheckNumberButton.hidden = YES;
        }
        
        if (range.location <= 10) {
            return YES;
        }
        
        return NO;
    }else
    {
        if (range.location <= 5) {
            return YES;
        }
        
        return NO;
        
    }
 
}



@end
