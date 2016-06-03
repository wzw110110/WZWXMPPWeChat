//
//  SendVoiceCell.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/6/3.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "SendVoiceCell.h"

@interface SendVoiceCell ()

@property (nonatomic,strong) UIImageView * photoImgV;
@property (nonatomic,strong) UIImageView * iconImgV;
@property (nonatomic,strong) UIImageView * wifiImgV;

@end

@implementation SendVoiceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setupUI{
    _photoImgV = [[UIImageView alloc]init];
    _photoImgV.image = [UIImage imageWithData:[WZWAccount shareAccount].photoData];
    [self.contentView addSubview:_photoImgV];
    
    [_photoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.width.and.height.mas_equalTo(@40);
    }];
    
    _iconImgV = [[UIImageView alloc]init];
    _iconImgV.image = [UIImage imageNamed:@"SenderVoiceNodeBack"];
    [self.contentView addSubview:_iconImgV];
    
    [_iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_photoImgV);
        make.right.equalTo(_photoImgV.mas_left);
        make.bottom.equalTo(_photoImgV).offset(10);
        make.width.mas_equalTo(@60);
    }];
    
    _wifiImgV = [[UIImageView alloc]init];
    _wifiImgV.image = [UIImage imageNamed:@"SenderVoiceNodePlaying"];
    [self.contentView addSubview:_wifiImgV];
    
    [_wifiImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconImgV).offset(-5);
        make.right.equalTo(_iconImgV.mas_right).offset(-15);
        make.width.mas_equalTo(@12);
        make.height.mas_equalTo(@17);
    }];

    _timeLabel = [[UILabel alloc]init];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_iconImgV.mas_bottom).offset(-15);
        make.right.equalTo(_iconImgV.mas_left);
        make.height.mas_equalTo(@20);
    }];
}

@end
