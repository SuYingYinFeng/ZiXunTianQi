//
//  HCSBottomView.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/15.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSBottomView.h"
#import "HCSNewsItem.h"


@interface HCSBottomView ()

@property (weak, nonatomic) IBOutlet UILabel *srcLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation HCSBottomView

- (IBAction)detailButtonClick:(id)sender {
    if (self.bottomNewsItem.url) {
        
        NSString *urlStr = _bottomNewsItem.url;
        
        // 创建通知
        NSNotification *note = [NSNotification notificationWithName:@"NewDetailButton" object:nil userInfo:@{@"NewUrl" : urlStr}];
        // 发布通知
        [[NSNotificationCenter defaultCenter] postNotification:note];
        
    }
    
}


+ (instancetype)loadBottomViewForCell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    //拉伸登录按钮背景图片
    [self.detailButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"account_submit_normal"] forState:UIControlStateNormal];
    [self.detailButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"account_submit_press"] forState:UIControlStateHighlighted];
}

- (void)setBottomNewsItem:(HCSNewsItem *)bottomNewsItem
{
    _bottomNewsItem = bottomNewsItem;
    
    _srcLabel.text = [NSString stringWithFormat:@"新闻来源:%@",bottomNewsItem.src];
    
    _timeLabel.text = [NSString stringWithFormat:@"发布时间:%@",bottomNewsItem.pdate_src];
    
}


@end
