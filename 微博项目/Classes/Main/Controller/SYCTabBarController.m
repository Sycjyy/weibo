//
//  SYCTabBarController.m
//  微博项目
//
//  Created by sycjyy on 15/10/15.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCTabBarController.h"
#import "UIImage+Image.h"
#import "SYCTabBar.h"

#import "SYCNavgationController.h"

#import "SYCHomeViewController.h"
#import "SYCMessageViewController.h"
#import "SYCDiscoverViewController.h"
#import "SYCProfileViewController.h"
#import "SYCComposeController.h"

#import "SYCUserTool.h"
#import "SYCUserResult.h"

@interface SYCTabBarController ()<SYCTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, weak) SYCHomeViewController *home;
@property (nonatomic, weak) SYCMessageViewController *message;
@property (nonatomic, weak) SYCProfileViewController *profile;
@end

@implementation SYCTabBarController

-(NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //添加所有的子控制器
    [self setUpAllChildViewController];
    
    //用自定义的tabBar
    [self setUpTabBar];
    
    // 每隔一段时间请求未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
}

- (void)requestUnread
{
    
    
    // 请求微博的未读数
    [SYCUserTool unreadWithSuccess:^(SYCUserResult *result) {
        
        // 设置首页未读数
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        
        // 设置消息未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        
        // 设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        
        // 设置应用程序所有的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totoalCount;
        
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)setUpTabBar{
    //替换系统的tabBar，用自定义的tabBar
    SYCTabBar *tabBar = [[SYCTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.delegate = self;
    
    tabBar.items = self.items;
    NSLog(@"%@",tabBar.items);
    [self.tabBar addSubview:tabBar];
    
//    [self.tabBar removeFromSuperview];
}
#pragma mark - 自定义tabbar代理
-(void)tabBar:(SYCTabBar *)tabBar didClickButton:(NSInteger)index{
    self.selectedIndex = index;
}
// 点击加号按钮的时候调用
- (void)tabBarDidClickPlusButton:(SYCTabBar *)tabBar
{
    // 创建发送微博控制器
    SYCComposeController *composeVc = [[SYCComposeController alloc] init];
    SYCNavgationController *nav = [[SYCNavgationController alloc] initWithRootViewController:composeVc];
    
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //为什么在这里移除系统的UITabBarButton，因为只有在viewWillAppear方法中才加载
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
    NSLog(@"%@",self.tabBar);
}

#pragma mark -添加所有的子控制器
-(void)setUpAllChildViewController{
    SYCHomeViewController *home = [[SYCHomeViewController alloc] init];
//    home.view.backgroundColor = [UIColor redColor];
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    _home = home;
    
    SYCMessageViewController *message = [[SYCMessageViewController alloc] init];
//    message.view.backgroundColor = [UIColor grayColor];
    [self setUpOneChildViewController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
   
    SYCDiscoverViewController *discover = [[SYCDiscoverViewController alloc] init];
//    discover.view.backgroundColor = [UIColor blackColor];
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    
    SYCProfileViewController *profile = [[SYCProfileViewController alloc] init];
//    profile.view.backgroundColor = [UIColor blueColor];
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    
}

-(void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)seletedImage title:(NSString *)title{
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = seletedImage;
    
    [self.items addObject:vc.tabBarItem];
    //创建导航控制器的根控制器为Vc
    SYCNavgationController *nav = [[SYCNavgationController alloc] initWithRootViewController:vc];

    [self addChildViewController:nav];
}


@end
