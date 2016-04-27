//
//  HCSAddCityViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/4/24.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSAddCityViewController.h"
#import "HCSResizeImageTool.h"
#import "HCSearchCityViewController.h"

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"

#define HCSSearchViewSize self.hcs_searchView.bounds.size


static CGFloat const spaceViews = 10;
static CGFloat const buttonHeight = 30;
static NSInteger const maxCols = 3;
static CGFloat const LabelHeight = 30;

@interface HCSAddCityViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *hcs_searchView;

@property (weak, nonatomic) IBOutlet UIScrollView *hcs_scrollView;

@property (weak, nonatomic) UITextField *hcs_TextField;

@property (nonatomic,strong) NSArray *cityNameArray;

@property (nonatomic,strong) NSArray *resortNameArray;

@end

@implementation HCSAddCityViewController

//懒加载
- (NSArray *)cityNameArray
{
    if (_cityNameArray == nil) {
        _cityNameArray = @[@"北京",
                           @"上海",
                           @"广州",
                           @"深圳",
                           @"哈尔滨",
                           @"天津",
                           @"重庆",
                           @"沈阳",
                           @"大连",
                           @"长春",
                           @"郑州",
                           @"武汉",
                           @"长沙",
                           @"成都",
                           @"南京",
                           @"台北",
                           @"福州",
                           @"海口"];

    }
    return _cityNameArray;
}

- (NSArray *)resortNameArray
{
    if (_resortNameArray == nil) {
        _resortNameArray = @[@"故宫博物馆",
                             @"东方明珠塔",
                             @"黄果树瀑布",
                             @"黄山风景区",
                             @"庐山风景区",
                             @"清明上河园",
                             @"布达拉宫",
                             @"秦始皇陵",
                             @"云冈石窟",
                             @"镜泊湖",
                             @"桃花源",
                             @"黄鹤楼",
                             @"丽江古城",
                             @"乐山大佛",
                             @"南京夫子庙"];
    }
    return _resortNameArray;
}


//SearchView背景图片和搜索内部TextField
- (void)setUpSearchView
{
    //SearchView背景图片
    UIImage *hcs_image = [UIImage imageNamed:@"city_searchbar_background"];
    self.hcs_searchView.image = [hcs_image stretchableImageWithLeftCapWidth:hcs_image.size.width * 0.3 topCapHeight:hcs_image.size.height * 0.5];
    self.hcs_searchView.userInteractionEnabled = YES;
    
    //搜索内部TextField
    UITextField *hcs_TextField = [[UITextField alloc] initWithFrame:CGRectMake(HCSSearchViewSize.width * 0.05, 0, HCSSearchViewSize.width * 0.95 , HCSSearchViewSize.height)];
    hcs_TextField.placeholder = @"搜索城市";
    [self.hcs_searchView addSubview:hcs_TextField];
    self.hcs_TextField = hcs_TextField;
    [hcs_TextField addTarget:self action:@selector(SearchCityViewControllermodel) forControlEvents:UIControlEventEditingDidBegin];
}


