//
//  HCSearchCityViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/4/24.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSearchCityViewController.h"
#import "HCSResizeImageTool.h"

#define HCSSearchView_Size self.searchView.bounds.size
@interface HCSearchCityViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *searchView;

@end

@implementation HCSearchCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //SearchView背景图片
    UIImage *hcs_image = [HCSResizeImageTool HCSResizeImageWithImageName:@"city_searchbar_background_active"];
    self.searchView.image = hcs_image;
    self.searchView.userInteractionEnabled = YES;
    
    //搜索内部TextField
    UITextField *hcs_textField = [[UITextField alloc] initWithFrame:CGRectMake(HCSSearchView_Size.width * 0.05, 0, HCSSearchView_Size.width * 0.95 , HCSSearchView_Size.height)];
    hcs_textField.placeholder = @"搜索城市";
    [self.searchView addSubview:hcs_textField];
    [hcs_textField becomeFirstResponder];

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dshjf");
    }];
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
