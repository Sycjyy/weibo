//
//  SYCPopMenu.h
//  微博项目
//
//  Created by sycjyy on 15/10/17.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYCPopMenu : UIImageView
/*
 *显示弹出菜单
 */
+(instancetype)showInRect:(CGRect)rect;

/**
 *  隐藏弹出菜单
 */
+(void)hide;

//内容视图
@property (nonatomic, weak)UIView *contentView;
@end
