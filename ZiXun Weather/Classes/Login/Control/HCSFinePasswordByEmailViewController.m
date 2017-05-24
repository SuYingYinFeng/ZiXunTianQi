//
//  HCSFinePasswordByEmailViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/13.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSFinePasswordByEmailViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "HCSBoolSpecialModeTool.h"

#define angle2Radio(angle) ((angle) * M_PI / 180.0)

@interface HCSFinePasswordByEmailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation HCSFinePasswordByEmailViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"找回密码";
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.emailTextField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.tipsLabel.hidden = YES;
    
    [self.commitButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"account_submit_normal"] forState:UIControlStateNormal];
    [self.commitButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"account_submit_press"] forState:UIControlStateHighlighted];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
    
    [_timer invalidate];
    
    _timer = nil;
}

- (IBAction)commitButtonClick:(id)sender {
    
    self.tipsLabel.hidden = YES;
    
    if (self.emailTextField.text.length == 0) {
        [self changeFindPasswordTipsLabelText:@"邮箱地址不能为空"];
        return;
    }else
    {
        BOOL isEmailAd = [HCSBoolSpecialModeTool boolSpecialModeToolValidateEmail:self.emailTextField.text];
        if (isEmailAd == NO) {
            [self changeFindPasswordTipsLabelText:@"必须填入邮箱地址"];
            return;
        }else
        {
            [SVProgressHUD showWithStatus:@"提交中"];
            [self addLoginTimer:@selector(getGetEmailAd)];
        }
    }
}

//改变ccountTipsLabelText
- (void)changeFindPasswordTipsLabelText:(NSString *)expectText
{
    self.tipsLabel.text = expectText;
    self.tipsLabel.hidden = NO;
    //帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(angle2Radio(-3)),@(angle2Radio(3)),@(angle2Radio(-3))];
    anim.repeatCount = 3;
    
    [self.tipsLabel.layer addAnimation:anim forKey:nil];
}

- (void)getGetEmailAd
{
    [SVProgressHUD showErrorWithStatus:@"该账号不存在"];
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





@end
