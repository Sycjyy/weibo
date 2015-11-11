//
//  SYCNavgationController.m
//  微博项目
//
//  Created by sycjyy on 15/10/15.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCNavgationController.h"
#import "UIBarButtonItem+Item.h"


@interface SYCNavgationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong)id popDelegate;
@end

@implementation SYCNavgationController

+(void)initialize{
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *titleDic = [NSMutableDictionary dictionary];
    titleDic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:titleDic forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _popDelegate =self.interactivePopGestureRecognizer.delegate;
    //
    self.interactivePopGestureRecognizer.delegate = nil;
    // Do any additional setup after loading the view.
    
}

//导航控制器跳转完成的时候调用
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (viewController == self.viewControllers[0]) {
        //
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else{
        
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSLog(@"%ld",self.viewControllers.count);
    
    if (self.viewControllers.count != 0) {
        //左边
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
        //右边
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
    }
    [super pushViewController:viewController animated:animated];
    
    
}

-(void)backToPre{
    [self popViewControllerAnimated:YES];
}

-(void)backToRoot{
    
    [self popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
