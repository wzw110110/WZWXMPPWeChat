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
    if ([WZWAccount shareAccount].photoData) {
        photoView.image = [UIImage imageWithData:[WZWAccount shareAccount].photoData];
    }else{
        photoView.image = [UIImage imageNamed:@"DefaultHead"];
    }
    [self addSubview:photoView];
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(50);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    _userLabel = [[UILabel alloc]init];
    _userLabel.text = [WZWAccount shareAccount].loginUser;
    [self addSubview:_userLabel];
    [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(photoView.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    _pwd = [[UITextField alloc]init];
    _pwd.textAlignment = NSTextAlignmentCenter;
    _pwd.placeholder = @"请输入密码";
    [self addSubview:_pwd];
    [_pwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userLabel.mas_bottom).offset(40);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
    }];
    
    UIImageView * lineView = [[UIImageView alloc]init];
    lineView.image = [UIImage imageNamed:@"AlbumCommentHorizontalLine"];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pwd.mas_bottom).offset(2);
        make.left.equalTo(_pwd.mas_left);
        make.right.equalTo(_pwd.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    UILabel * pwdLabel = [[UILabel alloc]init];
    pwdLabel.text = @"密码";
    [self addSubview:pwdLabel];
    [pwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_pwd.mas_left);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(_pwd.mas_bottom).offset(-1);
    }];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn setBackgroundColor:[UIColor greenColor]];
    _loginBtn.layer.cornerRadius = 10;
    _loginBtn.clipsToBounds = YES;
    [self addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}



@end
