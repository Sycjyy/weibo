//
//  SYCStatusCell.m
//  微博项目
//
//  Created by sycjyy on 15/11/4.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCStatusCell.h"
#import "SYCOriginalView.h"
#import "SYCRetweetView.h"
#import "SYCStatusToolBar.h"

#import "SYCStatusFrame.h"
#import "SYCStatus.h"


@interface SYCStatusCell()

@property (nonatomic, weak) SYCOriginalView *originalView;

@property (nonatomic, weak) SYCRetweetView *retweetView;

@property (nonatomic, weak) SYCStatusToolBar *toolBar;

@end

@implementation SYCStatusCell

// 注意：cell是用initWithStyle初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加所有的控件
        [self setUpAllChildView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
#pragma mark - 添加所有子控件
-(void)setUpAllChildView{
    //添加原创微博
    SYCOriginalView *originalView = [[SYCOriginalView alloc] init];
    [self addSubview:originalView];
    _originalView = originalView;
    
    //添加转发微博
    SYCRetweetView *retweetView = [[SYCRetweetView alloc] init];
    [self addSubview:retweetView];
    _retweetView = retweetView;
    
    //添加工具条
    SYCStatusToolBar *toolBar = [[SYCStatusToolBar alloc] init];
    [self addSubview:toolBar];
    _toolBar = toolBar;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


- (void)setStatusF:(SYCStatusFrame *)statusF
{
    _statusF = statusF;
    
    // 设置原创微博frame
    _originalView.frame = statusF.originalViewFrame;
    _originalView.statusF = statusF;
    
    if (statusF.status.retweeted_status) {
        
        // 设置转发微博frame
        _retweetView.frame = statusF.retweetViewFrame;
        _retweetView.statusF = statusF;
        _retweetView.hidden = NO;
    }else{
        _retweetView.hidden = YES;
    }
    
    // 设置工具条frame
    _toolBar.frame = statusF.toolBarFrame;
    _toolBar.status = statusF.status;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
