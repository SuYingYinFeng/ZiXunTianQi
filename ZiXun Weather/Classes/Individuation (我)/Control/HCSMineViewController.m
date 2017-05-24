//
//  HCSMineViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/7.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSMineViewController.h"
#import "HCSMineItem.h"
#import "HCSMineGroupItem.h"
#import "HCSLoginViewController.h"
#import "HCSSettingViewController.h"
#import "HCSMineCell.h"
#import "HCSAPPFindViewController.h"
#import "HCSWebViewController.h"
#import "HCSCoverView.h"
#import "HCSPopView.h"
#import "HCSHuanCunViewController.h"

static CGFloat const headerHeight = 200;
static CGFloat const headerMinHeight = 120;
static CGFloat const rightMinSpace = 20;
static CGFloat const rightMaxSpace = 70;
static NSString * const Mine_ID = @"Mine_cell";

@interface HCSMineViewController ()<UITableViewDataSource,UITableViewDelegate,HCSPopViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mineTableView;
@property (weak, nonatomic) IBOutlet UIView *accoutView;
@property (weak, nonatomic) IBOutlet UIButton *leftLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomLoginButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightToTrailingLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopViewHeight;
@property (nonatomic,assign) CGFloat oriOffsetY;
@property (strong, nonatomic) NSMutableArray *groupArray;
@property (nonatomic,strong) UILabel *cellLabel;
@end

@implementation HCSMineViewController

- (NSMutableArray *)groupArray {
    if (_groupArray == nil) {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}

- (IBAction)LoginButtonClick:(UIButton *)sender {
    
    if ([self.leftLoginButton.titleLabel.text isEqualToString:@"登录"]&&[self.bottomLoginButton.titleLabel.text isEqualToString:@"登录"]) {
        HCSLoginViewController *loginVc = [[HCSLoginViewController alloc] init];
        [self.navigationController pushViewController:loginVc animated:YES];
    }
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"";
    
    [self setUpSubView];
    
    [self addCellGroup];
    
    // 取消tableView分割线
    self.mineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)addCellGroup
{
    //描述一组
    [self setUpGroup0];
    [self setUpGroup1];
    [self setUpGroup2];
    [self setUpGroup3];
    [self setUpGroup4];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:1.0 animations:^{
        self.navigationController.navigationBarHidden = YES;
    }];

    HCSMineItem *mineItem = [[HCSMineItem alloc] init];
    if (mineItem.accountName)
    {
        [self.leftLoginButton setTitle:mineItem.accountName forState:UIControlStateNormal];
        
        [self.bottomLoginButton setTitle:mineItem.accountName forState:UIControlStateNormal];
    
    }

}


- (UILabel *)cellLabel
{
    if (_cellLabel == nil) {
        UILabel *cellLabel = [[UILabel alloc] init];
        cellLabel.frame = CGRectMake(0, 0, 100, 30);
        cellLabel.text = @"自动设置";
        cellLabel.textAlignment = NSTextAlignmentRight;
        cellLabel.font = [UIFont systemFontOfSize:11];
        cellLabel.textColor = [UIColor lightGrayColor];
        _cellLabel = cellLabel;
        
    }
    return _cellLabel;
}


#pragma mark - setUpSubView
- (void)setUpSubView
{
    _oriOffsetY = -15 + headerHeight;
    self.mineTableView.dataSource = self;
    self.mineTableView.delegate = self;
    self.mineTableView.sectionHeaderHeight = 0;
    self.mineTableView.sectionFooterHeight = 20;

//    mineTableView.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.mineTableView.contentInset = UIEdgeInsetsMake(_oriOffsetY, 0, 28, 0);

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //移动的偏移量
    CGFloat offset = scrollView.contentOffset.y - (-self.oriOffsetY);
    CGFloat oriHeight = headerHeight - offset;
    
    if (oriHeight <= headerMinHeight ) {
        oriHeight  = headerMinHeight;
        self.accoutView.hidden = YES;
        self.leftLoginButton.hidden = NO;
    }else
    {
        self.accoutView.hidden = NO;
        self.leftLoginButton.hidden = YES;
    }
    
    self.TopViewHeight.constant = oriHeight;
    
    //最大值.
    CGFloat dis = offset * 1.0 / (headerHeight - headerMinHeight);

    if (dis >= 1) {
        dis = 1.0;
    }else if (dis <= 0)
    {
        dis = 0.0;
    }
    
    self.rightToTrailingLine.constant = (rightMaxSpace - rightMinSpace) * (1.0 - dis) + rightMinSpace;

}

