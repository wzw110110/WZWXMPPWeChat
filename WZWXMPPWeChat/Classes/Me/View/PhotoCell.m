//
//  PhotoCell.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/30.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    _nameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_nameLabel];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
    }];
    
    _photoImg = [[UIImageView alloc]init];
    [self.contentView addSubview:_photoImg];
    
    [_photoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-5);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(60);
    }];
}

@end
