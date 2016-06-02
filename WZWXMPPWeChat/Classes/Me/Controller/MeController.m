//
//  MeController.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "MeController.h"
#import "XMPPvCardTemp.h"
#import "LoginController.h"
#import "ProfileController.h"

@interface MeController ()


@end

@implementation MeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化界面
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - 表格视图代理方法

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"defaultCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"微信号:%@",[WZWAccount shareAccount].loginUser];
    //通过头像模块，查找头像
    XMPPvCardTemp * myVCard = [XMPPTool sharedXMPPTool].vCard.myvCardTemp;
    if (myVCard.photo) {
        cell.imageView.image = [UIImage imageWithData:myVCard.photo];
    }
    cell.textLabel.text = myVCard.nickname;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        ProfileController * profileVC = [[ProfileController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:profileVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - 初始化界面
-(void)initView{
    self.title = @"我";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
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
    LoginController * loginVC = [[LoginController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;
}


@end