#pragma mark - cellGroup
- (void)setUpGroup0 {
    //描述一组

    HCSMineItem *item0 = [HCSMineItem settingItemWithImage:[UIImage imageNamed:@"profile_community_icon"] title:@"轻松一刻"];
    item0.rowType = HCSRowTypeArrow;
    HCSMineItem *item1 = [HCSMineItem settingItemWithImage:[UIImage imageNamed:@"profile_mojimall_icon"] title:@"皮肤小铺"];
    item1.rowType = HCSRowTypeArrow;
    HCSMineItem *item2 = [HCSMineItem settingItemWithImage:[UIImage imageNamed:@"profile_dresshelper_icon"] title:@"穿衣助手"];
    item1.rowType = HCSRowTypeArrow;
    //一组里面有多少行
    NSArray *array = @[item0,item1,item2];
    
    //创建组模型
    HCSMineGroupItem *groupItem = [HCSMineGroupItem groupItemWithRowArray:array];
//    groupItem.headerT = @"第一组的头部标题";
//    groupItem.footerT = @"第一组的尾部标题";
    [self.groupArray addObject:groupItem];
}

- (void)setUpGroup1 {
    //描述一组
 
    HCSMineItem *item0 = [HCSMineItem settingItemWithImage:[UIImage imageNamed:@"profile_recommendation_icon"] title:@"发现APP"];
    item0.rowType = HCSRowTypeNew;
    item0.ToPushClass = [HCSAPPFindViewController class];
    
    HCSMineItem *item1 = [HCSMineItem settingItemWithImage:[UIImage imageNamed:@"profile_third_party_ad_icon2"] title:@"美术宝"];
    item1.rowType = HCSRowTypeAD;
    item1.operationTask = ^(NSIndexPath *indexPath){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"下载" message:@"是否下载美术宝应用？" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"确定", nil];
        [alertView show];
        
    };
    HCSMineItem *item2 = [HCSMineItem settingItemWithImage:[UIImage imageNamed:@"profile_third_party_ad_icon1"] title:@"爱学贷"];
    item2.rowType = HCSRowTypeAD;
    item2.operationTask = ^(NSIndexPath *indexPath){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"下载" message:@"是否下载爱学贷应用？" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"确定", nil];
        [alertView show];
    };
    
    //一组里面有多少行
    NSArray *array = @[item0,item1,item2];
    //创建组模型
    HCSMineGroupItem *groupItem = [HCSMineGroupItem groupItemWithRowArray:array];

    [self.groupArray addObject:groupItem];
}


- (void)setUpGroup2 {
    //描述一组
    HCSMineItem *item0 = [HCSMineItem settingItemWithImage:[UIImage imageNamed:@"profile_default_cooperation"] title:@"玩游戏"];
    item0.rowType = HCSRowTypeArrow;
    item0.operationTask = ^(NSIndexPath *indexPath){
    
        HCSWebViewController *webVC = [[HCSWebViewController alloc] init];
        webVC.url = [NSURL URLWithString:@"http://www.curlend.com/?d=20160513"];
        [self.navigationController pushViewController:webVC animated:YES];
        
    };
    
//    http://www.curlend.com/?d=20160513
//    http://shouji.baidu.com/soft/item?docid=8199654&from=&f=search_app_%E7%99%BE%E5%BA%A6%E6%89%8B%E6%9C%BA%E5%8A%A9%E6%89%8B%40listsp_1_title%401%40header_software_input
    
    HCSMineItem *item1 = [HCSMineItem settingItemWithImage:[UIImage imageNamed:@"profile_airnut_icon"] title:@"我的空气果"];
    item1.rowType = HCSRowTypeArrow;
    item1.operationTask = ^(NSIndexPath *indexPath){
        //弹出一个遮盖，显示弹出View
        [HCSCoverView show];
        
        //弹出popView
        HCSPopView *popView = [HCSPopView showPopViewCenterInPoint:self.view.center];
        
        //成为代理
        popView.delegate = self;
    };
    
    //一组里面有多少行
    NSArray *array = @[item0,item1];
    //创建组模型
    HCSMineGroupItem *groupItem = [HCSMineGroupItem groupItemWithRowArray:array];
    [self.groupArray addObject:groupItem];
}

