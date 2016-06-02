//
//  MainFrameController.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "MainFrameController.h"
#import "RecentChatCell.h"

@interface MainFrameController ()<NSFetchedResultsControllerDelegate>

{
    NSFetchedResultsController * _reslutsController;
}

@end

@implementation MainFrameController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    //初始化界面
    [self initView];
    
    //加载聊天的数据
    [self loadData];
}


#pragma mark - 表格视图代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _reslutsController.fetchedObjects.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecentChatCell * recentChatCell = [tableView dequeueReusableCellWithIdentifier:@"wzw"];
    if (!recentChatCell) {
        recentChatCell = [[RecentChatCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"wzw"];
    }
    XMPPMessageArchiving_Message_CoreDataObject * msgObj = _reslutsController.fetchedObjects[indexPath.row];
    [recentChatCell configCellWithModel:msgObj];
    return recentChatCell;
}

#pragma mark - 加载聊天数据
-(void)loadData{
  //加载数据库的聊天数据
  
  // 1.上下文
  NSManagedObjectContext *msgContext = [XMPPTool sharedXMPPTool].msgArchivingStorage.mainThreadManagedObjectContext;
  
  // 2.查询请求
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];
  
  // 过滤 （当前登录用户 并且 好友的聊天消息）
  NSString *loginUserJid = [XMPPTool sharedXMPPTool].xmppStream.myJID.bare;
  NSPredicate *pre = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@",loginUserJid];
  request.predicate = pre;
  
  // 设置时间排序
  NSSortDescriptor *timeSort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO];
  request.sortDescriptors = @[timeSort];
  
  // 3.执行请求
  _reslutsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:msgContext sectionNameKeyPath:nil cacheName:nil];
  _reslutsController.delegate = self;
  NSError *err = nil;
  [_reslutsController performFetch:&err];

}

//resultsController代理方法
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView reloadData];
    
    
}

#pragma mark - 初始化界面
-(void)initView{
     self.title = @"微信";
}



@end
