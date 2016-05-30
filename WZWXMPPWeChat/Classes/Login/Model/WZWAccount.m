//
//  WZWAccount.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "WZWAccount.h"
#define WZWUserKey @"user"
#define WZWPwdKey @"pwd"
#define WZWHaveLogined @"haveLogined"
#define WZWPhotoData @"photoData"

@implementation WZWAccount

//分配内存创建对象
+(instancetype)shareAccount{
    return [[self alloc]init];
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static WZWAccount * account;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (account == nil) {
            account = [super allocWithZone:zone];
            
            //从沙盒中获取上次用户的登录信息
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            account.loginUser = [defaults objectForKey:WZWUserKey];
            account.loginPwd = [defaults objectForKey:WZWPwdKey];
            account.haveLogined = [defaults boolForKey:WZWHaveLogined];
            account.photoData = [defaults dataForKey:WZWPhotoData];
        }
    });
    return account;
}

-(void)saveToSandBox{
    NSUserDefaults * defaluts = [NSUserDefaults standardUserDefaults];
    [defaluts setObject:self.loginUser forKey:WZWUserKey];
    [defaluts setObject:self.loginPwd forKey:WZWPwdKey];
    [defaluts setBool:self.haveLogined forKey:WZWHaveLogined];
    [defaluts setObject:self.photoData forKey:WZWPhotoData];
    [defaluts synchronize];
}

@end
