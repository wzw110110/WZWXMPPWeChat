//
//  AddFriendCell.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/31.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "AddFriendCell.h"

@implementation AddFriendCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    _accountTF = [[UITextField alloc]initWithFrame:self.contentView.bounds];
    _accountTF.textAlignment = NSTextAlignmentCenter;
    _accountTF.placeholder = @"微信号";
    [self.contentView addSubview:_accountTF];
    
    UIImageView * searchImg = [[UIImageView alloc]init];
    searchImg.image = [UIImage imageNamed:@"add_friend_searchicon"];
    [_accountTF addSubview:searchImg];
    
    [searchImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_accountTF);
        make.left.equalTo(_accountTF).offset(20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    
}

@end
