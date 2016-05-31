
/*用户登录流程
 1、初始化XMPPStream
 2、连接服务器(传一个jid)
 3、连接成功，接着发送密码
 4、发送一个"在线消息"给服务器 -->可以通知其他用户你上线了
 */

#import "XMPPTool.h"

@interface XMPPTool ()<XMPPStreamDelegate>
{
    XMPPResultTypeBlock _resultBlock;//结果回调
}

/**
 *  1、初始化xmppSteram
 */

-(void)setUpStream;
/**
 *  2、连接服务器
 */
-(void)connectToHost;
/**
 *  3、连接成功，发送密码
 */
-(void)sendPwdToHost;
/**
 *  4、发送一个在线消息
 */
-(void)sendOnline;

/**
 *  发送离线消息
 */
-(void)sendOffline;
/**
 *  与服务器断开连接
 */
-(void)disconnectFromHost;
/**
 *  释放资源
 */
-(void)teardownStream;

@end

@implementation XMPPTool

singleton_implementation(XMPPTool)

#pragma mark - 私有方法
-(void)setUpStream{
    _xmppStream = [[XMPPStream alloc]init];
    //所有的代理方法都在子线程中调用
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    //添加XMPP模块
    //1、添加电子名片模块
    _vCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
    _vCard = [[XMPPvCardTempModule alloc]initWithvCardStorage:_vCardStorage];
    //激活
    [_vCard activate:_xmppStream];
    
    //2、电子名片模块还会配置"头像模块"一起使用
    //添加头像模块
    _avatar = [[XMPPvCardAvatarModule alloc]initWithvCardTempModule:_vCard];
    [_avatar activate:_xmppStream];
    
    //3、添加花名册模块
    _rosterStorage = [[XMPPRosterCoreDataStorage alloc]init];
    _roster = [[XMPPRoster alloc]initWithRosterStorage:_rosterStorage];
    [_roster activate:_xmppStream];
    
    //4、添加聊天模块
    _msgArchivingStorage = [[XMPPMessageArchivingCoreDataStorage alloc]init];
    _msgArchiving = [[XMPPMessageArchiving alloc]initWithMessageArchivingStorage:_msgArchivingStorage];
    [_msgArchiving activate:_xmppStream];
}

-(void)teardownStream{
    //移除代理
    [_xmppStream removeDelegate:self];
    //取消模块
    [_vCard deactivate];
    [_avatar deactivate];
    [_avatar deactivate];
    [_roster deactivate];
    [_msgArchiving deactivate];
    //断开连接
    [_xmppStream disconnect];
    //清空资源
    _xmppStream = nil;
    _vCard = nil;
    _vCardStorage = nil;
    _avatar = nil;
    _roster = nil;
    _rosterStorage = nil;
    _msgArchiving = nil;
    _msgArchivingStorage = nil;
}

-(void)connectToHost{
    if (!_xmppStream) {
        [self setUpStream];
    }
    
    //设置用户的Jid;
    XMPPJID * myJid = nil;
    
    //如果是注册账户则设置注册jid
    if (self.isRegisterOperation) {
        NSString * registerJid = [WZWAccount shareAccount].registerUser;
        myJid = [XMPPJID jidWithUser:registerJid domain:WZWDomain resource:nil];
    }else{
        NSString * loginUser = [WZWAccount shareAccount].loginUser;
        myJid = [XMPPJID jidWithUser:loginUser domain:WZWDomain resource:nil];
    }
    
    _xmppStream.myJID = myJid;
    //设置主机地址
    _xmppStream.hostName = WZWHostName;
    //设置主机端口号
    _xmppStream.hostPort = WZWHostPort;
    //发起连接
    NSError * error = nil;
    [_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error];
    if (error) {
        NSLog(@"连接主机失败%@",error);
    }else{
        NSLog(@"发起连接成功");
    }
    
    
}

-(void)sendPwdToHost{
    NSError * error = nil;
    //如果是注册用户
    if (self.isRegisterOperation) {
        NSString * registePwd = [WZWAccount shareAccount].registerPwd;
        [_xmppStream registerWithPassword:registePwd error:&error];
    }else{
        NSString * loginPwd = [WZWAccount shareAccount].loginPwd;
        [_xmppStream authenticateWithPassword:loginPwd error:&error];

    }
    
    if (error) {
        NSLog(@"发送密码失败%@",error);
    }
    
    
}

-(void)sendOnline{
    XMPPPresence * presence = [XMPPPresence presence];
    [_xmppStream sendElement:presence];
}

-(void)sendOffline{
    XMPPPresence * offline = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:offline];
}

-(void)disconnectFromHost{
    [_xmppStream disconnect];
}



#pragma mark - 实现.h里面的方法
-(void)xmppLogin:(XMPPResultTypeBlock)resultBlock{
    //不管什么清空，把以前的连接断开
    [_xmppStream disconnect];
    //保存block
    _resultBlock = resultBlock;
    //连接服务器开始登录操作
    [self connectToHost];
}

-(void)xmppLoginOut{
    //发送离线给服务器
    [self sendOffline];
    //断开与服务器的连接
    [self disconnectFromHost];
}

-(void)xmppRegister:(XMPPResultTypeBlock)resultBlock{
    //1、发送一个注册的jid给服务器，请求长连接
    //2、发送注册密码
    
    //保存block
    _resultBlock = resultBlock;
    //取消以前的连接
    [_xmppStream disconnect];
    [self connectToHost];
}



#pragma mark - xmppStream的代理方法
//连接成功
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    //连接成功，发送密码
    [self sendPwdToHost];
    
}
//登录成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    //发送在线消息
    [self sendOnline];
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLoginSuccess);
    }
}
//登录失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error{
    NSLog(@"登录失败%@",error);
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLoginFailure);
    }
    
}
//注册成功
- (void)xmppStreamDidRegister:(XMPPStream *)sender{
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeRegisterSuccess);
    }
}

//注册失败
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(NSXMLElement *)error{
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeRegisterFailure);
    }
}

-(void)dealloc{
    [self teardownStream];
}

@end
