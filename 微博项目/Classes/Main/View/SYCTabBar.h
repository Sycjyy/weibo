//
//  SYCTabBar.h
//  微博项目
//
//  Created by sycjyy on 15/10/15.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYCTabBar;
@protocol SYCTabBarDelegate <NSObject>

@optional
-(void)tabBar:(SYCTabBar *)tabBar didClickButton:(NSInteger)index;

/**
 *  点击加号按钮的时候调用
 */
- (void)tabBarDidClickPlusButton:(SYCTabBar *)tabBar;

@end

@interface SYCTabBar : UIView

@property (nonatomic, strong)NSArray *items;
@property (nonatomic, weak)id<SYCTabBarDelegate> delegate;

@end
