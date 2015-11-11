//
//  SYCRootTool.m
//  微博项目
//
//  Created by sycjyy on 15/10/18.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCRootTool.h"

#import "SYCTabBarController.h"
#import "SYCNewFeatureController.h"
#define SYCVersionKey @"version"

@implementation SYCRootTool

+(void)chooseRootViewController:(UIWindow *)window{
    // 1.获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    //2.获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:SYCVersionKey];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        //创建一个tabBar控制器
        SYCTabBarController *tabBarVc = [[SYCTabBarController alloc] init];
        tabBarVc.view.backgroundColor = [UIColor whiteColor];
        //设置根控制器并可见
        window.rootViewController = tabBarVc;
    }else{
        SYCNewFeatureController *newVc = [[SYCNewFeatureController alloc] init];
        window.rootViewController = newVc;
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:SYCVersionKey];
    }
}
@end
