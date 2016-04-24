//
//  GroupCell.m
//  新浪微博
//
//  Created by qinglong on 16/3/25.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import "GroupCell.h"
#import <Masonry.h>
#import "Common.h"

@implementation GroupCell

#pragma mark 设置单元格类型
- (void)setCellType:(GroupCellType)type
{
    _cellType = type;
    
    switch (type) {
        case kGroupCellTypeNone:
            self.accessoryView = nil;
            break;
        case kGroupCellTypeIndicator:
            self.accessoryView = nil;
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case kGroupCellTypeRightLabel: {
            if (_rightLabel == nil) {
                UILabel *label = [[UILabel alloc] init];
                [label setAdjustsFontSizeToFitWidth:YES];
                [label setTextAlignment:NSTextAlignmentRight];
                [label setBounds:CGRectMake(0, 0, self.bounds.size.width * 0.15f, self.bounds.size.height)];
                self.accessoryView = label;
                _rightLabel = label;
            } else {
                self.accessoryView = _rightLabel;
            }
            break;
        }
        case kGroupCellTypeRightSwitch: {
            if (_rightSwitch == nil) {
                UISwitch *sw = [[UISwitch alloc] init];
                [sw setOn:YES];
                [sw setBounds:CGRectMake(0, 0, self.bounds.size.width * 0.15f, self.bounds.size.height * 0.8f)];
                self.accessoryView = sw;
                _rightSwitch = sw;
            } else {
                self.accessoryView = _rightSwitch;
            }
            break;
        }
        default:
            break;
    }
}

@end
