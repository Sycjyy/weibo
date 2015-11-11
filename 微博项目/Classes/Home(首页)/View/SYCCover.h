//
//  SYCCover.h
//  微博项目
//
//  Created by sycjyy on 15/10/17.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYCCover;
@protocol SYCCoverDelegate <NSObject>

@optional
-(void)coverDidClickCover:(SYCCover *)cover;

@end

@interface SYCCover : UIView
/*
 *显示蒙板
 */
+(instancetype)show;

@property (nonatomic, assign) BOOL dimBackground;
@property (nonatomic, weak) id <SYCCoverDelegate> delegate;

@end
