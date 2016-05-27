//
//  LoginWithNewAccountController.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "LoginWithNewAccountController.h"
#import "LoginView.h"

@interface LoginWithNewAccountController ()

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
    LoginView * loginView = [[LoginView alloc]init];
    loginView.frame = self.view.bounds;
    [loginView.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginView];
}

-(void)cancelBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
