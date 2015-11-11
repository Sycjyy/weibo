//
//  SYCTabBar.m
//  微博项目
//
//  Created by sycjyy on 15/10/15.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCTabBar.h"
#import "SYCTabBarButton.h"

@interface SYCTabBar()

@property (nonatomic, weak)UIButton *plusButton;

@property (nonatomic, strong)NSMutableArray *buttons;

@property (nonatomic, weak)UIButton *selectedButton;
@end
@implementation SYCTabBar

-(NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
-(void)setItems:(NSArray *)items{
    _items = items;
    
    for (UITabBarItem *item in _items) {
        SYCTabBarButton *btn = [SYCTabBarButton buttonWithType:UIButtonTypeCustom];
        btn.item = item;
        btn.tag = self.buttons.count;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (btn.tag == 0) {
            [self btnClick:btn];
        }
        [self addSubview:btn];
        
        [self.buttons addObject:btn];
    }
}

-(void)btnClick:(UIButton *)btn{
    _selectedButton.selected = NO;
    btn.selected = YES;
    _selectedButton = btn;
    
    // 通知tabBarVc切换控制器，
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:btn.tag];
    }
}

-(UIButton *)plusButton{
    if (_plusButton == nil) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        _plusButton = btn;
        [self addSubview:_plusButton];
    }
    return _plusButton;
}

#pragma mark - 点击加号按钮的时候调用
- (void)plusClick
{
    // modal出控制器
    if ([_delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [_delegate tabBarDidClickPlusButton:self];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat btnW = w / (self.items.count + 1);
    CGFloat btnH = self.bounds.size.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    int i = 0;
    for (UIView *tabBarButton in self.subviews) {
        //subviews中不全是UITabBarButton，所以需要进行对比
        //UITabBarButton是私有API，要用字符串映射的方式
        if ([tabBarButton isKindOfClass:NSClassFromString(@"SYCTabBarButton")]) {
            if (i == 2) {
                i = 3;
            }
            btnX = i * btnW;
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i++;
        }
        
    }
    self.plusButton.center = CGPointMake(0.5 * w, 0.5 * btnH);
}




@end
