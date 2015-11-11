//
//  SYCHomeViewController.m
//  微博项目
//
//  Created by sycjyy on 15/10/15.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCHomeViewController.h"
#import "UIBarButtonItem+Item.h"
#import "SYCTitleButton.h"
#import "SYCCover.h"
#import "SYCPopMenu.h"

#import "SYCOneViewController.h"
#import "SYCTwoViewController.h"

#import "SYCStatusFrame.h"
#import "SYCStatus.h"
#import "SYCStatusTool.h"
#import "SYCStatusCell.h"
#import "SYCUserTool.h"
#import "SYCAccountTool.h"
#import "SYCAcconut.h"

#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJRefresh.h"

@interface SYCHomeViewController ()<SYCCoverDelegate>

@property (nonatomic, weak)SYCTitleButton *titleButton;

@property (nonatomic, strong)SYCOneViewController *one;

@property (nonatomic, strong)NSMutableArray *statusFrames;
@end

@implementation SYCHomeViewController

-(NSMutableArray *)statusFrames{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}
-(SYCOneViewController *)one{
    if (_one == nil) {
        _one = [[SYCOneViewController alloc] init];
    }
    return _one;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBar];
    
    [self loadNewStauts];
    
    //添加下拉刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStauts)];
    
    [self.tableView headerBeginRefreshing];
    
    //添加上拉刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStauts)];
    
    // 请求当前用户的昵称
    [SYCUserTool userInfoWithSuccess:^(SYCUser *user) {
        
        // 请求当前账号的用户信息
        // 设置导航条的标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        // 获取当前的账号
        SYCAcconut *account = [SYCAccountTool account];
        account.name = user.name;
        
        // 保存用户的名称
        [SYCAccountTool saveAccount:account];
        
        
    } failure:^(NSError *error) {
        
    }];

    
}

-(void)loadMoreStauts{
    
    NSString *maxIdStr = nil;
    if (self.statusFrames.count) {
        SYCStatus *s = [[self.statusFrames lastObject] status];
        long long maxId = [s.idstr longLongValue] -1;
        maxIdStr =[NSString stringWithFormat:@"%lld",maxId];
    }
    
    [SYCStatusTool moreStatusWithMaxId:maxIdStr success:^(NSArray *statuses) {
        
        [self.tableView footerEndRefreshing];
        
        NSMutableArray *statusFrame = [NSMutableArray array];
        for (SYCStatus *status in statuses) {
            SYCStatusFrame *statusF = [[SYCStatusFrame alloc] init];
            statusF.status = status;
            [statusFrame addObject:statusF];
        }
        
        [self.statusFrames addObjectsFromArray:statusFrame];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - 加载最新数据
-(void)loadNewStauts{
    
    NSString *sinceId = nil;
    if (self.statusFrames.count) {
        SYCStatus *status = [self.statusFrames[0] status];
        sinceId = status.idstr;
        
    }
    
    [SYCStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statuses) {
        
        [self showNewStatusCount:statuses.count];

       
        [self.tableView headerEndRefreshing];
        
        // 模型转换视图模型 SYCStatus -> SYCStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (SYCStatus *status in statuses) {
            SYCStatusFrame *statusF = [[SYCStatusFrame alloc] init];
            statusF.status = status;
            [statusFrames addObject:statusF];
        }
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        //把最新的微博数插入到最前面
        [self.statusFrames insertObjects:statusFrames atIndexes:indexSet];
        
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    }];
}

#pragma mark - 展示最新的微博数
-(void)showNewStatusCount:(int)count
{
    if (count == 0) return;
    
    // 展示最新的微博数
    CGFloat h = 35;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    CGFloat x = 0;
    CGFloat w = self.view.width;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"最新微博数%d",count];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    // 插入导航控制器下导航条下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 动画往下面平移
    [UIView animateWithDuration:0.25 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, h);
        
    } completion:^(BOOL finished) {
        
        
        // 往上面平移
        [UIView animateWithDuration:0.25 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            
            // 还原
            label.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }];
    
}

#pragma mark - 添加导航栏
-(void)setupNavgationBar{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    SYCTitleButton *titleButton = [SYCTitleButton buttonWithType:UIButtonTypeCustom];
    self.titleButton = titleButton;
    NSString *title = [SYCAccountTool account].name?[SYCAccountTool account].name:@"首页";
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    
    // 高亮的时候不需要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}

-(void)titleClick:(UIButton *)button{
    button.selected = !button.selected;
    
    SYCCover *cover = [SYCCover show];
    cover.delegate = self;
    
    // 弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.frame.size.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    SYCPopMenu *menu = [SYCPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView =self.one.view;
    
}

-(void)coverDidClickCover:(SYCCover *)cover{
    [SYCPopMenu hide];
    self.titleButton.selected = NO;
}

-(void)pop{
    
    SYCTwoViewController *pop = [[SYCTwoViewController alloc] initWithNibName:nil bundle:nil];
    //当push的时候就会隐藏底部条
    //注意的是：前提条件为系统自带的tabbar
    pop.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:pop animated:YES];
    NSLog(@"next controller");
}

-(void)friendsearch{
    NSLog(@"hello");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SYCStatusCell *cell = [SYCStatusCell cellWithTableView:tableView];
    SYCStatusFrame *statusF = self.statusFrames[indexPath.row];
    
    cell.statusF = statusF;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYCStatusFrame *statusF = self.statusFrames[indexPath.row];
    
    return statusF.cellHeight;
}




@end
