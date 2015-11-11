//
//  SYCStatusCell.h
//  微博项目
//
//  Created by sycjyy on 15/11/4.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYCStatusFrame;
@interface SYCStatusCell : UITableViewCell

@property (nonatomic, strong) SYCStatusFrame *statusF;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
