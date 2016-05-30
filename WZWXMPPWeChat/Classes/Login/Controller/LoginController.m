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

@interface LoginController ()<UIActionSheetDelegate>

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
    
    LoginDirectView * loginDirectView = [[LoginDirectView alloc]init];
    loginDirectView.frame = self.view.bounds;
    [self.view addSubview:loginDirectView];
    [loginDirectView.moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
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
