//
//  UpdateInfoCell.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/30.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "UpdateInfoCell.h"

@implementation UpdateInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 初始化界面
-(void)setupUI{
    
    _infoTF = [[UITextField alloc]init];
    [self.contentView addSubview:_infoTF];
    
    [_infoTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
}

@end