- (UIView *)setUpHotCityViewWithContentView:(UIView *)contentView
{
    UIView *hcsView = [[UIView alloc] init];
    hcsView.frame = CGRectMake(self.hcs_scrollView.hcs_x, self.hcs_scrollView.hcs_y, contentView.hcs_width, 300);

    
    //fatherView
    UIView *fatherView = [[UIView alloc] init];
    CGFloat fatherViewW = hcsView.hcs_width * 0.8;
    CGFloat fatherViewX = hcsView.hcs_width * 0.5 - fatherViewW * 0.5;
    [hcsView addSubview:fatherView];
    
    //热门城市Label
    UILabel *hotCityLabel = [[UILabel alloc] init];
    hotCityLabel.text = @"热门城市";
    hotCityLabel.textAlignment = NSTextAlignmentCenter;
    hotCityLabel.font = [UIFont systemFontOfSize:15];
    hotCityLabel.textColor = [UIColor grayColor];
    [fatherView addSubview:hotCityLabel];
    
    //热门城市View
    UIView *hotCityView = [[UIView alloc] init];
    NSInteger totalCityRow = (self.cityNameArray.count + 2) / maxCols;
    CGFloat hotCityViewH = (spaceViews + buttonHeight) * totalCityRow;
    [fatherView addSubview:hotCityView];
    
    CGFloat fatherViewHeight = hotCityViewH + LabelHeight + spaceViews * 3;
    
    //添加约束fatherView
    [fatherView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hcsView.left).offset(fatherViewX);
        make.top.equalTo(hcsView.top).offset(spaceViews * 2);
        make.width.equalTo(fatherViewW);
        make.height.equalTo(fatherViewHeight);
    }];
    
    //添加约束hotCityLabel
    [hotCityLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fatherView.left);
        make.top.equalTo(fatherView.top);
        make.width.equalTo(fatherView.width);
        make.height.equalTo(LabelHeight);
    }];
    
    //添加约束hotCityView
    [hotCityView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fatherView.left);
        make.top.equalTo(hotCityLabel.bottom).offset(spaceViews);
        make.width.equalTo(fatherView.width);
        make.height.equalTo(hotCityViewH);
    }];
    
    //热门城市按钮
    NSInteger totalCount = self.cityNameArray.count;
    CGFloat buttonW = (fatherViewW - (maxCols + 1) * spaceViews) / maxCols;
    
    for (NSInteger i = 0 ; i < totalCount; i++) {
        
        NSInteger col = i % maxCols;
        CGFloat buttonX = (spaceViews + buttonW) * col + spaceViews;
        NSInteger row = i / maxCols;
        CGFloat buttonY = (spaceViews + buttonHeight) * row + spaceViews;
        
        UIButton *cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cityButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonHeight);
        cityButton.tag = i;

        NSString *cityNameStr = self.cityNameArray[i];
        
        [cityButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"add_city_btn_normal"] forState:UIControlStateNormal];
        [cityButton setTitle:cityNameStr forState:UIControlStateNormal];
        cityButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [cityButton setTitleColor:HCSColorWith(121, 126, 140) forState:UIControlStateNormal];
        
        [cityButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"add_city_btn_select"] forState:UIControlStateHighlighted];
        [cityButton setTitle:cityNameStr forState:UIControlStateHighlighted];
        [cityButton setTitleColor:HCSColorWith(63, 169, 226) forState:UIControlStateHighlighted];
        [hotCityView addSubview:cityButton];
  
    }

    return hcsView;

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //SearchView背景图片和搜索内部TextField
    [self setUpSearchView];
  
    UIView *hcs_View = [[UIView alloc] init];
    hcs_View.frame = CGRectMake(0, 0, self.hcs_scrollView.hcs_width,580);
    [self.hcs_scrollView addSubview:hcs_View];
    self.hcs_scrollView.contentSize = hcs_View.bounds.size;
    self.hcs_scrollView.bounces = NO;
    
    //设置热门城市的View
    UIView *fatherView = [self setUpHotCityViewWithContentView:hcs_View];
    fatherView.frame = CGRectMake(0, 0, fatherView.hcs_width, fatherView.hcs_height);
    [hcs_View addSubview:fatherView];
    
    //热门景点Label
    UILabel *hotResortLabel = [[UILabel alloc] init];
    CGFloat hotResortLabelY = CGRectGetMaxY(fatherView.frame);
    hotResortLabel.frame = CGRectMake(0, spaceViews * 2 + hotResortLabelY, hcs_View.hcs_width, LabelHeight);
    hotResortLabel.text = @"热门景区";
    hotResortLabel.textAlignment = NSTextAlignmentCenter;
    hotResortLabel.font = [UIFont systemFontOfSize:15];
    hotResortLabel.textColor = [UIColor grayColor];
    [hcs_View addSubview:hotResortLabel];
    
    //热门景点View
    UIView *hotResortView = [[UIView alloc] init];
    CGFloat hotResortViewW = hcs_View.hcs_width * 0.8;
    CGFloat hotResortViewX = hcs_View.center.x - hotResortViewW * 0.5;
    CGFloat hotResortViewY = CGRectGetMaxY(hotResortLabel.frame);
   
    NSInteger totalResortRow = (self.resortNameArray.count + 2) / maxCols;
    
    CGFloat hotResortViewH = (spaceViews + buttonHeight) * totalResortRow + spaceViews;
    hotResortView.frame = CGRectMake(hotResortViewX, hotResortViewY, hotResortViewW, hotResortViewH);
    [hcs_View addSubview:hotResortView];
    
    //热门景点按钮
    NSInteger totalResortCount = self.resortNameArray.count;
    CGFloat buttonResortW = (hotResortView.hcs_width - (maxCols + 1) * spaceViews) / maxCols;
    
    for (NSInteger i = 0 ; i < totalResortCount; i++) {
        
        NSInteger col = i % maxCols;
        CGFloat buttonResortX = (spaceViews + buttonResortW) * col + spaceViews;
        NSInteger row = i / maxCols;
        CGFloat buttonResortY = (spaceViews + buttonHeight) * row + spaceViews;
        
        UIButton *resortButton = [UIButton buttonWithType:UIButtonTypeCustom];
        resortButton.frame = CGRectMake(buttonResortX, buttonResortY, buttonResortW, buttonHeight);
        resortButton.tag = i + 100;
        
        NSString *resortNameStr = self.resortNameArray[i];
        
        [resortButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"add_city_btn_normal"] forState:UIControlStateNormal];
        [resortButton setTitle:resortNameStr forState:UIControlStateNormal];
        resortButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [resortButton setTitleColor:HCSColorWith(121, 126, 140) forState:UIControlStateNormal];
        
        [resortButton setBackgroundImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"add_city_btn_select"] forState:UIControlStateHighlighted];
        [resortButton setTitle:resortNameStr forState:UIControlStateHighlighted];
        [resortButton setTitleColor:HCSColorWith(63, 169, 226) forState:UIControlStateHighlighted];
        [hotResortView addSubview:resortButton];
        
    }
    
    

}

//model to SearchCityViewController
- (void)SearchCityViewControllermodel
{
    HCSearchCityViewController *seaechCityVC = [[HCSearchCityViewController alloc] init];
    
    seaechCityVC.view.backgroundColor = [UIColor cyanColor];
    
    [self presentViewController:seaechCityVC animated:NO completion:nil];

}

//不让这个控制器的键盘弹出
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.hcs_TextField endEditing:YES];
}


@end