- (void)setUpGroup3 {
    //描述一组
    HCSMineItem *item0 = [HCSMineItem settingItemWithImage:[UIImage imageNamed:@"profile_settings_icon"] title:@"设置"];
    item0.rowType = HCSRowTypeArrow;
    item0.ToPushClass = [HCSSettingViewController class];

    //一组里面有多少行
    NSArray *array = @[item0];
    //创建组模型
    HCSMineGroupItem *groupItem = [HCSMineGroupItem groupItemWithRowArray:array];
    [self.groupArray addObject:groupItem];
}

- (void)setUpGroup4 {
    //描述一组
    HCSMineItem *item0 = [HCSMineItem settingItemWithImage:[UIImage imageNamed:@"profile_draftbox_icon"] title:@"清除缓存"];
    item0.rowType = HCSRowTypeDefault;

    item0.ToPushClass = [HCSHuanCunViewController class];
    item0.cellLabelText = @"点击清除";
    
    //一组里面有多少行
    NSArray *array = @[item0];
    //创建组模型
    HCSMineGroupItem *groupItem = [HCSMineGroupItem groupItemWithRowArray:array];
    [self.groupArray addObject:groupItem];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.groupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //取出当前是第几组
    HCSMineGroupItem *item = self.groupArray[section];
    return item.rowItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HCSMineCell *cell = [tableView dequeueReusableCellWithIdentifier:Mine_ID];
    if (cell == nil) {
        cell = [[HCSMineCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Mine_ID];
    }
    //设置数据
    //取出当前是第几组
    HCSMineGroupItem *groupItem = self.groupArray[indexPath.section];
    //取出每一个行模型
    HCSMineItem *item = groupItem.rowItemArray[indexPath.row];
    
    //设置Cell的辅助视图
    if (item.rowType == HCSRowTypeArrow) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_forward_arrow"]];
    }else if (item.rowType == HCSRowTypeSwitch) {
        cell.accessoryView = [[UISwitch alloc] init];
    }else if (item.rowType == HCSRowTypeNew) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cm_icon_new"]];
    }else if (item.rowType == HCSRowTypeDefault) {
        self.cellLabel.text = item.cellLabelText;
        cell.accessoryView = self.cellLabel;
    }else if (item.rowType == HCSRowTypeAD) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popularize_image_blackbg_cn"]];
    }
    
    cell.textLabel.text = item.title;
    cell.imageView.image = item.image;
    
    return cell;
}

//在行点击时执行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取出当前的行模型
    HCSMineGroupItem *groupItem = self.groupArray[indexPath.section];
    HCSMineItem *mineItem = groupItem.rowItemArray[indexPath.row];
    
    //判断模型的类型
    if ((mineItem.rowType == HCSRowTypeArrow) || (mineItem.rowType == HCSRowTypeNew) || (mineItem.rowType == HCSRowTypeDefault)) {
        
        //判断有没有要执行的任务
        if (mineItem.operationTask) {
            //执行任务
            mineItem.operationTask(indexPath);
                
                return;
            }
            
        if(mineItem.ToPushClass) {
            //创建控制器,跳转到指定的控制器.
            UIViewController *vc = [[mineItem.ToPushClass alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            }
    }
    
    if (mineItem.rowType == HCSRowTypeAD) {
        //执行任务
        mineItem.operationTask(indexPath);
    }
    
}


#pragma mark - HCSPopViewDelegate
/**
 *  实现HCSPopViewDelegate方法
 */
- (void)popViewClickCloceButton:(HCSPopView *)popView
{
    
    //告诉popView隐藏在哪个点
    [popView hiddenInPoint:CGPointMake(HCSScreenW * 5 / 6.0, HCSScreenH - 20) completion:^{
        //      移除遮盖
        //遍历窗口子控件
        for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
            //如果是遮盖，就移除
            if ([view isKindOfClass:[HCSCoverView class]]) {
                [view removeFromSuperview];
            }
        }
    }];
}



@end
