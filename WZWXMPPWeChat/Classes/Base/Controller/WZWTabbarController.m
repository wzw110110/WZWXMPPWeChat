//
//  WZWTabbarController.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "WZWTabbarController.h"
#import "MainFrameController.h"
#import "ContactController.h"
#import "DiscoveryController.h"
#import "MeController.h"

@interface WZWTabbarController ()

@end

@implementation WZWTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化四个视图控制器
    [self initViewControllers];
}

#pragma mark - 初始化四个视图控制器
-(void)initViewControllers{
    MainFrameController * mainFrameVC = [[MainFrameController alloc]init];
    UINavigationController * mainFrameUNC = [self setUpViewController:mainFrameVC title:@"微信" image:[UIImage imageNamed:@"tabbar_mainframe"] selectedImage:[UIImage imageNamed:@"tabbar_mainframeHL"]];
    
    ContactController * contactVC = [[ContactController alloc]init];
    UINavigationController * contactUNC = [self setUpViewController:contactVC title:@"通讯录" image:[UIImage imageNamed:@"tabbar_contacts"] selectedImage:[UIImage imageNamed:@"tabbar_contactsHL"]];
    
    DiscoveryController * discoveryVC = [[DiscoveryController alloc]init];
    UINavigationController * discoveryUNC = [self setUpViewController:discoveryVC title:@"发现" image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageNamed:@"tabbar_discoverHL"]];
    
    MeController * meVC = [[MeController alloc]init];
    UINavigationController * meUNC = [self setUpViewController:meVC title:@"我" image:[UIImage imageNamed:@"tabbar_me"] selectedImage:[UIImage imageNamed:@"tabbar_meHL"]];
    self.viewControllers = @[mainFrameUNC,contactUNC,discoveryUNC,meUNC];
}

-(UINavigationController *)setUpViewController:(UIViewController *)vc
                     title:(NSString *)title
                     image:(UIImage *)image
             selectedImage:(UIImage *)selectedImage{
    UINavigationController * unc = [[UINavigationController alloc]initWithRootViewController:vc];
    unc.tabBarItem.title = title;
    unc.tabBarItem.image = image;
    unc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return unc;
}


@end
