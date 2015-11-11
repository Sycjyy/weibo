//
//  SYCNewFeatureCell.m
//  微博项目
//
//  Created by sycjyy on 15/10/17.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCNewFeatureCell.h"
#import "SYCTabBarController.h"
#import "UIView+Frame.h"

@interface SYCNewFeatureCell()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UIButton *shareButton;

@property (nonatomic, weak) UIButton *startButton;

@end

@implementation SYCNewFeatureCell

-(UIButton *)shareButton{
    
    if (_shareButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        btn.userInteractionEnabled = YES;
        [btn sizeToFit];
        
        [self.contentView addSubview:btn];
        _shareButton = btn;
        
    }
    return _shareButton;
}

-(UIButton *)startButton{
    
    if (_startButton == nil) {
        
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [startBtn sizeToFit];
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:startBtn];
        _startButton = startBtn;
    }
    return _startButton;
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        
        _imageView = imageV;
        //注意： tableView 和 collectionView添加控件时 一定要加载到contentView 上面
        [self.contentView addSubview:imageV];
    }
    
    return _imageView;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    self.shareButton.center = CGPointMake(self.width * 0.5, self.height * 0.8);
    
    self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.9);
}

-(void)setImage:(UIImage *)image{
    
    _image = image;
    
    self.imageView.image = image;
}

// 判断当前cell是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    if (indexPath.row == count - 1) { // 最后一页,显示分享和开始按钮
        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
        
        
    }else{ // 非最后一页，隐藏分享和开始按钮
        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }
}

-(void)start{
   
    SYCTabBarController *tabBar = [[SYCTabBarController alloc] init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
    
}

@end
