//
//  OauthController.m
//  新浪微博
//
//  Created by qinglong on 16/3/27.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "OauthController.h"
#import "Common.h"
#import "OauthConfig.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import <MBProgressHUD.h>
#import "OauthAccountTool.h"


@interface OauthController () <UIWebViewDelegate>
{
    UIWebView *_webView;
}

@end

@implementation OauthController

- (void)loadView
{
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_webView setDelegate:self];
    self.view = _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&display=mobile", \
                                       kAuthorizeUrl, kAppKey, kRedirectUri]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

#pragma mark 跳转回主页面
- (void)p_jumpToMainViewController
{
    MainViewController *mainController = [[MainViewController alloc] init];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.window setRootViewController:mainController];
}

#pragma mark - 代理方法
#pragma mark 开始加载页面
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType != UIWebViewNavigationTypeLinkClicked) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"正在加载哦";
        hud.dimBackground = YES;
    }
    
    NSString *url = [request.URL.absoluteString copy];
    if ([url containsString:kRedirectUri]) {
        NSRange codeR = [url rangeOfString:@"code="];
        if (codeR.length > 0) {
            NSRange tokenR = NSMakeRange(codeR.location + codeR.length, url.length - (codeR.location + codeR.length));
            NSString *requestToken = [url substringWithRange:tokenR];
            NSLog(@"token:%@", requestToken);
            
            NSDictionary *dict = @{@"client_id":kAppKey,
                                   @"client_secret":kAppSecret,
                                   @"grant_type":@"authorization_code",
                                   @"code":requestToken,
                                   @"redirect_uri":kRedirectUri};
            
            WS(weakSelf);
            [HQLHttpUtils POST:kAccessTokenUrl
                    parameters:dict
                       success:^(id  _Nullable responseObject)
            {
                OauthAccount *account = [OauthAccount objectFromJSONData:responseObject];
                NSLog(@"AccessToken请求成功account:%@", account);
                [OauthAccountTool saveOauthAccount:account];
                [weakSelf p_jumpToMainViewController];
            }
                       failure:^(NSError * _Nonnull error)
            {
                NSLog(@"AccessToken请求失败 %@", error.localizedDescription);
            }];
        }
    }
    
    return YES;
}

#pragma mark 加载页面结束
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)dealloc
{
    NSLog(@"OauthController dealloc!!!");
}

@end
