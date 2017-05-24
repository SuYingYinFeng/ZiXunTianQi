//
//  HCSHotNewsViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/15.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSHotNewsViewController.h"
#import "HCSNewsCell.h"
#import "HCSNewsViewModel.h"
#import "HCSNewsItem.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>

typedef enum : NSUInteger {
    HCSLoadDataStatusFirstTime,
    HCSLoadDataStatusHeaderRefresh,
    HCSLoadDataStatusFooterRefresh,
} HCSLoadDataStatus;

static NSString * const ID = @"hotNews_cell";

@interface HCSHotNewsViewController ()

@property (nonatomic,strong) NSMutableArray *newsListArray;
@property (nonatomic,strong) NSArray *newsAllTitleArray;
@property (nonatomic,strong) NSArray *newsViewModelArray;
@property (nonatomic,assign) NSUInteger index;
@property (nonatomic,assign) NSUInteger section;
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (nonatomic,assign) HCSLoadDataStatus loadDataStatus;

@end

@implementation HCSHotNewsViewController

//懒加载数组
- (NSMutableArray *)newsListArray
{
    if (_newsListArray == nil) {
        _newsListArray = [NSMutableArray array];
    }
    return _newsListArray;
}

//- (NSMutableArray *)newsViewModelArray
//{
//    if (_newsViewModelArray == nil) {
//        _newsViewModelArray = [NSMutableArray array];
//    }
//    return _newsViewModelArray;
//}

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerClass:[HCSNewsCell class] forCellReuseIdentifier:ID];
//    
//    self.tableView.backgroundColor = HCSColorWith(206, 206, 206);
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tableView.frame = self.view.bounds;
//    
//    // 最后一个cell不显示，只要添加底部额外滚动区域就好
//    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 100, 0);
//    
//    self.loadDataStatus = HCSLoadDataStatusFirstTime;
//    
//    // 取消tableView分割线
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//
//    // 添加上拉刷新控件，给tableView
////    [self setupFooterRefreshView];
//    
//    // 添加下拉刷新
//    [self setupheaderRefreshView];
    
}



// 添加下拉刷新控件
- (void)setupheaderRefreshView
{
    // 创建下拉刷新控件
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(beginHeaderRefreshView)];
    
    // 控制下拉刷新显示,最开始位置透明度0，完全透明
    header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_header = header;
    
    // 使用MJRefresh一定要记得在请求成功的时候，结束刷新
    [header beginRefreshing];
    
}

//开始下拉刷新
- (void)beginHeaderRefreshView
{
    self.index = 0;
    self.section = 0;
    self.loadDataStatus = HCSLoadDataStatusHeaderRefresh;
    self.newsListArray = nil;
    self.newsAllTitleArray = nil;
    
    //请求数据
    [self requectData];
    
}

// 添加上拉控件
- (void)setupFooterRefreshView
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 自动隐藏上拉刷新控件，没有数据就会隐藏
    footer.automaticallyHidden = YES;
    self.tableView.mj_footer = footer;
    
}

- (void)loadMoreData
{
    _loadDataStatus = HCSLoadDataStatusFooterRefresh;
    [self getData];
}

#pragma mark - 请求参数数据
- (void)requectData
{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"dtype"] = @"json";
    parameters[@"key"] = @"be00c4fa873294ca8a3761d1102c0068";
    
    [self.manager GET:@"http://op.juhe.cn/onebox/news/words" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        
        // 获取字典数组
        self.newsAllTitleArray = responseObject[@"result"];
        [self getData];
     
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self getDataFailure];
        }
    }];
    
}

// 请求数据
- (void)getData
{
    if (_newsAllTitleArray.count) {
        
        NSString *stringTitle = [_newsAllTitleArray objectAtIndex:self.index];
        
        if (_index > 10) {
            
            [self NewDataReadly];
            
        }else
        {
            //请求数据
            [self requectNewsData:stringTitle];
        }
        
    }

}

- (void)NewDataReadly
{

    // 字典数组转模型数组
    NSArray *newsListArray = [HCSNewsItem mj_objectArrayWithKeyValuesArray:_newsListArray];
    // 把模型 转换 视图模型
    NSMutableArray *viewModelMutableArray = [NSMutableArray array];
    for (HCSNewsItem *newsItem in newsListArray) {
        // 创建视图模型
        HCSNewsViewModel *newsViewModel = [[HCSNewsViewModel alloc] init];
        newsViewModel.newsItem = newsItem;
        [viewModelMutableArray addObject:newsViewModel];
    }
    
    _newsViewModelArray = viewModelMutableArray;

    // 请求完成
    [self.tableView.mj_header endRefreshing];
    
    // 刷新表格
    [self.tableView reloadData];
    


}

#pragma mark - 请求数据
- (void)requectNewsData:(NSString *)str
{
 
    // 取消上拉刷新请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"q"] = str;
    parameters[@"dtype"] = @"json";
    parameters[@"key"] = @"be00c4fa873294ca8a3761d1102c0068";
    
    [self.manager GET:@"http://op.juhe.cn/onebox/news/query" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        
        NSString *reasonString = (NSString *)responseObject[@"reason"];
        if ([reasonString isEqualToString:@"查询不到相关的新闻"]) {
            _index++;
            [self getData];
        }else
        {
            // 获取字典数组
            NSArray *dictArray = responseObject[@"result"];
            NSDictionary *dict = (NSDictionary *)[dictArray firstObject];
            
            [self.newsListArray addObject:dict];
            
            _index++;
            
            [self getData];
        }
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [self getDataFailure];
        }
    }];
    
}

- (void)getDataFailure
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请求数据失败，请检查网络" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
    [alertView show];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _newsViewModelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HCSNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    // 传递视图模型
    cell.newsViewModel = self.newsViewModelArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 先计算好cell高度，再返回
    return [_newsViewModelArray[indexPath.row] cellHeight];
}



@end
