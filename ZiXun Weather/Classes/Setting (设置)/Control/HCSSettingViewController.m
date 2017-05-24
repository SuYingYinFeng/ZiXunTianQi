//
//  HCSSettingViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/7.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSSettingViewController.h"
#import <MBProgressHUD+XMG.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "HCSIdeaViewController.h"
#import "HCSAboutMineViewController.h"
#import "HCSAccountManagerViewController.h"

#import "HCSSettingCell.h"
#import "HCSSettingItem.h"
#import "HCSSettingGroupItem.h"

@interface HCSSettingViewController ()
@property (strong, nonatomic) NSMutableArray *groupArray;

@end

@implementation HCSSettingViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //设置标题
    self.navigationItem.title = @"设置";
    
    [self setUpTableViewLayout];
    
    //描述一组
    [self setUpGroup0];
    [self setUpGroup1];
    [self setUpGroup2];
    [self setUpGroup3];
    [self setUpGroup4];
    [self setUpGroup5];
}

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}


- (void)setUpTableViewLayout
{
    self.tableView.sectionFooterHeight = 20;
    self.tableView.sectionHeaderHeight = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (NSMutableArray *)groupArray {
    if (_groupArray == nil) {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}

- (void)setUpGroup0 {
    //描述一组
    HCSSettingItem *item0 = [HCSSettingItem settingItemWithImage:nil title:@"账号设置"];
    item0.settingRowType = HCSRowSettingTypeArrow;
    item0.ToPushViewClass = [HCSAccountManagerViewController class];

    NSArray *array = @[item0];
    
    //创建组模型
    HCSSettingGroupItem *groupItem = [HCSSettingGroupItem settingGroupItemWithRowSettingArray:array];

    [self.groupArray addObject:groupItem];
}


- (void)setUpGroup1 {
    //描述一组
    HCSSettingItem *item0 = [HCSSettingItem settingItemWithImage:nil title:@"推送通知"];
    item0.settingRowType = HCSRowSettingTypeSwitch;
    item0.switchState = YES;

    HCSSettingItem *item1 = [HCSSettingItem settingItemWithImage:nil title:@"语言闹钟"];
    item1.settingRowType = HCSRowSettingTypeDetail;
    item1.cellDetailText = @"未开启";
  
    
    HCSSettingItem *item2 = [HCSSettingItem settingItemWithImage:nil title:@"插件设置"];
    item2.settingRowType = HCSRowSettingTypeArrow;
    
    //一组里面有多少行
    NSArray *array = @[item0,item1,item2];
    //创建组模型
    HCSSettingGroupItem *groupItem = [HCSSettingGroupItem settingGroupItemWithRowSettingArray:array];
    [self.groupArray addObject:groupItem];
}


- (void)setUpGroup2 {
    
    HCSSettingItem *item0 = [HCSSettingItem settingItemWithImage:nil title:@"背景动画"];
    item0.settingRowType = HCSRowSettingTypeSwitch;
    item0.switchState = YES;

    HCSSettingItem *item1 = [HCSSettingItem settingItemWithImage:nil title:@"背景预览"];
    item1.settingRowType = HCSRowSettingTypeArrow;
    
    //一组里面有多少行
    NSArray *array = @[item0,item1];
    //创建组模型
    HCSSettingGroupItem *groupItem = [HCSSettingGroupItem settingGroupItemWithRowSettingArray:array];

    [self.groupArray addObject:groupItem];
}

- (void)setUpGroup3 {
    //描述一组
    HCSSettingItem *item0 = [HCSSettingItem settingItemWithImage:nil title:@"自动更新天气"];
    item0.settingRowType = HCSRowSettingTypeDetail;
    item0.cellDetailText = @"打开";

    
    HCSSettingItem *item1 = [HCSSettingItem settingItemWithImage:nil title:@"通知栏设置"];
    item1.settingRowType = HCSRowSettingTypeDetail;
    item1.cellDetailText = @"打开";

    
    //一组里面有多少行
    NSArray *array = @[item0,item1];
    //创建组模型
    HCSSettingGroupItem *groupItem = [HCSSettingGroupItem settingGroupItemWithRowSettingArray:array];
    
    [self.groupArray addObject:groupItem];
}


- (void)setUpGroup4 {

    HCSSettingItem *item0 = [HCSSettingItem settingItemWithImage:nil title:@"显示语言设置"];
    item0.settingRowType = HCSRowSettingTypeDetail;
    item0.cellDetailText = @"跟随系统语言";


    HCSSettingItem *item1 = [HCSSettingItem settingItemWithImage:nil title:@"单位设置"];
    item1.settingRowType = HCSRowSettingTypeDetail;
    item1.cellDetailText = @"跟随语言设置";
    
    //一组里面有多少行
    NSArray *array = @[item0,item1];
    //创建组模型
    HCSSettingGroupItem *groupItem = [HCSSettingGroupItem settingGroupItemWithRowSettingArray:array];
    
    [self.groupArray addObject:groupItem];
}

- (void)setUpGroup5 {
    //描述一组
    HCSSettingItem *item0 = [HCSSettingItem settingItemWithImage:nil title:@"检验新版本"];
    item0.cellDetailText = @"当前版本v1.0";
    item0.operationSettingTask = ^(NSIndexPath *indexPath){
        
        [MBProgressHUD showSuccess:@"当前是最新版本,无需更新"];
    };
    
    HCSSettingItem *item1 = [HCSSettingItem settingItemWithImage:nil title:@"赏个好评"];
    
    item1.operationSettingTask = ^(NSIndexPath *indexPath){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"赏个好评" message:@"好用就赞一个呗" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"赞一个", nil];
        [alertView show];
        
        
    };
    
    HCSSettingItem *item2 = [HCSSettingItem settingItemWithImage:nil title:@"意见反馈"];

    item2.ToPushViewClass = [HCSIdeaViewController class];
    
    HCSSettingItem *item3 = [HCSSettingItem settingItemWithImage:nil title:@"关于我们"];

    item3.ToPushViewClass = [HCSAboutMineViewController class];
    
    //一组里面有多少行
    NSArray *array = @[item0,item1,item2,item3];
    //创建组模型
    HCSSettingGroupItem *groupItem = [HCSSettingGroupItem settingGroupItemWithRowSettingArray:array];
    
    [self.groupArray addObject:groupItem];
    

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.groupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //取出当前是第几组
    HCSSettingGroupItem *groupItem = self.groupArray[section];
    return groupItem.rowSettingItemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1.创建Cell.
    HCSSettingCell *cell = [HCSSettingCell cellWithTableView:tableView style:UITableViewCellStyleValue1];
    //2.取出模型
    
    //取出当前是第几组
    HCSSettingGroupItem *groupItem = self.groupArray[indexPath.section];
    //取出每一个行模型
    HCSSettingItem *settingItem = groupItem.rowSettingItemArray[indexPath.row];
    
    //设置Cell的辅助视图
    if (settingItem.settingRowType == HCSRowSettingTypeArrow) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_forward_arrow"]];
    }else if (settingItem.settingRowType == HCSRowSettingTypeSwitch) {
        UISwitch *switchView = [[UISwitch alloc] init];
        switchView.on = settingItem.switchState;
        cell.accessoryView = switchView;
    }else if (settingItem.settingRowType == HCSRowSettingTypeDetail) {

        cell.detailTextLabel.text = settingItem.cellDetailText;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];

    }
    
    cell.textLabel.text = settingItem.cellTitle;

    return cell;
}


//在行点击时执行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //取出当前的行模型
    HCSSettingGroupItem *groupItem = self.groupArray[indexPath.section];
    HCSSettingItem *settingItem = groupItem.rowSettingItemArray[indexPath.row];
    
    if (settingItem.settingRowType == HCSRowSettingTypeArrow || settingItem.settingRowType == HCSRowSettingTypeDetail) {
        //判断有没有要执行的任务
        if (settingItem.operationSettingTask) {
            //执行任务
            settingItem.operationSettingTask(indexPath);
            return;
        }
        
        
        if(settingItem.ToPushViewClass) {
            //创建控制器,跳转到指定的控制器.
            UIViewController *vc = [[settingItem.ToPushViewClass alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
    
}


//设置头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    HCSSettingGroupItem *groupItem = self.groupArray[section];
    return groupItem.headerTitle;
}
//设置尾部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    HCSSettingGroupItem *groupItem = self.groupArray[section];
    return groupItem.footerTitle;
}



@end
