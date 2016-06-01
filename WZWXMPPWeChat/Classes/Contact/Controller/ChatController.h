//
//  ChatController.h
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/31.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "BaseViewController.h"

@interface ChatController : UIViewController

/**
 *  好友的Jid
 */
@property (nonatomic,strong) XMPPJID * friendJid;
/**
 *  好友的名称
 */
@property (nonatomic,copy) NSString * displayName;
/**
 *  好友的头像
 */
@property (nonatomic,strong) UIImage * photoImg;

@end
