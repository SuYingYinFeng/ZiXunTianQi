//
//  HCSFindPasswordViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/13.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSFindPasswordViewController.h"
#import "HCSBoolSpecialModeTool.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "HCSFinePasswordByEmailViewController.h"

#define angle2Radio(angle) ((angle) * M_PI / 180.0)

@interface HCSFindPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *getCheckNumberButton;
@property (weak, nonatomic) IBOutlet UILabel *findPasswordTipsLabel;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation HCSFindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"找回密码";
    
    self.phoneNumberTextField.placeholderColor = [UIColor lightGrayColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.phoneNumberTextField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.findPasswordTipsLabel.hidden = YES;
    
    [self.getCheckNumberButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"account_submit_normal"] forState:UIControlStateNormal];
    [self.getCheckNumberButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"account_submit_press"] forState:UIControlStateHighlighted];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
    
    [_timer invalidate];
    
    _timer = nil;
}


#pragma mark - buttonClick
- (IBAction)useEmailButtonClick:(id)sender {
    HCSFinePasswordByEmailViewController *finePasswordByEmailViewController = [[HCSFinePasswordByEmailViewController alloc] init];
    [self.navigationController pushViewController:finePasswordByEmailViewController animated:YES];
}

- (IBAction)getCheckNumberButtonClick:(id)sender {
    
    self.findPasswordTipsLabel.hidden = YES;
    
    if (self.phoneNumberTextField.text.length == 0) {
        [self changeFindPasswordTipsLabelText:@"电话号码不能为空"];
        return;
    }else
    {
        BOOL isPhoneNumber = [HCSBoolSpecialModeTool boolSpecialModeToolValidateMobile:self.phoneNumberTextField.text];
        if (isPhoneNumber == NO) {
            [self changeFindPasswordTipsLabelText:@"必须填入电话号码"];
            return;
        }else
        {
            [SVProgressHUD showWithStatus:@"获取中"];
            [self addLoginTimer:@selector(getGetCheckNumber)];
        }
    }

}

//改变ccountTipsLabelText
- (void)changeFindPasswordTipsLabelText:(NSString *)expectText
{
    self.findPasswordTipsLabel.text = expectText;
    self.findPasswordTipsLabel.hidden = NO;
    //帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(angle2Radio(-3)),@(angle2Radio(3)),@(angle2Radio(-3))];
    anim.repeatCount = 3;
    
    [self.findPasswordTipsLabel.layer addAnimation:anim forKey:nil];
}

- (void)getGetCheckNumber
{
    [SVProgressHUD showErrorWithStatus:@"该账号不存在"];
    [_timer invalidate];
    _timer = nil;
    
    [self addLoginTimer:@selector(DoneGetCheckNumber)];
}

- (void)DoneGetCheckNumber
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
