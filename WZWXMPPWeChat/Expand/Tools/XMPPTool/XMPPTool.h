//
//  XMPPTool.h
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    XMPPResultTypeLoginSuccess,//登录成功
    XMPPResultTypeLoginFailure,//登录失败
    XMPPResultTypeRegisterSuccess,//注册成功
    XMPPResultTypeRegisterFailure//注册失败
}XMPPResultType;

//与服务器交互的结果
typedef void (^XMPPResultTypeBlock) (XMPPResultType);

@interface XMPPTool : NSObject

singleton_interface(XMPPTool)//设置成为单例

@property (nonatomic,strong) XMPPStream * xmppStream;//与服务器交互的核心类

/**
 *  标识服务器连接到底是登录连接还是注册连接
 *  NO 代表登录操作
 *  YES 代表注册操作
 */
@property (nonatomic,assign,getter=isRegisterOperation)BOOL registerOperation;

/**
 *  xmpp用户登录
 */
-(void)xmppLogin:(XMPPResultTypeBlock)resultBlock;
/**
 *  用户注销
 */
-(void)xmppLoginOut;
/**
 *  用户注册
 */
-(void)xmppRegister:(XMPPResultTypeBlock)resultBlock;

@end
