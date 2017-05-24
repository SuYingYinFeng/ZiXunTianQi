//
//  HCSExponentContentViewCell.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/26.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCScomfSuggestionItem;
@class HCSCwSuggestion;
@class HCSDrsgSuggestion;
@class HCSFlusuggestion;
@class HCSSportsuggestion;
@class HCSTravsuggestion;
@class HCSUvsuggestion;

@interface HCSExponentContentViewCell : UICollectionViewCell

@property (nonatomic,strong) HCScomfSuggestionItem *comfSuggestionItem;
@property (nonatomic,strong) HCSCwSuggestion *cwSuggestionItem;
@property (nonatomic,strong) HCSDrsgSuggestion *drsgSuggestionItem;
@property (nonatomic,strong) HCSFlusuggestion *fluSuggestionItem;
@property (nonatomic,strong) HCSSportsuggestion *sportSuggestionItem;
@property (nonatomic,strong) HCSTravsuggestion *travSuggestionItem;
@property (nonatomic,strong) HCSUvsuggestion *uvSuggestionItem;

@end
