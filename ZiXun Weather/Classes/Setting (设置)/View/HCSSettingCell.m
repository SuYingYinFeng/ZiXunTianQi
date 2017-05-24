//
//  HCSSettingCell.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/14.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSSettingCell.h"
//#import "HCSSettingItem.h"


@implementation HCSSettingCell

//#pragma mark - 重写cell的frame设置
//- (void)setFrame:(CGRect)frame
//{
//    frame.size.height += 20;
//    frame.origin.y -= 20;
//    [super setFrame:frame];
//    
//}

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style {
    
    static NSString *ID = @"settingCell";
    HCSSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HCSSettingCell alloc] initWithStyle:style reuseIdentifier:ID];
    }

    
    return cell;
}

#pragma mark - 只要一个控件调用Init方法创建，底层就会调用initWithFrame
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

#pragma mark - 通过代码初始化cell就会调用这个
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 不要cell选中样式,注意：只是选中cell没有效果，但是cell还是可以选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 设置cell背景图片
        self.backgroundView = [[UIImageView alloc] initWithImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"mainCellBackground"]];
        
    }
    return self;
}

//- (void)setRowSettingItem:(HCSSettingItem *)rowSettingItem
//{
//    _rowSettingItem = rowSettingItem;
//    
//    //设置数据
////    [self setUpData:rowSettingItem];
//    
//    //设置Cell的辅助视图
////    [self setUpAccessoryView:rowSettingItem];
//
//}


////设置数据
//- (void)setUpData:(HCSSettingItem *)rowItem {
//    //设置数据
//    if (rowItem.cellTitle) {
//        self.textLabel.text = rowItem.cellTitle;
//        self.textLabel.textColor = HCSColorWith(100, 106, 117);
//    }else
//    {
//        self.textLabel.text = nil;
//    }
//    
//    if (rowItem.cellImage) {
//        self.imageView.image = rowItem.cellImage;
//    }else
//    {
//        self.imageView.image = nil;
//    }
//    
//    if (rowItem.cellDetailText) {
//        self.detailTextLabel.text = rowItem.cellDetailText;
//        self.detailTextLabel.font = [UIFont systemFontOfSize:11];
//    }else
//    {
//        self.detailTextLabel.text = nil;
//    }
//    
//}
//
//
////设置Cell的辅助视图
//- (void)setUpAccessoryView:(HCSSettingItem *)rowSettingItem {
//    if (rowSettingItem.settingRowType == HCSRowSettingTypeArrow) {
//        
//        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
//        
//    }else if (rowSettingItem.settingRowType == HCSRowSettingTypeSwitch) {
//        UISwitch *switchView = [[UISwitch alloc] init];
//        switchView.on = rowSettingItem.switchState;
//        self.accessoryView = switchView;
//    }else {
//        self.accessoryView = nil;
//    }
//}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
