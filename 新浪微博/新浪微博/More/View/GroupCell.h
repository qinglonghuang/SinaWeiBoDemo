//
//  GroupCell.h
//  新浪微博
//
//  Created by qinglong on 16/3/25.
//  Copyright © 2016年 qinglong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GroupCellType) {
    kGroupCellTypeNone = 0,
    kGroupCellTypeIndicator,
    kGroupCellTypeRightLabel,
    kGroupCellTypeRightSwitch,
};

@interface GroupCell : UITableViewCell

@property (assign, nonatomic) GroupCellType cellType;

@property (weak, nonatomic) UILabel *rightLabel;

@property (weak, nonatomic) UISwitch *rightSwitch;

/**
 *  设置单元格类型
 *
 *  @param type 类型
 */
- (void)setCellType:(GroupCellType)type;

@end
