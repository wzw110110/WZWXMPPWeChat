//
//  FriendCell.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/31.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    _photoImg = [[UIImageView alloc]init];
    _photoImg.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_photoImg];
    
    [_photoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    
    _nameLable = [[UILabel alloc]init];
    _nameLable.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_nameLable];
    
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_photoImg.mas_right).offset(15);
        make.centerY.equalTo(self.contentView);
    }];
    
    _onlineLabel = [[UILabel alloc]init];
    _onlineLabel.font = [UIFont systemFontOfSize:13];
    _onlineLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_onlineLabel];
    
    [_onlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
    }];
    
}

@end
