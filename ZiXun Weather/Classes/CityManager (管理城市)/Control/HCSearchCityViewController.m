//
//  HCSearchCityViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/4/24.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSearchCityViewController.h"
#import "HCSResizeImageTool.h"
#import "HCSCityResultViewController.h"
#import "HCSTipsViewController.h"
#import <MJExtension/MJExtension.h>
#import "HCSCityDetailItem.h"
#import "HCSTabBarController.h"

#define HCSSearchView_Size self.searchView.bounds.size
@interface HCSearchCityViewController ()<UISearchResultsUpdating,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
/** 搜索控制器*/
@property (nonatomic, strong) UISearchController *searchVC;
/** 所有的结果*/
@property (nonatomic ,strong)UITableView *demoTableView;
/** 全部数据*/
@property (nonatomic ,strong) NSMutableArray *exampleArr;
/** 搜索的数据*/
@property (nonatomic ,strong)NSMutableArray *searchArr;

@property (nonatomic,strong) NSMutableArray *cityItemArray;

@property (nonatomic,strong) NSMutableArray *itemArray;

@property (nonatomic,strong) UIButton *cancalButton;

@end

@implementation HCSearchCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpChildViewController];

    [self setUpSearchResultView:nil];
    
    [self addtopViewContent];
    
    self.demoTableView.dataSource = self;
    
    self.demoTableView.delegate = self;
    
    self.searchVC.searchBar.delegate = self;
    
    // 初始化
    [self setup];
    
}

- (NSMutableArray *)cityItemArray
{
    if (_cityItemArray == nil) {
        _cityItemArray = [NSMutableArray array];
    }
    return _cityItemArray;
}

- (NSMutableArray *)itemArray
{
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (NSMutableArray *)exampleArr
{
    if (_exampleArr == nil) {
        _exampleArr = [NSMutableArray array];
    }
    return _exampleArr;
}

//addtopViewContent
- (void)addtopViewContent
{
    _searchVC = [[UISearchController alloc]initWithSearchResultsController:nil];
    _searchVC.searchResultsUpdater = self;
    
    _searchVC.dimsBackgroundDuringPresentation = NO;
    
    _searchVC.hidesNavigationBarDuringPresentation = NO;
    
    _searchVC.searchBar.frame = CGRectMake(self.searchVC.searchBar.frame.origin.x, self.searchVC.searchBar.frame.origin.y, self.searchVC.searchBar.frame.size.width, 44.0);

    [self.searchView addSubview:self.searchVC.searchBar];
  
}


//添加结果View
- (void)setUpSearchResultView:(NSString *)string
{
    if (string == nil) {
        [self setUpResultView];
    }else
    {
        NSLog(@"%@",string);
    }

}

- (void)setUpResultView
{
    for (UIView *childView in self.contentView.subviews) {
        [childView removeFromSuperview];
    }
    
    UIViewController *ResultVc = self.childViewControllers[0];
    CGFloat hcsViewW = self.contentView.hcs_width * 0.4;
    CGFloat hcsViewX = self.contentView.hcs_width * 0.5 - hcsViewW * 0.5;
    ResultVc.view.frame = CGRectMake(hcsViewX, 30, hcsViewW, hcsViewW);
    [self.contentView addSubview:ResultVc.view];
}

// 添加所有的子控制器
- (void)setUpChildViewController
{
    HCSTipsViewController *tipsVc = [[HCSTipsViewController alloc] init];
    tipsVc.title = @"提示界面";
    [self addChildViewController:tipsVc];
    
    HCSCityResultViewController *cityResultVc = [[HCSCityResultViewController alloc] init];
    cityResultVc.title = @"城市搜索结果";
    [self addChildViewController:cityResultVc];
 
}

- (IBAction)cancelButtonClick:(UIButton *)sender {
    
    self.cancalButton = sender;
    
    [self.view endEditing:YES];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - laze loading
- (UITableView *)demoTableView
{
    if (_demoTableView == nil) {
        _demoTableView = [[UITableView alloc]init];
        [self.contentView addSubview:_demoTableView];
    }
    return _demoTableView;
}



- (void)dealloc
{
    self.navigationItem.titleView = nil;
    _searchVC.searchBar.text = nil;
    _demoTableView = nil;
    _searchVC = nil;
    
}


#pragma mark - 初始化
- (void)setup
{
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];

    self.demoTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - rectStatus.size.height);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cityName" ofType:@"plist"];
    
    NSArray *cityDityArray = [NSArray arrayWithContentsOfFile:path];
    
    self.itemArray = [HCSCityDetailItem mj_objectArrayWithKeyValuesArray:cityDityArray];
    
}


#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = [self.searchVC.searchBar text];

    NSPredicate *cityEPredicate = [NSPredicate predicateWithFormat:@"cityE CONTAINS[c] %@", searchString];
        if (self.searchArr!= nil) {
            [self.searchArr removeAllObjects];
        }
 
    self.searchArr= [NSMutableArray arrayWithArray:[_itemArray filteredArrayUsingPredicate:cityEPredicate]];
    //刷新表格
    [self.demoTableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchVC.active) {
        return self.searchArr.count;//搜索结果
    }else
    {
        return self.itemArray.count;//原始数据

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath//cell
{
    static NSString *identify = @"cellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    HCSCityDetailItem *dictItem = self.searchVC.active? _searchArr[indexPath.row] : _itemArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@,%@,%@",dictItem.city,dictItem.prov,dictItem.cnty];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HCSCityDetailItem *cityItem = self.searchVC.active? _searchArr[indexPath.row] : _itemArray[indexPath.row];

    NSMutableArray *mutableArray = [NSMutableArray arrayWithObjects:cityItem.city,cityItem.cityE,cityItem.ID,cityItem.prov, nil];
    
    NSArray *cityArray = [NSArray arrayWithArray:mutableArray];
    
    [HCSSaveTool setObject:cityArray forKey:@"cityItem"];
    
    
    if (self.searchVC.active) {
        [self cancelButtonClick:_cancalButton];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        HCSTabBarController *tabBarVc = [[HCSTabBarController alloc] init];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
    });
    


}


@end
