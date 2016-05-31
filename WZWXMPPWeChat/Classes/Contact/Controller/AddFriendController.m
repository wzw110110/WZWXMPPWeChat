//
//  AddFriendController.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/31.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "AddFriendController.h"
#import "AddFriendCell.h"

@interface AddFriendController ()<UITextFieldDelegate>

@property (nonatomic,strong) AddFriendCell * addCell;

@end

@implementation AddFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化界面
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _addCell.accountTF.text = @"";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - 表格视图代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _addCell = [tableView dequeueReusableCellWithIdentifier:@"addFriendCell"];
    _addCell.accountTF.delegate = self;
    return _addCell;
}

#pragma mark - 初始化界面
-(void)initView{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.tableView registerClass:[AddFriendCell class] forCellReuseIdentifier:@"addFriendCell"];
    self.title = @"添加朋友";
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"barbuttonicon_back"] forState:UIControlStateNormal];
    leftBtn.frame=CGRectMake(0, 0, 10, 20 );
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"添加" forState:UIControlStateNormal];
    rightBtn.frame=CGRectMake(0, 0, 30, 50);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}


//添加好友
-(void)rightBtnClick{
    //获取用户输入的好友名册
    NSString * user = _addCell.accountTF.text;
    
    //1、不能添加自己为好友
    if ([user isEqualToString:[WZWAccount shareAccount].loginUser]) {
        [self showMsg:@"不能添加自己为好友"];
        return;
    }
    
    //2、已经存在好友无需添加
    XMPPJID * userJid = [XMPPJID jidWithUser:user domain:WZWDomain resource:nil];
    
    BOOL userExists = [[XMPPTool sharedXMPPTool].rosterStorage userExistsWithJID:userJid xmppStream:[XMPPTool sharedXMPPTool].xmppStream];
    if (userExists) {
        [self showMsg:@"好友已经存在"];
        return;
    }
    
    //3、添加好友成功
    [[XMPPTool sharedXMPPTool].roster subscribePresenceToUser:userJid];
    [self showMsg:@"好友添加成功"];
    
    //这里openfire服务器存在一个问题，当服务器中不存在的好友，也会添加成功
}

-(void)showMsg:(NSString *)msg{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end
