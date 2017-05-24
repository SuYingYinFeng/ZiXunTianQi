//
//  HCSExponentContentViewCell.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/26.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSExponentContentViewCell.h"

#import "HCScomfSuggestionItem.h"
#import "HCSCwSuggestion.h"
#import "HCSDrsgSuggestion.h"
#import "HCSFlusuggestion.h"
#import "HCSSportsuggestion.h"
#import "HCSTravsuggestion.h"
#import "HCSUvsuggestion.h"

@interface HCSExponentContentViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *exponentImageView;
@property (weak, nonatomic) IBOutlet UIImageView *expoentCellBackgroudImageView;
@property (weak, nonatomic) IBOutlet UILabel *exponentStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *exponentTitleLabel;

@end

@implementation HCSExponentContentViewCell

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    self.expoentCellBackgroudImageView.image = [HCSResizeImageTool HCSResizeImageWithImageName:@"sun_carrule_bg"];
}

- (void)setComfSuggestionItem:(HCScomfSuggestionItem *)comfSuggestionItem
{
    _comfSuggestionItem = comfSuggestionItem;
    
    _exponentImageView.image = [UIImage imageNamed:@"info_3"];
    _exponentStatusLabel.text = comfSuggestionItem.brf;
    _exponentTitleLabel.text = @"舒适指数";
    
}

- (void)setCwSuggestionItem:(HCSCwSuggestion *)cwSuggestionItem
{
    _cwSuggestionItem = cwSuggestionItem;
    
    _exponentImageView.image = [UIImage imageNamed:@"info_1"];
    _exponentStatusLabel.text = cwSuggestionItem.brf;
    _exponentTitleLabel.text = @"洗车指数";
}

- (void)setDrsgSuggestionItem:(HCSDrsgSuggestion *)drsgSuggestionItem
{
    _drsgSuggestionItem = drsgSuggestionItem;
    
    _exponentImageView.image = [UIImage imageNamed:@"info_0"];
    _exponentStatusLabel.text = drsgSuggestionItem.brf;
    _exponentTitleLabel.text = @"穿衣指数";
}

- (void)setSportSuggestionItem:(HCSSportsuggestion *)sportSuggestionItem
{
    _sportSuggestionItem = sportSuggestionItem;
    _exponentImageView.image = [UIImage imageNamed:@"info_2"];
    _exponentStatusLabel.text = sportSuggestionItem.brf;
    _exponentTitleLabel.text = @"运动指数";
    
}

- (void)setFluSuggestionItem:(HCSFlusuggestion *)fluSuggestionItem
{
    _fluSuggestionItem = fluSuggestionItem;
    _exponentImageView.image = [UIImage imageNamed:@"info_4"];
    _exponentStatusLabel.text = fluSuggestionItem.brf;
    _exponentTitleLabel.text = @"感冒指数";
    
}

- (void)setTravSuggestionItem:(HCSTravsuggestion *)travSuggestionItem
{
    _travSuggestionItem = travSuggestionItem;
    _exponentImageView.image = [UIImage imageNamed:@"info_5"];
    _exponentStatusLabel.text = travSuggestionItem.brf;
    _exponentTitleLabel.text = @"旅游指数";
}

- (void)setUvSuggestionItem:(HCSUvsuggestion *)uvSuggestionItem
{
    _uvSuggestionItem = uvSuggestionItem;
    _exponentImageView.image = [UIImage imageNamed:@"info_6"];
    _exponentStatusLabel.text = uvSuggestionItem.brf;
    _exponentTitleLabel.text = @"紫外线指数";
    
}

@end
