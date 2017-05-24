//
//  HCSSuggestionItem.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/31.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HCScomfSuggestionItem;
@class HCSCwSuggestion;
@class HCSDrsgSuggestion;
@class HCSFlusuggestion;
@class HCSSportsuggestion;
@class HCSTravsuggestion;
@class HCSUvsuggestion;

@interface HCSSuggestionItem : NSObject

@property (nonatomic,strong) HCScomfSuggestionItem *comf;
@property (nonatomic,strong) HCSCwSuggestion *cw;
@property (nonatomic,strong) HCSDrsgSuggestion *drsg;
@property (nonatomic,strong) HCSFlusuggestion *flu;
@property (nonatomic,strong) HCSSportsuggestion *sport;
@property (nonatomic,strong) HCSTravsuggestion *trav;
@property (nonatomic,strong) HCSUvsuggestion *uv;

@end
