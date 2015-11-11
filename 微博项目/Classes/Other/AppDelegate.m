//
//  AppDelegate.m
//  微博项目
//
//  Created by sycjyy on 15/10/13.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "AppDelegate.h"

#import "UIImageView+WebCache.h"

#import "SYCOAuthViewController.h"
#import "SYCRootTool.h"
#import "SYCAccountTool.h"


//封装思想：如果以后的项目中，有相同的功能，抽取一个类，封装好，如何封装，自己的事情全部交给自己管理。
//抽方法：一般一个功能就抽一个方法。
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //创建一个窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    
    //选择根控制器
    //判断有没有授权
    if ([SYCAccountTool account]) {
        [SYCRootTool chooseRootViewController:self.window];
    }else{
        SYCOAuthViewController *oauthVc = [[SYCOAuthViewController alloc] init];
        self.window.rootViewController = oauthVc;
    }
   
    [self.window makeKeyAndVisible];
 
    return YES;
}

//接收到内存警告的时候调用
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    
    //停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    //删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
