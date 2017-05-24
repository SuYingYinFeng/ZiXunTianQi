//
//  HCSLocalViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/15.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSLocalViewController.h"
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

static NSString * const ID = @"loaclNews_cell";

// \u5e7f\u4e1c 广东

@interface HCSLocalViewController ()

@property (nonatomic,strong) NSMutableArray *newsListArray;
@property (nonatomic,strong) NSMutableArray *newsAllTitleArray;
@property (nonatomic,strong) NSArray *newsViewModelArray;
@property (nonatomic,assign) NSUInteger index;
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (nonatomic,assign) HCSLoadDataStatus loadDataStatus;
@property (nonatomic,assign) NSArray *cityArray;
@property (nonatomic,strong) NSDictionary *shengFenDict;
@property (nonatomic,strong) NSArray *cityUTFArray;

@end

@implementation HCSLocalViewController


//懒加载数组
- (NSMutableArray *)newsListArray
{
    if (_newsListArray == nil) {
        _newsListArray = [NSMutableArray array];
    }
    return _newsListArray;
}

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingTableView];
    
    [self SetUpShengFenDict];
    
    self.cityArray = [HCSSaveTool objectForKey:@"cityItem"];
    
    _loadDataStatus = HCSLoadDataStatusFirstTime;

    // 添加上拉刷新控件，给tableView
    //    [self setupFooterRefreshView];
    
    // 添加下拉刷新
    [self setupheaderRefreshView];
    
}

- (void)SetUpShengFenDict
{
    NSArray *utfarray = @[@"\u5317\u4eac",
                          @"\u5929\u6d25",
                          @"\u6cb3\u5317",
                          @"\u5c71\u897f",
                          @"\u5185\u8499\u53e4",
                          @"\u8fbd\u5b81",
                          @"\u5409\u6797",
                          @"\u9ed1\u9f99\u6c5f",
                          @"\u4e0a\u6d77",
                          @"\u6c5f\u82cf",
                          @"\u6d59\u6c5f",
                          @"\u5b89\u5fbd",
                          @"\u798f\u5efa",
                          @"\u6c5f\u897f",
                          @"\u5c71\u4e1c",
                          @"\u6cb3\u5357",
                          @"\u6e56\u5317",
                          @"\u6e56\u5357",
                          @"\u5e7f\u4e1c",
                          @"\u5e7f\u897f",
                          @"\u6d77\u5357",
                          @"\u91cd\u5e86",
                          @"\u56db\u5ddd",
                          @"\u8d35\u5dde",
                          @"\u4e91\u5357",
                          @"\u897f\u85cf",
                          @"\u9655\u897f",
                          @"\u7518\u8083",
                          @"\u9752\u6d77",
                          @"\u5b81\u590f",
                          @"\u65b0\u7586",
                          @"\u53f0\u6e7e",
                          @"\u9999\u6e2f",
                          @"\u6fb3\u95e8"];
//    @"\u9999\u6e2f\u7279\u522b\u884c\u653f\u533a",
//    @"\u6fb3\u95e8\u7279\u522b\u884c\u653f\u533a"
    NSArray *sheng =  @[@"北京",
                        @"天津",
                        @"河北",
                        @"山西",
                        @"内蒙古",
                        @"辽宁",
                        @"吉林",
                        @"黑龙江",
                        @"上海",
                        @"江苏",
                        @"浙江",
                        @"安徽",
                        @"福建",
                        @"江西",
                        @"山东",
                        @"河南",
                        @"湖北",
                        @"湖南",
                        @"广东",
                        @"广西",
                        @"海南",
                        @"重庆",
                        @"四川",
                        @"贵州",
                        @"云南",
                        @"西藏",
                        @"陕西",
                        @"甘肃",
                        @"青海",
                        @"宁夏",
                        @"新疆",
                        @"台湾",
                        @"香港特别行政区",
                        @"澳门特别行政区"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSInteger i = 0 ; i < 34; i++) {
        NSString *utfStr = [utfarray objectAtIndex:i];
        NSString *shengStr = [sheng objectAtIndex:i];
        [dict setObject:utfStr forKey:shengStr];
    }

    self.shengFenDict = dict;
}

- (NSString *)getUTF8NameWithChineseStr:(NSString *)str
{
    return self.shengFenDict[str];
}

- (void)settingTableView
{
    [self.tableView registerClass:[HCSNewsCell class] forCellReuseIdentifier:ID];
    
    self.tableView.backgroundColor = HCSColorWith(206, 206, 206);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.frame = self.view.bounds;
    
    // 最后一个cell不显示，只要添加底部额外滚动区域就好
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 100, 0);
    // 取消tableView分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    NSString *str = [self getUTF8NameWithChineseStr:[self.cityArray objectAtIndex:3]];
    if (str) {
        [self requectNewsData:str];
    }
    
    
}

// 添加上拉控件
//- (void)setupFooterRefreshView
//{
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    // 自动隐藏上拉刷新控件，没有数据就会隐藏
//    footer.automaticallyHidden = YES;
//    self.tableView.mj_footer = footer;
    
//}



- (void)DataReadly
{

}

#pragma mark - 请求数据
- (void)requectNewsData:(NSString *)str
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"q"] = str;
    parameters[@"dtype"] = @"json";
    parameters[@"key"] = @"be00c4fa873294ca8a3761d1102c0068";
    
    [self.manager GET:@"http://op.juhe.cn/onebox/news/query" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {

        NSString *reasonString = (NSString *)responseObject[@"reason"];
        if ([reasonString isEqualToString:@"查询不到相关的新闻"]) {

            // 请求完成
            [self.tableView.mj_header endRefreshing];
            [self getDataFailure:@"查询不到相关的新闻"];
        }else
        {
            // 获取字典数组
            NSArray *dictArray = responseObject[@"result"];
            
            // 字典数组转模型数组
            NSArray *newsListArray = [HCSNewsItem mj_objectArrayWithKeyValuesArray:dictArray];
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
    
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            // 请求完成
            [self.tableView.mj_header endRefreshing];
            [self getDataFailure:@"请求数据失败，请检查网络"];
        }
    }];
    
}

- (void)getDataFailure:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
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
