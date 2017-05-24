//
//  HCSWebViewController.m
//  BaiSiBuDeJie
//
//  Created by 黄灿森 on 16/5/3.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSWebViewController.h"
#import <WebKit/WebKit.h>
#import <SVProgressHUD/SVProgressHUD.h>

//网页加载进度Key
static NSString * const webProgressKey = @"estimatedProgress";
//监听title Key
static NSString * const webTitleKey = @"title";
//监听canGoBack Key
static NSString * const webCanGoBackKey = @"canGoBack";
//监听canGoForward Key
static NSString * const webCanGoForwardKey = @"canGoForward";

@interface HCSWebViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *gobackButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goforwarkButton;

@property (weak, nonatomic) IBOutlet UIView *webView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic,weak) WKWebView *webSeeView;
@end

@implementation HCSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    [SVProgressHUD showWithStatus:@"加载网页中..."];
    
    WKWebView *webSeeView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    
    _webSeeView = webSeeView;
    
    [self.webView addSubview:webSeeView];
    
//    //设置自适应网页
//    self.webView.scalesPageToFit = YES;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    
    // 加载网页
    [webSeeView loadRequest:request];
    
    CGFloat bottomItemBarHeight = 44;
    
    _webSeeView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, bottomItemBarHeight, 0);
    
    [webSeeView sizeToFit];
    
    // 监听网页加载进度 KVO
    [webSeeView addObserver:self forKeyPath:webProgressKey options:NSKeyValueObservingOptionNew context:nil];
    
    // 监听title  KVO
    [webSeeView addObserver:self forKeyPath:webTitleKey options:NSKeyValueObservingOptionNew context:nil];
    
    // 监听canGoBack  KVO
    [webSeeView addObserver:self forKeyPath:webCanGoBackKey options:NSKeyValueObservingOptionNew context:nil];
    
    // 监听canGoForward  KVO
    [webSeeView addObserver:self forKeyPath:webCanGoForwardKey options:NSKeyValueObservingOptionNew context:nil];
    
}

#pragma mark - goback
- (IBAction)goback:(id)sender {
    [_webSeeView goBack];
}

#pragma mark - goforwark
- (IBAction)goforward:(id)sender {
    [_webSeeView goForward];
}

#pragma mark - refresh
- (IBAction)refresh:(id)sender {
    [_webSeeView reload];
}

#pragma mark - 观察的值有新值 就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
   
    _progressView.progress = _webSeeView.estimatedProgress;
    _progressView.hidden = _webSeeView.estimatedProgress >= 1;
    if (_progressView.hidden) {
        [SVProgressHUD dismiss];
    }
    
    self.title = _webSeeView.title;

    self.gobackButton.enabled = _webSeeView.canGoBack;
    self.goforwarkButton.enabled = _webSeeView.canGoForward;
}

#pragma mark - dealloc方法中 注意：KVO一定要记得移除
- (void)dealloc
{
    [SVProgressHUD dismiss];
    [_webSeeView removeObserver:self forKeyPath:webProgressKey];
    [_webSeeView removeObserver:self forKeyPath:webTitleKey];
    [_webSeeView removeObserver:self forKeyPath:webCanGoBackKey];
    [_webSeeView removeObserver:self forKeyPath:webCanGoForwardKey];
    
}



@end
