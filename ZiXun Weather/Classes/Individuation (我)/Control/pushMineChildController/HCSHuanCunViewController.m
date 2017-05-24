//
//  HCSHuanCunViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/6/4.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSHuanCunViewController.h"
#import <DACircularProgress/DALabeledCircularProgressView.h>
#import "HCSFileManager.h"

@interface HCSHuanCunViewController ()

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressHuanCunView;

@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@end

@implementation HCSHuanCunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    
    _progressHuanCunView.roundedCorners = 10;
    
    _progressHuanCunView.progressLabel.textColor = [UIColor whiteColor];
    CGFloat progress = 0.0;
    _progressHuanCunView.progress = progress;
    _progressHuanCunView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress * 100];


    _tipsLabel.text = [self getSizeString];

}

- (IBAction)clearButtonClick:(id)sender {
    
    _clearButton.enabled = NO;
    [UIView animateWithDuration:3.0 animations:^{
        CGFloat progress = 1.0;
        _progressHuanCunView.progress = progress;
        _progressHuanCunView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress * 100];
        // 清空缓存
        // 获取Cache文件夹 路径
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];

        [HCSFileManager removeDirectoryPath:cachePath];
    } completion:^(BOOL finished) {
        _clearButton.enabled = YES;
        _tipsLabel.text = @"清除完成";
    }];
    

    
}

#pragma mark - 获取尺寸字符串
- (NSString *)getSizeString
{
    // 获取Cache文件夹 路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    // 获取缓存尺寸
    NSInteger fileSize = [HCSFileManager getSizeOfDirectoryPath:cachePath];
    // MB KB B 手机中 1MB = 1000KB = 1000 * 1000 B
    NSString *sizeString = @"已使用";
    if (fileSize > 1000 * 1000) {
        CGFloat sizeMB = fileSize / 1000.0 / 1000.0;
        sizeString = [NSString stringWithFormat:@"%@%.2fMB",sizeString,sizeMB];
    }else if (fileSize > 1000)
    {
        CGFloat sizeKB = fileSize / 1000.0;
        sizeString = [NSString stringWithFormat:@"%@%.2fKB",sizeString,sizeKB];
    }else if (fileSize > 0)
    {
        sizeString = [NSString stringWithFormat:@"%@%ldB",sizeString,fileSize];
    }else
    {
        sizeString = @"很干净，无需清理";
    }
    
    return sizeString;
    
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
