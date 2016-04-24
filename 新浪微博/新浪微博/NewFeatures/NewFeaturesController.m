//
//  NewFeaturesController.m
//  新浪微博
//
//  Created by qinglong on 16/2/22.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "NewFeaturesController.h"
#import <Masonry.h>
#import "Common.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "OauthController.h"
#import "OauthAccountTool.h"
#import "UIImage+Ext.h"

#define kImageCnt   4

@interface NewFeaturesController ()

@end

@implementation NewFeaturesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat w = self.view.bounds.size.width;
    CGFloat h = self.view.bounds.size.height;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setPagingEnabled:YES];
    [scrollView setBounces:NO];
    scrollView.frame = self.view.frame;
    [scrollView setContentSize:CGSizeMake(kImageCnt * w, h)];
    [self.view addSubview:scrollView];
    
    for (NSInteger i = 0; i < kImageCnt; i++) {
        NSString *imageName = [NSString stringWithFormat:@"new_features_%ld", i];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [imageView setFrame:CGRectMake(w * i, 0, w, h)];
        [scrollView addSubview:imageView];
        
        if (i == (kImageCnt - 1)) {
            // !!! UIImageView默认不响应用户交互，由于传递性，其子控件也会不响应用户交互
            // 所以要想UIImageView上的按钮能响应，需要设置一下使imageView能响应用户交互
            [imageView setUserInteractionEnabled:YES];
            
            UIButton *startBtn = [[UIButton alloc] init];
            [startBtn setTitle:@"立即体验" forState:UIControlStateNormal];
            [startBtn.titleLabel setFont:[UIFont systemFontOfSize:25.0f weight:1.5f]];
            [startBtn setBackgroundImage:[UIImage resizedImage:@"new_features_startbutton_background"]
                                forState:UIControlStateNormal];
            [startBtn setBackgroundImage:[UIImage resizedImage:@"new_features_startbutton_background_highlighted"]
                                forState:UIControlStateHighlighted];
            [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:startBtn];
            [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(imageView);
                make.width.equalTo(imageView).multipliedBy(0.6f);
                make.height.equalTo(imageView).multipliedBy(0.08f);
                make.centerY.equalTo(imageView).multipliedBy(1.7f);
            }];
            
            UIButton *shareBtn = [[UIButton alloc] init];
            [shareBtn setAdjustsImageWhenHighlighted:NO];
            [shareBtn setTitle:@"发微博分享给好友" forState:UIControlStateNormal];
            [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [shareBtn setImage:[UIImage imageNamed:@"new_features_checkbox"] forState:UIControlStateNormal];
            [shareBtn setImage:[UIImage imageNamed:@"new_features_checkbox_checked"] forState:UIControlStateSelected];
            [shareBtn setSelected:YES];
            [shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:shareBtn];
            [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(startBtn);
                make.bottom.equalTo(startBtn.mas_top).offset(-5.0f);
                make.width.height.equalTo(startBtn);
            }];
        }
    }
}

#pragma mark - 监听方法
#pragma mark 立即体验
- (void)start
{
    UIViewController *controller = nil;
    OauthAccount *account = [OauthAccountTool oauthAccount];
    if (account == nil) {
        controller = [[OauthController alloc] init];
    } else {
        controller = [[MainViewController alloc] init];
    }
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.window setRootViewController:controller];
}

#pragma mark 发微博分享给好友
- (void)share:(UIButton *)btn
{
    btn.selected = !btn.selected;
}


@end
