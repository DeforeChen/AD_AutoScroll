//
//  BannerWebViewController.h
//  ImatationDemo
//
//  Created by xututu on 16/8/10.
//  Copyright © 2016年 Defore Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface BannerWebViewController : UIViewController<WKNavigationDelegate>
-(instancetype)initWithURL:(NSString*)URLString;
@end
