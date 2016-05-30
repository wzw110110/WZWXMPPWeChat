//
//  MeController.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "MeController.h"

@interface MeController ()

@end

@implementation MeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化界面
    [self initView];
   self.title = @"我";
}

#pragma mark - 初始化界面
-(void)initView{
    self.title = @"我";
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"注销" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(0, 0, 30, 50);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)rightBtnClick{
    [[XMPPTool sharedXMPPTool] xmppLoginOut];
    
    //把沙盒的登录状态设置为NO
    [WZWAccount shareAccount].haveLogined = NO;
    [[WZWAccount shareAccount] saveToSandBox];
    
    //回到登录界面
    
}


@end
