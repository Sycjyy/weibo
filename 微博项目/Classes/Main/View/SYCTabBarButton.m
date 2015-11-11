//
//  SYCTabBarButton.m
//  微博项目
//
//  Created by sycjyy on 15/10/15.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCTabBarButton.h"
#import "SYCBadgeView.h"
#import "UIView+Frame.h"

#define SYCImageRidio 0.7

@interface SYCTabBarButton()

@property (nonatomic, weak) SYCBadgeView *badgeView;

@end
@implementation SYCTabBarButton

-(void)setHighlighted:(BOOL)highlighted{}

-(SYCBadgeView *)badgeView{
    if (_badgeView == nil) {
        SYCBadgeView *btn = [SYCBadgeView buttonWithType:UIButtonTypeCustom];
        //需要进行试验 strong 和weak
        [self addSubview:btn];
        _badgeView =btn;
    }
    return _badgeView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        //设置图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        //设置文字水平居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

-(void)setItem:(UITabBarItem *)item{
    _item = item;
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    // KVO：时刻监听一个对象的属性有没有改变
    // 给谁添加观察者
    // Observer:按钮
    
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    
}
// 只要监听的属性一有新值，就会调用
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    [self setTitle:_item.title forState:UIControlStateNormal];
    
    [self setImage:_item.image forState:UIControlStateNormal];
    
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
    self.badgeView.badgeValue = _item.badgeValue;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //1.imageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * SYCImageRidio;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    //2.title
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 3;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //3.badgeView
    self.badgeView.x = self.width - self.badgeView.width - 10;
    self.badgeView.y = 0;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
