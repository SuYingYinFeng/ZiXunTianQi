//
//  HCSBaseMenuViewController.m
//  BaiSiBuDeJie
//
//  Created by 黄灿森 on 16/5/4.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSBaseMenuViewController.h"
#import "UIBarButtonItem+Item.h"
#import "HCSWebViewController.h"


static NSString * const ID = @"contentView_cell";

@interface HCSBaseMenuViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,weak) UIScrollView *titleView;
@property (nonatomic,weak) UICollectionView *contentView;
@property (nonatomic,weak) UIButton *selButton;
@property (nonatomic,strong) NSMutableArray *titleButtonsArray;
@property (nonatomic,weak) UIView *underLineView;
@property (nonatomic,assign) BOOL isInitial;

@end

@implementation HCSBaseMenuViewController

// 不管一个view当前有没有显示出来，只要添加到屏幕上就会被渲染
// UICollectionView做的优化，并不是少创建控制器的view，而是对控制器的view的渲染进行优化
/*
 the item height must be less than the height of the UICollectionView minus the section insets top and bottom values, minus the content insets top and bottom values.
 表示cell的尺寸 超过 UICollectionView尺寸
 UICollectionView尺寸 减去 顶部和底部额外间距
 */
// 显示在最外面的view,就是导航控制器栈顶控制器

#pragma mark - titleButtonsArray懒加载
- (NSMutableArray *)titleButtonsArray
{
    if (_titleButtonsArray == nil) {
        _titleButtonsArray = [NSMutableArray array];
    }
    return _titleButtonsArray;
}

#pragma mark
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 搭建底部view：UICollectionView
    [self setUpContentView];
    
    // 搭建顶部view: UISrcollView
    [self setUpTitleView];
    
    // iOS7之后，如果是导航控制器下scrollView,顶部都会添加64的额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //监听通知-新闻详情点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observerGetTheNotification:) name:@"NewDetailButton" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_isInitial == NO) {
        // 设置所有标题
        [self setUpAllTitle];
        
        _isInitial = YES;
    }

}

//监听到通知调用
- (void)observerGetTheNotification:(NSNotification *)note
{
//    NSLog(@"%@",note.userInfo);
    HCSWebViewController *webVC = [[HCSWebViewController alloc] init];
    NSString *urlStr = note.userInfo[@"NewUrl"];
    webVC.url = [NSURL URLWithString:urlStr];
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - 设置所有标题 添加到标题数组 添加下划线
- (void)setUpAllTitle
{
    NSInteger count = self.childViewControllers.count;
    if (count == 0) return;
    CGFloat buttonW = _titleView.contentSize.width / count;
    CGFloat buttonH = _titleView.contentSize.height;
    NSLog(@"%f,%f",_titleView.contentSize.width,_titleView.contentSize.height);
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    for (NSInteger i = 0 ; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonX = i * buttonW;
        titleButton.tag = i;
        titleButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        NSString *titleText = [self.childViewControllers[i] title];
        [titleButton setTitle:titleText forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        //监听按钮点击
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.titleView addSubview:titleButton];
        
        [self.titleButtonsArray addObject:titleButton];
        
        //默认选择第一个childViewController
        if (i == 0) {
            [self titleButtonClick:titleButton];
            // 下划线宽度 = 按钮文字宽度
            // 下划线中心点的x = 按钮中心点x
            // 下划线的高度 = 2
            // 下划线的y = topView的height - 2
            // 添加下划线
            // 按钮的标题的宽度不会马上计算，只能手动计算文字宽度
//            UIView *underLineView = [[UIView alloc] init];
//            underLineView.backgroundColor = [UIColor redColor];
//            // 注意：设置中心点，一点要先设置尺寸
//            underLineView.hcs_width = [titleText sizeWithFont:[UIFont systemFontOfSize:15]].width;
//            underLineView.hcs_centerX = titleButton.hcs_centerX;
//            underLineView.hcs_height = 2;
//            underLineView.hcs_y = _titleView.hcs_height - underLineView.hcs_height;
//            [_titleView addSubview:underLineView];
//            _underLineView = underLineView;
            
        }

    }
    
}

#pragma mark - titleButton点击
- (void)titleButtonClick:(UIButton *)button
{
    NSInteger i = button.tag;
    //选择按钮
    [self selectButton:button];
    
    CGFloat offsetX = i * HCSScreenW;
    
    _contentView.contentOffset = CGPointMake(offsetX, 0);
    
    /*
     问题：点击标题，拿不到cell，返回cell方法根本就没有调用
     分析：返回cell方法为什么没有调用 因为没有滚动
     即使滚动了 也拿不到，contentOffset 延迟 ，并不是马上滚动。
     
     */
}

#pragma mark - 选择按钮 移动下划线
- (void)selectButton:(UIButton *)button
{
    _selButton.selected = NO;
    button.selected = YES;
    _selButton = button;
    
    //移动下划线
    [UIView animateWithDuration:0.25 animations:^{
        _underLineView.hcs_centerX = button.hcs_centerX;
        _underLineView.hcs_width = button.titleLabel.hcs_width;
    }];
}

// 1.添加底部view 2.添加顶部view 3.让collevtionView展示cell 4.调整cell的尺寸 5.取消了顶部额外滚动区域
#pragma mark - 搭建顶部view: UIScrollView
- (void)setUpTitleView
{
    UIScrollView *titleView = [[UIScrollView alloc] init];
    _titleView = titleView;
    titleView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    CGFloat titleViewY = 0;
    CGFloat titleViewW = HCSScreenW;
    CGFloat titleViewH = 44;
    titleView.frame = CGRectMake(0, titleViewY, titleViewW, titleViewH);
    [self.view addSubview:titleView];
    
    titleView.contentSize = CGSizeMake(HCSScreenW, titleViewH);
    
}

#pragma mark - 搭建底部view：UICollectionView；占据全屏
- (void)setUpContentView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //    cell间距
    flowLayout.itemSize = CGSizeMake(HCSScreenW, HCSScreenH);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    UICollectionView *contentView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _contentView = contentView;
    
    contentView.dataSource = self;
    contentView.delegate = self;
    // 指示器，分页
    contentView.pagingEnabled = YES;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.bounces = NO;
    
    [self.view addSubview:contentView];
    
    
    // 注册cell
    [contentView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 注意：一定要记得移除之前添加到cell上子控制器
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 3.把对应子控制器的view添加到对应的cell 的 contentView
    UIViewController *vc = self.childViewControllers[indexPath.row];
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
//collectionView滚动完成就会调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算当前页数
    NSInteger i = scrollView.contentOffset.x / HCSScreenW;
    //选中对应的标题
    [self selectButton:self.titleButtonsArray[i]];
    
}

- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
