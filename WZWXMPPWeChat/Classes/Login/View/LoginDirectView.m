//
//  LoginDirectView.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "LoginDirectView.h"

@implementation LoginDirectView

-(instancetype)init{
    if (self = [super init]) {
        [self setUpView];
    }
    return self;
}

-(void)setUpView{
    UIImageView * photoView = [[UIImageView alloc]init];
    photoView.backgroundColor = [UIColor redColor];
    [self addSubview:photoView];
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(50);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    UILabel * userLabel = [[UILabel alloc]init];
    userLabel.text = @"wzw110301065";
    userLabel.backgroundColor = [UIColor greenColor];
    [self addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(photoView.mas_bottom).offset(15);
        make.height.mas_equalTo(20);
    }];
    
    UITextField * pwd = [[UITextField alloc]init];
    pwd.textAlignment = NSTextAlignmentCenter;
    pwd.placeholder = @"请输入密码";
    [self addSubview:pwd];
    [pwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userLabel.mas_bottom).offset(40);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
    }];
    
    UIImageView * lineView = [[UIImageView alloc]init];
    lineView.image = [UIImage imageNamed:@"AlbumCommentHorizontalLine"];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwd.mas_bottom).offset(2);
        make.left.equalTo(pwd.mas_left);
        make.right.equalTo(pwd.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    UILabel * pwdLabel = [[UILabel alloc]init];
    pwdLabel.text = @"密码";
    [self addSubview:pwdLabel];
    [pwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwd.mas_left);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(pwd.mas_bottom).offset(-1);
    }];
    
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor greenColor]];
    loginBtn.layer.cornerRadius = 10;
    loginBtn.clipsToBounds = YES;
    [self addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(45);
        make.top.equalTo(lineView.mas_bottom).offset(40);
    }];
    
     _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self addSubview:_moreBtn];
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.height.mas_equalTo(20);
    }];

}


@end
