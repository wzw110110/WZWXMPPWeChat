//
//  ReceiveCell.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/31.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "ReceiveCell.h"

@implementation ReceiveCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _photoImg = [[UIImageView alloc]init];
    _photoImg.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_photoImg];
    
    [_photoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.height.and.width.mas_equalTo(40);
    }];
    
    _imgV = [[UIImageView alloc]init];
    _imgV.image = [[UIImage imageNamed:@"ReceiverTextNodeBkg"]stretchableImageWithLeftCapWidth:50 topCapHeight:30];
    [self.contentView addSubview:_imgV];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.numberOfLines = 0;
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_contentLabel];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_photoImg.mas_right).offset(20);
        make.top.equalTo(_photoImg).offset(5);
        make.width.lessThanOrEqualTo(@(WZWScreenW-150));
        make.bottom.equalTo(@-20);
    }];
    
    [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_contentLabel.mas_right).offset(15);
        make.top.equalTo(_photoImg.mas_top);
        make.left.equalTo(_contentLabel.mas_left).offset(-15);
        make.bottom.equalTo(_contentLabel.mas_bottom).offset(15);
    }];
    
}

-(void)updateCellHeight:(XMPPMessageArchiving_Message_CoreDataObject *)msgObj{
    _contentLabel.text = msgObj.body;
    
}




@end
