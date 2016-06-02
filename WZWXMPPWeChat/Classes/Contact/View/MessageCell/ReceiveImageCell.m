//
//  ReceiveImageCell.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/6/2.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "ReceiveImageCell.h"

@interface ReceiveImageCell ()

@property (nonatomic,strong) UIImageView * iconImgV;
@property (nonatomic,strong) UIImageView * imgV;
//装图片的框框
@property (nonatomic,strong) UIImageView * senderImgV;

@end

@implementation ReceiveImageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        
    }
    return self;
}

-(void)setupUI{
    _iconImgV = [[UIImageView alloc]init];
    _iconImgV.image = [UIImage imageWithData:[WZWAccount shareAccount].photoData];
    [self.contentView addSubview:_iconImgV];
    
    [_iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.width.and.height.mas_equalTo(@(40));
    }];
    
    _senderImgV = [[UIImageView alloc]init];
    _senderImgV.image = [[UIImage imageNamed:@"ReceiverTextNodeBkg"]stretchableImageWithLeftCapWidth:30 topCapHeight:30];
    [self.contentView addSubview:_senderImgV];
    
    _imgV = [[UIImageView alloc]init];
    [self.contentView addSubview:_imgV];
    
    [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImgV).offset(10);
        make.left.equalTo(_iconImgV.mas_right).offset(15);
        make.width.and.height.mas_equalTo(@100);
    }];
    
    
    [_senderImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImgV.mas_top);
        make.left.equalTo(_imgV.mas_left).offset(-15);
        make.width.and.height.mas_equalTo(@128);
    }];
}

-(void)setReceiveImg:(UIImage *)receiveImg{
    _imgV.image = receiveImg;
    
    [_imgV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(receiveImg.size.height/receiveImg.size.width*100.0);
    }];
    
    [_senderImgV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(receiveImg.size.height/receiveImg.size.width*100.0 + 28);
    }];
}

@end
