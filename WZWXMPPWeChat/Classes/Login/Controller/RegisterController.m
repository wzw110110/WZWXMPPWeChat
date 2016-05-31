//
//  RegisterController.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "RegisterController.h"
#import "RegisterView.h"
#import "WZWTabbarController.h"

@interface RegisterController ()

@property (nonatomic,strong) RegisterView * registerView;

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化界面
    [self initView];
}

-(void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    _registerView = [[RegisterView alloc]init];
    _registerView.frame= self.view.bounds;
    [_registerView.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_registerView.registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerView];
}

//用户注册
-(void)registerBtnClick{
    if (_registerView.username.text.length ==0 || _registerView.pwd.text.length ==0) {
        [MBProgressHUD showError:@"账号或密码不能为空"];
        return;
    }
    
    //提示
    [MBProgressHUD showMessage:@"正在注册..."];
    
    [XMPPTool sharedXMPPTool].registerOperation = YES;
    
    //将数据保存到单例中
    [WZWAccount shareAccount].registerUser = _registerView.username.text;
    [WZWAccount shareAccount].registerPwd = _registerView.pwd.text;
    
    __weak typeof(self) weakSelf = self;
    [[XMPPTool sharedXMPPTool]xmppRegister:^(XMPPResultType resultType) {
        //处理注册的结果
        [weakSelf handleRegisterTyep:resultType];
    }];
}

//处理注册的结果
-(void)handleRegisterTyep:(XMPPResultType)resultType{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        if (resultType == XMPPResultTypeRegisterSuccess) {
            [MBProgressHUD showSuccess:@"用户注册成功"];
            //跳到主界面
            WZWTabbarController * wzwTabbar = [[WZWTabbarController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController = wzwTabbar;
//            //将注册用户的数据保存到沙盒中，将状态显示为已登录
            //将图片清空
            [WZWAccount shareAccount].photoData = nil;
            [WZWAccount shareAccount].loginUser = _registerView.username.text;
            [WZWAccount shareAccount].loginPwd = _registerView.pwd.text;
            [WZWAccount shareAccount].haveLogined = YES;
            [[WZWAccount shareAccount]saveToSandBox];
            [XMPPTool sharedXMPPTool].registerOperation = NO;
        }else{
            [MBProgressHUD showError:@"账号已存在,请重新输入"];
        }
    });
}

-(void)cancelBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
