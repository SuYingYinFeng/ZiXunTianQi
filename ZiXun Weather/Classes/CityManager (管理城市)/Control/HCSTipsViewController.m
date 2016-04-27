//
//  HCSTipsViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/4/26.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSTipsViewController.h"

@interface HCSTipsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tipsPhotoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tipsTextImageView;

@end

@implementation HCSTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tipsPhotoImageView.image = [UIImage imageNamed:@"search_city_earth"];
    self.tipsTextImageView.image = [UIImage imageNamed:@"search_city_text_cn"];
    
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
