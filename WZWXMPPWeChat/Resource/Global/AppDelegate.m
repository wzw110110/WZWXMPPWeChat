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
    RegisterController * registerVC = [[RegisterController alloc]init];
//    self.window.rootViewController = wzwTabbar;
    
    self.window.rootViewController = loginVC;
//    self.window.rootViewController = loginNewVC;
//    self.window.rootViewController = registerVC;
    
    return YES;
}

@end
