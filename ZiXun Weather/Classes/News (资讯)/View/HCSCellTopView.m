//
//  HCSCellTopView.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/15.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSCellTopView.h"
#import "HCSNewsItem.h"

@interface HCSCellTopView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation HCSCellTopView

- (IBAction)mornButtonClick:(id)sender {
    
    
}


#pragma mark - 从xib加载topView
+ (instancetype)loadTopViewForCell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

#pragma mark - 从xib加载的时候就会调用
- (void)awakeFromNib
{
    // autoresizingMask:iOS6
    // 默认一个xib控件，都会自动去添加autoresizingMask
    // autoresizingMask:会把xib的控件自动拉伸，导致控件和xib尺寸不一样.
    self.autoresizingMask = UIViewAutoresizingNone;
}

#pragma mark - 重写TopViewThemeItem setter
- (void)setTopViewNewsItem:(HCSNewsItem *)topViewNewsItem
{
    _topViewNewsItem = topViewNewsItem;
    
    //新闻标题
    _titleLabel.text = topViewNewsItem.title;
    // 新闻简要
    NSString *str = topViewNewsItem.content;
    str = [str stringByReplacingOccurrencesOfString:@"</em>" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"<em>" withString:@""];
    
    _contentLabel.text = [NSString stringWithFormat:@"%@        %@",str,topViewNewsItem.pdate];
    
    
}


@end
