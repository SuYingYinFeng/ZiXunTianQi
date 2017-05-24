//
//  HCSExpontViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/6/4.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSExpontViewController.h"

#import "HCSCityItem.h"
#import "HCSNowItem.h"
#import "HCSCondNowItem.h"
#import "HCSWindNowItem.h"



@interface HCSExpontViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *miaoshu;
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UILabel *tmp;
@property (weak, nonatomic) IBOutlet UILabel *weatherStatus;
@property (weak, nonatomic) IBOutlet UILabel *wind;
@property (weak, nonatomic) IBOutlet UILabel *xiangqing;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation HCSExpontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *cityArray = [HCSSaveTool objectForKey:@"cityItem"];
    
    self.titleLabel.text = @"指数";
    
    self.cityName.text = [NSString stringWithFormat:@"%@",[cityArray objectAtIndex:0]];
    
//    self.tmp.text = []
    
}
- (IBAction)backButtonClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
