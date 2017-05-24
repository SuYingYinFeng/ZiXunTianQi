//
//  HCSNewsCell.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/15.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSNewsCell.h"
#import "HCSNewsViewModel.h"
#import "HCSNewsItem.h"

#import "HCSCellTopView.h"
#import "HCSPictureView.h"
#import "HCSBottomView.h"

@interface HCSNewsCell ()

@property (nonatomic,weak) HCSCellTopView *topView;
@property (nonatomic,weak) HCSPictureView *pictureView;
@property (nonatomic,weak) HCSBottomView *bottomView;

@end

@implementation HCSNewsCell

#pragma mark - 重写cell的frame设置
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    frame.origin.y += 10;
    [super setFrame:frame];
}

#pragma mark - 从xib加载
- (void)awakeFromNib {
    // Initialization code
}

- (void)setNewsViewModel:(HCSNewsViewModel *)newsViewModel
{
    _newsViewModel = newsViewModel;
    
    // 设置topView的frame
    _topView.frame = newsViewModel.topViewFrame;
    // 设置topView内容
    _topView.topViewNewsItem = newsViewModel.newsItem;
    
    // 注意:要判断是否显示中间图片view，一定要记得隐藏，因为cell是循环利用

    if (![newsViewModel.newsItem.img isEqual:@""]) {
        
        _pictureView.hidden = NO;
        
        _pictureView.frame = newsViewModel.middleViewFrame;
        _pictureView.pictureViewNewsItem = newsViewModel.newsItem;
        
    }else
    {
        _pictureView.hidden = YES;
    }
    
    
    _bottomView.frame = newsViewModel.bottomViewFrame;
    _bottomView.bottomNewsItem = newsViewModel.newsItem;
    
}

#pragma mark - 只要一个控件调用Init方法创建，底层就会调用initWithFrame
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        HCSFunc;
    }
    return self;
}

#pragma mark - 通过代码初始化cell就会调用这个
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    // cell里面子控件是固定死，使用xib
    // cell里面子控件高度，不需要xib管理，根据好内容计算出子控件高度
    // 一个控件从xib加载，最终要去确定它的位置
    // 让顶部view展示内容 -> 请求数据
    // 全部子控件一起加载
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 不要cell选中样式,注意：只是选中cell没有效果，但是cell还是可以选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 设置cell背景图片
        self.backgroundView = [[UIImageView alloc] initWithImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"mainCellBackground"]];
        
        // 1.添加顶部view
        HCSCellTopView *topView = [HCSCellTopView loadTopViewForCell];
        [self.contentView addSubview:topView];
        _topView = topView;
        
        // 2. 添加图片view
        HCSPictureView *pictureView = [HCSPictureView loadPictureViewForCell];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    
        // 3.底部view
        HCSBottomView *bottomView = [HCSBottomView loadBottomViewForCell];
        [self.contentView addSubview:bottomView];
        _bottomView = bottomView;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
