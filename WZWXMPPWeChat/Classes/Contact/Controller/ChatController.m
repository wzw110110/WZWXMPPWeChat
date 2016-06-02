//
//  ChatController.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/31.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "ChatController.h"
#import "ToolbarView.h"
#import "SendCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "ReceiveCell.h"

@interface ChatController () <UITextFieldDelegate,NSFetchedResultsControllerDelegate,UITableViewDataSource,UITableViewDelegate>

{
    NSFetchedResultsController * _resultsController;
}

@property (nonatomic,strong) ToolbarView * toolView;
@property (nonatomic,strong) UITableView * tableView;

@end

@implementation ChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化界面
    [self initView];
    
    //添加键盘通知
    [self addKeyboardNote];
    
    //加载数据库的聊天数据
    [self loadData];
    
    //使tableView移动到末端
    [self setTableViewMoveToBottom];
}

-(void)setTableViewMoveToBottom{
    //滚动到最末端
    NSIndexPath * lastIndexPath = [NSIndexPath indexPathForRow:_resultsController.fetchedObjects.count-1 inSection:0];
    if (lastIndexPath.row >0) {
        [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

#pragma mark - 加载数据库的聊天数据
-(void)loadData{
    //加载数据库的聊天数据
    
    // 1.上下文
    NSManagedObjectContext *msgContext = [XMPPTool sharedXMPPTool].msgArchivingStorage.mainThreadManagedObjectContext;
    
    // 2.查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];
    
    // 过滤 （当前登录用户 并且 好友的聊天消息）
    NSString *loginUserJid = [XMPPTool sharedXMPPTool].xmppStream.myJID.bare;
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@",loginUserJid,_friendJid.bare];
    request.predicate = pre;
    
    // 设置时间排序
    NSSortDescriptor *timeSort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    request.sortDescriptors = @[timeSort];
    
    // 3.执行请求
    _resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:msgContext sectionNameKeyPath:nil cacheName:nil];
    _resultsController.delegate = self;
    NSError *err = nil;
    [_resultsController performFetch:&err];
}

//NSFetchedResultsController代理方法
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView reloadData];
    
    //滚动到最末端
    [self setTableViewMoveToBottom];
}

#pragma mark - 表格视图代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMPPMessageArchiving_Message_CoreDataObject * msgObj = _resultsController.fetchedObjects[indexPath.row];
    if (msgObj.isOutgoing) {//发送消息
        return [tableView fd_heightForCellWithIdentifier:@"sendCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            [cell updateCellHeight:msgObj];
        }];
    }else{//接收消息
        return [tableView fd_heightForCellWithIdentifier:@"receiveCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            ReceiveCell * receiveCell = cell;
            receiveCell.photoImg.image = _photoImg;
            [receiveCell updateCellHeight:msgObj];
        }];
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultsController.fetchedObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取聊天信息
    XMPPMessageArchiving_Message_CoreDataObject * msgObj = _resultsController.fetchedObjects[indexPath.row];
    if (msgObj.isOutgoing) {//发送消息
        SendCell * sendCell = [tableView dequeueReusableCellWithIdentifier:@"sendCell"];
        [sendCell updateCellHeight:msgObj];
        return sendCell;
    }else{//接收消息
        ReceiveCell * receiveCell = [tableView dequeueReusableCellWithIdentifier:@"receiveCell"];
        receiveCell.photoImg.image = _photoImg;
        [receiveCell updateCellHeight:msgObj];
        return receiveCell;
    }
    
}

#pragma mark - 添加键盘通知
-(void)addKeyboardNote{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

//键盘显示
-(void)keyboardShow:(NSNotification *)note{
    
    //注意当切换输入法的时候也会调用这个方法
    CGRect frame;
    //将tableView的高度改成原来的值，防止切换中医文的时候，不停地调用这个方法，导致出现tableView的高度为0，出现黑屏
    frame = self.tableView.frame;
    frame.size.height=WZWScreenH-44;
    self.tableView.frame = frame;
    
    frame = _toolView.frame;
    frame.origin.y = WZWScreenH-44;
    _toolView.frame = frame;
    
    //获取键盘高度
    CGFloat kbHeight = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue].size.height;
    frame = _toolView.frame;
    frame.origin.y-=kbHeight;
    _toolView.frame = frame;
    
//    //改变tableView的frame值
    frame = self.tableView.frame;
    frame.size.height-=kbHeight;
    self.tableView.frame = frame;
    
    [self setTableViewMoveToBottom];
    
}

//键盘隐藏
-(void)keyboardHide:(NSNotification *)note{
    CGRect frame = _toolView.frame;
    frame.origin.y=WZWScreenH-44;
    _toolView.frame = frame;
    
//    //改变tableView的frame值
    frame = self.tableView.frame;
    frame.size.height=WZWScreenH-44;
    self.tableView.frame = frame;
}

#pragma mark - 发送聊天数据
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString * txt = textField.text;
    
    //发送聊天数据
    XMPPMessage * msg = [XMPPMessage messageWithType:@"chat" to:_friendJid];
    [msg addBody:txt];
    [[XMPPTool sharedXMPPTool].xmppStream sendElement:msg];
    
    //清空输入框的文本
    textField.text = nil;
    
    return YES;
}

#pragma mark - 初始化界面
-(void)initView{
    //tableView的设置
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WZWScreenW, WZWScreenH-44) style:UITableViewStylePlain];
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[SendCell class] forCellReuseIdentifier:@"sendCell"];
    [self.tableView registerClass:[ReceiveCell class] forCellReuseIdentifier:@"receiveCell"];
    [self.view addSubview:self.tableView];
    
    
    //navgation的设置
    self.hidesBottomBarWhenPushed = YES;
    self.title = [_displayName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"@%@",WZWDomain] withString:@""];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"barbuttonicon_back"] forState:UIControlStateNormal];
    leftBtn.frame=CGRectMake(0, 0, 10, 20);
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //底部输入框的设置
    _toolView = [[ToolbarView alloc]init];
    _toolView.frame=CGRectMake(0, WZWScreenH-44, WZWScreenW, 44);
    _toolView.backgroundColor = [UIColor whiteColor];
    _toolView.contentTF.delegate = self;
    [self.view addSubview:_toolView];
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


@end
