//
//  SYCPopMenu.m
//  微博项目
//
//  Created by sycjyy on 15/10/17.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCPopMenu.h"
#import "UIImage+Image.h"



@implementation SYCPopMenu


+(instancetype)showInRect:(CGRect)rect{
    
    SYCPopMenu *menu = [[SYCPopMenu alloc] initWithFrame:rect];
    menu.userInteractionEnabled = YES;
    menu.image = [UIImage imageWithStretchableName:@"popover_background"];
    
    [[UIApplication sharedApplication].keyWindow addSubview:menu];
    
    return menu;
}

+(void)hide{
    UIView *share = [UIApplication sharedApplication].keyWindow;
    for (UIView *popMenu in share.subviews) {
        if ([popMenu isKindOfClass:self]) {
            [popMenu removeFromSuperview];
        }
    }
}

-(void)setContentView:(UIView *)contentView{
    
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    contentView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:contentView];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.frame.size.width - 2 * margin;
    CGFloat h = self.frame.size.height - y;
    
    _contentView.frame = CGRectMake(x, y, w, h);
}
@end
