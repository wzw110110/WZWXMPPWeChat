//
//  ContactController.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "ContactController.h"
#import "AddFriendController.h"
#import "FriendCell.h"
#import "ChatController.h"

@interface ContactController ()<NSFetchedResultsControllerDelegate>

{
    NSFetchedResultsController * _resultController;
}


@end

@implementation ContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化界面
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //获取数据
    [self loadData];
}


#pragma mark - 获取数据
-(void)loadData{
    //好友数据都保存在XMPPRoster.sqlite文件中
    
    //1、上下文 用于关联XMPPRoster.sqlite文件
    NSManagedObjectContext * rosterContext = [XMPPTool sharedXMPPTool].rosterStorage.mainThreadManagedObjectContext;
    
    //2、Requset  请求查询哪张表
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    
    //设置排序
    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
    request.sortDescriptors = @[sort];
    
    //过滤
    NSPredicate * pre = [NSPredicate predicateWithFormat:@"subscription != %@",@"none"];
    request.predicate = pre;
    //3、执行请求
    _resultController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:rosterContext sectionNameKeyPath:nil cacheName:nil];
    _resultController.delegate = self;
    NSError * error = nil;
    
    //执行
    [_resultController performFetch:&error];
    
}

#pragma mark - 结果控制器的代理
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    //当数据库改变时刷新表格，这里也可以用kvo时刻监听是否添加了好友
    [self.tableView reloadData];
}

#pragma mark - 表格视图代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultController.fetchedObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"FriendCell";
    FriendCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[FriendCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    //获取对应的好友
    XMPPUserCoreDataStorageObject * user = _resultController.fetchedObjects[indexPath.row];
    //标识用户是否在线
    //0:在线 1:离开 2:离线
    cell.nameLable.text = [user.displayName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"@%@",WZWDomain] withString:@""];
    switch ([user.sectionNum integerValue]) {
        case 0:
            cell.onlineLabel.text = @"在线";
            break;
        case 1:
            cell.onlineLabel.text = @"离开";
            break;
        case 2:
            cell.onlineLabel.text = @"离线";
            break;
            
        default:
            break;
    }
    
    //显示好友的头像
    if (user.photo) {
        cell.photoImg.image = user.photo;
    }else{
        //从服务器获取头像
        NSData * imgData = [[XMPPTool sharedXMPPTool].avatar photoDataForJID:user.jid];
        if (imgData) {
            cell.photoImg.image = [UIImage imageWithData:imgData];
        }else{
            cell.photoImg.image = [UIImage imageNamed:@"DefaultHead"];
        }
        
    }
    
    return cell;
}

//删除好友
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取好友
    XMPPUserCoreDataStorageObject * friend = _resultController.fetchedObjects[indexPath.row];
    //删除好友
    if (editingStyle == UITableViewCellEditingStyleDelete ) {
        [[XMPPTool sharedXMPPTool].roster removeUser:friend.jid];
    }
}

//进入聊天界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FriendCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //获取好友
    XMPPUserCoreDataStorageObject * friend = _resultController.fetchedObjects[indexPath.row];
    ChatController * chatVC = [[ChatController alloc]init];
    chatVC.friendJid = friend.jid;
    chatVC.displayName = friend.displayName;
    chatVC.photoImg = cell.photoImg.image;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - 初始化界面
-(void)initView{
    self.title = @"通讯录";
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"contacts_add_friend"] forState:UIControlStateNormal];
    rightBtn.frame=CGRectMake(0, 0, 30, 30);
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//添加好友
-(void)rightBtnClick{
    AddFriendController * addVC = [[AddFriendController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
}



@end
