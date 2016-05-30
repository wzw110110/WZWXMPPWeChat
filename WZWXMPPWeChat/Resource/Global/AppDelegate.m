//
//  AppDelegate.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "AppDelegate.h"
#import "WZWTabbarController.h"
#import "LoginController.h"
#import "LoginWithNewAccountController.h"
#import "RegisterController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    WZWTabbarController * wzwTabbar = [[WZWTabbarController alloc]init];
    LoginController * loginVC = [[LoginController alloc]init];
    LoginWithNewAccountController * loginNewVC = [[LoginWithNewAccountController alloc]init];
//    self.window.rootViewController = loginNewVC;
    if ([WZWAccount shareAccount].haveLogined) {
        self.window.rootViewController = wzwTabbar;
        [[XMPPTool sharedXMPPTool] xmppLogin:nil];
    }else{
        self.window.rootViewController = loginVC;
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@",paths[0]);

    
    return YES;
}

@end
