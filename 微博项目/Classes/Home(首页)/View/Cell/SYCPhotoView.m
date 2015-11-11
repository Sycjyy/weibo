//
//  SYCPhotoView.m
//  微博项目
//
//  Created by sycjyy on 15/11/7.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCPhotoView.h"
#import "SYCPhoto.h"
#import "UIImageView+WebCache.h"

@interface SYCPhotoView ()

@property (nonatomic, weak) UIImageView *gifView;

@end
@implementation SYCPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 裁剪图片，超出控件的部分裁剪掉
        self.clipsToBounds = YES;
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        _gifView = gifView;
    }
    
    return self;
}

- (void)setPhoto:(SYCPhoto *)photo
{
    _photo = photo;
    
    // 赋值
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 判断下是否显示gif
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
}



@end
