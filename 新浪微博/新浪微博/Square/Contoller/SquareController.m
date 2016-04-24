//
//  SquareController.m
//  新浪微博
//
//  Created by qinglong on 16/3/6.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "SquareController.h"
#import <Masonry.h>
#import "Common.h"

@interface SquareController ()
{
    UILabel *_label;
}
@end

@implementation SquareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"广场"];
    [self.view setBackgroundColor:[UIColor purpleColor]];
    
    WS(weakSelf);
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitle:@"连接状态" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.view).offset(15.0f);
        make.width.equalTo(weakSelf.view).multipliedBy(0.3f);
        make.height.equalTo(@40);
        make.top.equalTo(weakSelf.view).offset(150.0f);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"飞机状态:已连接\n相机状态:已连接\n图传状态:已连接"];
    [label setBackgroundColor:[UIColor lightGrayColor]];
    [label setNumberOfLines:0];
    [label setAdjustsFontSizeToFitWidth:YES];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.width.equalTo(weakSelf.view).multipliedBy(0.7f);
        make.height.equalTo(weakSelf.view).multipliedBy(0.2f);
    }];
//    [label setHidden:YES];
    _label = label;
    CGAffineTransform trans = CGAffineTransformMakeScale(0, 0);
    [_label setTransform:trans];
}

- (void)touchDown
{
    NSLog(@"touch down");

    [_label.layer removeAllAnimations];
    [_label setHidden:NO];
    [UIView animateWithDuration:0.5f animations:^{
        CGAffineTransform trans = CGAffineTransformMakeScale(1, 1);
        [_label setTransform:trans];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView commitAnimations];
}

- (void)touchUpInside
{
    NSLog(@"touch up inside");
    [UIView animateWithDuration:0.6f animations:^{
        CGAffineTransform trans = CGAffineTransformMakeScale(0.01, 0.01);
        [_label setTransform:trans];
    } completion:^(BOOL finished) {
        [_label setHidden:YES];
    }];
}


@end
