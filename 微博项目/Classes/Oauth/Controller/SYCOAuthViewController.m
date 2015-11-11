//
//  SYCOauthViewController.m
//  微博项目
//
//  Created by sycjyy on 15/10/18.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCOauthViewController.h"

#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"

#import "SYCAcconut.h"
#import "SYCAccountTool.h"
#import "SYCRootTool.h"
#import "SYCHttpTool.h"

#define SYCOAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define SYCClient_id @"780324934"
#define SYCRedirect_uri @"http://github.com/Sycjyy"
#define SYCClient_secret @"aa434ffea90d6928898d8fb5859cf731"

@interface SYCOAuthViewController ()<UIWebViewDelegate>

@end

@implementation SYCOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:webView];
    
    //https://api.weibo.com/oauth2/authorize?client_id=570915881&redirect_url=http://github.com/Sycjyy
    
    NSString *baseUrl = SYCOAuthorizeBaseUrl;
    NSString *client_id = SYCClient_id;
    NSString *redirect_uri = SYCRedirect_uri;
    
    
    //拼接URL字符串
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    //创建url请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
    //设置webView的代理
    webView.delegate = self;
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    //提示用户正在加载
    [MBProgressHUD showMessage:@"正在加载"];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [MBProgressHUD hideHUD];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [MBProgressHUD hideHUD];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlStr = request.URL.absoluteString;
    //获取code（requestToken）
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) {
        //code=9b18cb51ff215d22937b1bac20f00329
        
        NSLog(@"%@",urlStr);
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        //换取accessToken
        [self accessTokenWithCode:code];
        
        return NO;
    }
    
    return YES;
}
/*
 
 必选	类型及范围	说明
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 
 */
/*
 "access_token" = "2.00nqMxdF0CKKoqaf2be168cc0p56Fy";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 5171052017;
 */
-(void)accessTokenWithCode:(NSString *)code{
    //发送POST请求
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = SYCClient_id;
    params[@"client_secret"] = SYCClient_secret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] =SYCRedirect_uri;
    
    [SYCHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(id responseObject) {
        
        //请求成功的时候会调用
        SYCAcconut *account = [SYCAcconut acconutWithDict:responseObject];
        //保存账号信息
        [SYCAccountTool saveAccount:account];
        [SYCRootTool chooseRootViewController:[UIApplication sharedApplication].keyWindow];
    } failure:^(NSError *error) {
        
    }];

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
