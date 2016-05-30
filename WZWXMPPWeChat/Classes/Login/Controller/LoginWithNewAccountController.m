//
//  LoginWithNewAccountController.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "LoginWithNewAccountController.h"
#import "LoginView.h"
#import "WZWTabbarController.h"

@interface LoginWithNewAccountController ()

@property (nonatomic,strong)LoginView * loginView;

@end

@implementation LoginWithNewAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化界面
    [self initView];
}

#pragma mark - 初始化界面
-(void)initView{
    _loginView = [[LoginView alloc]init];
    _loginView.frame = self.view.bounds;
    [_loginView.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginView];
}

//取消
-(void)cancelBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//登录
-(void)loginBtnClick{
    if (_loginView.username.text.length ==0 || _loginView.pwd.text.length ==0 ) {
        [MBProgressHUD showError:@"账号或密码不能为空"];
        return;
    }
    
    [MBProgressHUD showMessage:@"正在登录"];
    
    //把用户名和密码放在单例中
    [WZWAccount shareAccount].loginUser = _loginView.username.text;
    [WZWAccount shareAccount].loginPwd = _loginView.pwd.text;
    
    //弱化self
    __weak typeof(self) weakSelf = self;
    [[XMPPTool sharedXMPPTool] xmppLogin:^(XMPPResultType resultType) {
        [weakSelf handleXMPPResultType:resultType];
    }];
}

//处理结果
-(void)handleXMPPResultType:(XMPPResultType)result{
    //一定要注意回到主线程，否则会报错
    //报错如下:  This application is modifying the autolayout engine from a background thread, which can lead to engine corruption and weird crashes.  This will cause an exception in a future release.
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        if (result == XMPPResultTypeLoginSuccess) {
            NSLog(@"登录成功");
            //跳到主界面
            WZWTabbarController * wzwTabbar = [[WZWTabbarController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController = wzwTabbar;
            
            //保存登录账户的信息
            [WZWAccount shareAccount].haveLogined = YES;
            [[WZWAccount shareAccount]saveToSandBox];
        }else{
            NSLog(@"登录失败");
            [MBProgressHUD showError:@"账号或密码不正确"];
        }

    });
    
}



@end
