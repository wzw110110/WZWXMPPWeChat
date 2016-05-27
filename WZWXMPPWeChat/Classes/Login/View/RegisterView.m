//
//  RegisterView.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView

-(instancetype)init{
    if (self = [super init]) {
        [self setUpView];
    }
    return self;
}

-(void)setUpView{
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(30);
    }];
    
    UILabel * remindLabel = [[UILabel alloc]init];
    remindLabel.text = @"请输入任意数字或字母";
    remindLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:remindLabel];
    [remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.mas_equalTo(30);
        make.top.equalTo(self).offset(60);
    }];
    
    UITextField * username = [[UITextField alloc]init];
    username.textAlignment = NSTextAlignmentCenter;
    username.placeholder = @"请输入账号";
    [self addSubview:username];
    [username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(remindLabel.mas_bottom).offset(30);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(35);
    }];
    
    UIImageView * lineView1 = [[UIImageView alloc]init];
    lineView1.image = [UIImage imageNamed:@"AlbumCommentHorizontalLine"];
    [self addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(username.mas_bottom).offset(2);
        make.left.equalTo(username.mas_left);
        make.right.equalTo(username.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    UILabel * userLabel = [[UILabel alloc]init];
    userLabel.text = @"账号";
    [self addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(username.mas_left);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(username.mas_bottom).offset(-8);
    }];
    
    
    UITextField * pwd = [[UITextField alloc]init];
    pwd.textAlignment = NSTextAlignmentCenter;
    pwd.placeholder = @"请输入密码";
    [self addSubview:pwd];
    [pwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userLabel.mas_bottom).offset(15);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(35);
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
        make.bottom.equalTo(pwd.mas_bottom).offset(-8);
    }];
    
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
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
    
    
}

@end
