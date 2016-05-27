//
//  RegisterController.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "RegisterController.h"
#import "RegisterView.h"

@interface RegisterController ()

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化界面
    [self initView];
}

-(void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    RegisterView * view = [[RegisterView alloc]init];
    view.frame= self.view.bounds;
    [view.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];
}

-(void)cancelBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
