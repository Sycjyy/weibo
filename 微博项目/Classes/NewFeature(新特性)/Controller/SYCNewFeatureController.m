//
//  SYCNewFeatureController.m
//  微博项目
//
//  Created by sycjyy on 15/10/17.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCNewFeatureController.h"
#import "SYCNewFeatureCell.h"

@interface SYCNewFeatureController ()

@property (nonatomic, weak)UIPageControl *pageControl;
@end

@implementation SYCNewFeatureController

static NSString *ID = @"cell";

-(instancetype)init{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    
    layout.minimumLineSpacing = 0;
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
     return [super initWithCollectionViewLayout:layout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    self.collectionView.backgroundColor = [UIColor greenColor];
    
    //注册cell
    [self.collectionView registerClass:[SYCNewFeatureCell class] forCellWithReuseIdentifier:ID];
    //分页
    self.collectionView.pagingEnabled = YES;
    //没有弹性
    self.collectionView.bounces = NO;
    //水平滚条消失
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //添加pageControl
    [self setUpPageControl];
}

-(void)setUpPageControl{
    
    UIPageControl *control = [[UIPageControl alloc] init];
    
    control.numberOfPages = 4;
    control.pageIndicatorTintColor = [UIColor blackColor];
    control.currentPageIndicatorTintColor = [UIColor redColor];
    
    control.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height);
    
    _pageControl = control;
    
    [self.view addSubview:control];
}

#pragma mark - scrollView的代理
//只要一滚动就会调用这个方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // 获取当前的偏移量，计算当前第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    _pageControl.currentPage = page;
    
}

#pragma mark - collectionView的 数据源 代理
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SYCNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor yellowColor];
    
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row + 1];
    if (screenH > 480) {
        imageName = [NSString stringWithFormat:@"new_feature_%ld-568h",indexPath.row + 1];
    }
    
    cell.image = [UIImage imageNamed:imageName];
    [cell setIndexPath:indexPath count:4];
    
    return cell;
}

@end
