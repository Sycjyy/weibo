//
//  SYCComposeToolBar.h
//  微博项目
//
//  Created by sycjyy on 15/11/10.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYCComposeToolBar;
@protocol SYCComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(SYCComposeToolBar *)toolBar didClickBtn:(NSInteger)index;

@end

@interface SYCComposeToolBar : UIView

@property (nonatomic, weak) id <SYCComposeToolBarDelegate> delegate;
@end
