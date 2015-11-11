//
//  SYCTitleButton.m
//  微博项目
//
//  Created by sycjyy on 15/10/16.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCTitleButton.h"
#import "UIImage+Image.h"
#import "UIView+Frame.h"
@implementation SYCTitleButton

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithStretchableName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.currentImage == nil) return;
    //title
    self.titleLabel.x = 0;
    //imageView
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}
// 重写setTitle方法，扩展计算尺寸功能
-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    
    [super setImage:image forState:state];
    
    [self sizeToFit];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
