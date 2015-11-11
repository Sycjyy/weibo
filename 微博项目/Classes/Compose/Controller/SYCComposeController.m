//
//  SYCComposeController.m
//  微博项目
//
//  Created by sycjyy on 15/11/10.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCComposeController.h"

#import "SYCTextView.h"
#import "SYCComposeToolBar.h"
#import "SYCComposePhotosView.h"
#import "SYCComposeTool.h"
#import "MBProgressHUD+MJ.h"

@interface SYCComposeController ()<SYCComposeToolBarDelegate,UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, weak) SYCTextView *textView;
@property (nonatomic, weak) SYCComposeToolBar *toolBar;
@property (nonatomic, weak) SYCComposePhotosView *photosView;
@property (nonatomic, strong) UIBarButtonItem *rightItem;

@property (nonatomic, strong) NSMutableArray *images;


@end

@implementation SYCComposeController

- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航条
    [self setUpNavgationBar];
    
    // 添加textView
    [self setUpTextView];
    
    // 添加工具条
    [self setUpToolBar];
    
    // 监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 添加相册视图
    [self setUpPhotosView];
    
}
// 添加相册视图
- (void)setUpPhotosView
{
    SYCComposePhotosView *photosView = [[SYCComposePhotosView alloc] initWithFrame:CGRectMake(0, 70, self.view.width, self.view.height - 70)];
    _photosView = photosView;
    [_textView addSubview:photosView];
}

#pragma mark - 键盘的Frame改变的时候调用
- (void)keyboardFrameChange:(NSNotification *)note
{
    
    // 获取键盘弹出的动画时间
    CGFloat durtion = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 获取键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (frame.origin.y == self.view.height) { // 没有弹出键盘
        [UIView animateWithDuration:durtion animations:^{
            
            _toolBar.transform =  CGAffineTransformIdentity;
        }];
    }else{ // 弹出键盘
        // 工具条往上移动258
        [UIView animateWithDuration:durtion animations:^{
            
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
    
}

- (void)setUpToolBar
{
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    SYCComposeToolBar *toolBar = [[SYCComposeToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.width, h)];
    _toolBar = toolBar;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
}

#pragma mark - 点击工具条按钮的时候调用
- (void)composeToolBar:(SYCComposeToolBar *)toolBar didClickBtn:(NSInteger)index
{
    
    if (index == 0) { // 点击相册
        // 弹出系统的相册
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // 设置相册类型,相册集
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }
}

#pragma mark - 选择图片完成的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 获取选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.images addObject:image];
    _photosView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    _rightItem.enabled = YES;
}


#pragma mark - 添加textView
- (void)setUpTextView
{
    SYCTextView *textView = [[SYCTextView alloc] initWithFrame:self.view.bounds];
    _textView = textView;
    // 设置占位符
    textView.placeHolder = @"abc";
    textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:textView];
    
    // 默认允许垂直方向拖拽
    textView.alwaysBounceVertical = YES;
    
    // 监听文本框的输入
    /**
     *  Observer:谁需要监听通知
     *  name：监听的通知的名称
     *  object：监听谁发送的通知，nil:表示谁发送我都监听
     *
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    
    // 监听拖拽
    _textView.delegate = self;
}

#pragma mark - 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark - 文字改变的时候调用
- (void)textChange
{
    // 判断下textView有木有内容
    if (_textView.text.length) { // 有内容
        _textView.hidePlaceHolder = YES;
        _rightItem.enabled = YES;
    }else{
        _textView.hidePlaceHolder = NO;
        _rightItem.enabled = NO;
        
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_textView becomeFirstResponder];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUpNavgationBar
{
    self.title = @"发微博";
    
    // left
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(dismiss)];
    
    // right
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    
    // 监听按钮点击
    [btn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    
    rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
    _rightItem = rightItem;
}

// 发送微博
- (void)compose
{
    
    if (self.images.count) { // 发送图片
        
        // 发送图片
        [self sendPicture];
        
    }else{
        
        // 发送文字
        [self sendTitle];
    }
    
}

#pragma mark - 发送图片
- (void)sendPicture
{
    UIImage *image = self.images[0];
    
    NSString *status = _textView.text.length?_textView.text:@"分享图片";
    
    _rightItem.enabled = NO;
    // 我引用你，你引用我
    [SYCComposeTool composeWithStatus:status image:image success:^{
        // 提示用户发送成功
        [MBProgressHUD showSuccess:@"发送图片成功"];
        // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
        _rightItem.enabled = YES;
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error.description);
        [MBProgressHUD showSuccess:@"发送图片失败"];
        _rightItem.enabled = YES;
        
    }];
}



#pragma mark - 发送文字
- (void)sendTitle
{
    [SYCComposeTool composeWithStatus:_textView.text success:^{
        
        
        // 提示用户发送成功
        [MBProgressHUD showSuccess:@"发送成功"];
        // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
