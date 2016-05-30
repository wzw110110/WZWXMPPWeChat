//
//  WZWAccount.h
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZWAccount : NSObject

//登录用户名
@property (nonatomic,copy) NSString * loginUser;
//登录密码
@property (nonatomic,copy) NSString * loginPwd;

//注册用户名
@property (nonatomic,copy)NSString * registerUser;
//注册密码
@property (nonatomic,copy)NSString * registerPwd;

//是否登录过
@property (nonatomic,assign) BOOL haveLogined;
//用户头像
@property (nonatomic,strong) NSData * photoData;

//单例
+(instancetype)shareAccount;
/**
 *  保存最新的登录用户数据到沙盒中
 */
-(void)saveToSandBox;

@end
