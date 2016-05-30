//
//  LoginController.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "LoginController.h"
#import "LoginDirectView.h"
#import "LoginWithNewAccountController.h"
#import "RegisterController.h"
#import "WZWTabbarController.h"

@interface LoginController ()<UIActionSheetDelegate>

@property (nonatomic,strong) LoginDirectView * loginDirectView;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化界面
    [self initView];
}

#pragma mark - 初始化界面
-(void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _loginDirectView = [[LoginDirectView alloc]init];
    _loginDirectView.frame = self.view.bounds;
    [self.view addSubview:_loginDirectView];
    [_loginDirectView.moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_loginDirectView.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

//登录
-(void)loginBtnClick{
    if (_loginDirectView.pwd.text.length == 0) {
        [MBProgressHUD showError:@"密码不能为空"];
    }
    
    [MBProgressHUD showMessage:@"正在登陆..."];
    [WZWAccount shareAccount].loginPwd = _loginDirectView.pwd.text;
    //弱化self
    __weak typeof(self) weakSelf = self;
    [[XMPPTool sharedXMPPTool] xmppLogin:^(XMPPResultType resultType) {
        [weakSelf handleXMPPResultType:resultType];
    }];
}

//处理结果
-(void)handleXMPPResultType:(XMPPResultType)result{
    //一定要注意回到主线程，否则会报错
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        if (result == XMPPResultTypeLoginSuccess) {
            //跳到主界面
            WZWTabbarController * wzwTabbar = [[WZWTabbarController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController = wzwTabbar;
            
            //保存登录账户的信息
            [WZWAccount shareAccount].haveLogined = YES;
            [[WZWAccount shareAccount]saveToSandBox];
        }else{
            [MBProgressHUD showError:@"账号或密码不正确"];
        }
        
    });
    
}

-(void)moreBtnClick{
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"切换账号" otherButtonTitles:@"注册", nil];
    [sheet showInView:self.view];
}

//actionSheet代理方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        LoginWithNewAccountController * loginNewVC = [[LoginWithNewAccountController alloc]init];
        [self presentViewController:loginNewVC animated:YES completion:nil];
    }else if (buttonIndex == 1){
        RegisterController * registerVC = [[RegisterController alloc]init];
        [self presentViewController:registerVC animated:YES completion:nil];
    }
}



@end
