//
//  BaseViewController.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化导航栏
    [self initNavBar];
}


#pragma mark - 初始化导航栏
-(void)initNavBar{
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    UIView * view = [[UIView alloc]init];
    self.tableView.tableFooterView = view;
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"wzw"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"wzw"];
    }
    return cell;
}


@end
