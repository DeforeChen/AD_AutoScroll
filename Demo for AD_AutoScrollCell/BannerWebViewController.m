//
//  BannerWebViewController.m
//  ImatationDemo
//
//  Created by xututu on 16/8/10.
//  Copyright © 2016年 Defore Chen. All rights reserved.
//

#import "BannerWebViewController.h"

@interface BannerWebViewController ()
@property (nonatomic,strong) NSURL *BannerWebURL;
@end

@implementation BannerWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建webview，并设置大小，"20"为状态栏高度
    
    WKWebView *webView         = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    webView.navigationDelegate = self;
    // 2.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.BannerWebURL];
    // 3.加载网页
    [webView loadRequest:request];
    
    // 最后将webView添加到界面
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)initWithURL:(NSString*)URLString {
    self = [super init];
    if (self) {
        self.BannerWebURL = [NSURL URLWithString:URLString];
    }
    return self;
}

#pragma mark WKWebViewDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"加载中。。。");
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完毕");
}

@end
