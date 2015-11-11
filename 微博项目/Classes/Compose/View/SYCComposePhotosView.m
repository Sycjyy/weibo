//
//  SYCComposePhotosView.m
//  微博项目
//
//  Created by sycjyy on 15/11/10.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCComposePhotosView.h"

@implementation SYCComposePhotosView

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
}

// 每添加一个子控件的时候也会调用，特殊如果在viewDidLoad添加子控件，就不会调用layoutSubviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    NSInteger cols = 3;
    CGFloat marign = 10;
    CGFloat wh = (self.width - (cols - 1) * marign) / cols;
    
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger col = 0;
    NSInteger row = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIImageView *imageV = self.subviews[i];
        col = i % cols;
        row = i / cols;
        x = col * (marign + wh);
        y = row * (marign + wh);
        imageV.frame = CGRectMake(x, y, wh, wh);
    }
    
}


@end
