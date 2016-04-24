//
//  Dock.m
//  新浪微博
//
//  Created by qinglong on 16/3/1.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "Dock.h"
#import "Common.h"
#import "DockItem.h"

#define kBgImageName            @"tabbar_background"
#define kItemIndexDefault       0

@interface Dock ()
{
    DockItem *_selectedItem;
    NSMutableArray <DockItem *> *_itemArrayM;
}
@end


@implementation Dock

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _itemArrayM = [NSMutableArray array];
        
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kBgImageName]]];
    }
    
    return self;
}

- (void)addDockItem:(NSString *)name icon:(NSString *)icon selectedIcon:(NSString *)selectedIcon
{
    DockItem *item = [DockItem dockItemWithName:name icon:icon selectedIcon:selectedIcon];
    [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:item];
    [_itemArrayM addObject:item];
    
    NSInteger cnt = self.subviews.count;
    [item setTag:(cnt - 1)];
    
    WS(weakSelf);
    UIView *preView = nil;
    for (NSInteger i = 0; i < cnt; i++) {
        UIView *view = self.subviews[i];
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            make.width.equalTo(weakSelf).multipliedBy(1.0f/cnt);
            if (i == 0) {
                make.leading.equalTo(weakSelf);
            } else {
                make.leading.equalTo(preView.mas_trailing);
            }
                
            if (i == (cnt - 1)) {
                make.trailing.equalTo(weakSelf);
            }
            
        }];
        preView = view;
    }
    
    // 默认第一项被选择
    if (item.tag == kItemIndexDefault) {
        item.selected = YES;
        // 模拟点击事件
        [self clickItem:item];
    }
}

#pragma mark - 监听方法
#pragma mark 点击了选项
- (void)clickItem:(DockItem *)item
{
    if ((item.tag != _selectedItem.tag)
        || (_selectedItem == nil))
    {
        [_selectedItem setSelected:NO];
        [item setSelected:YES];
        
        if ([self.delegate respondsToSelector:@selector(dock:didSelectedFrom:to:)])
        {
            [self.delegate dock:self didSelectedFrom:_selectedItem.tag to:item.tag];
        }
        _selectedItem = item;
    }
}


@end
