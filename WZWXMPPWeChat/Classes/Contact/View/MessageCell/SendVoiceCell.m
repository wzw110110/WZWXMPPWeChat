//
//  SendVoiceCell.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/6/3.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "SendVoiceCell.h"
#import <AVFoundation/AVFoundation.h>

@interface SendVoiceCell ()<AVAudioPlayerDelegate>

@property (nonatomic,strong) UIImageView * photoImgV;
@property (nonatomic,strong) UIButton * iconBtn;
@property (nonatomic,strong) UIImageView * wifiImgV;
/** 播放器 */
@property(nonatomic,strong) AVAudioPlayer *player;


@end

@implementation SendVoiceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_iconBtn setBackgroundImage:[UIImage imageNamed:@"SenderVoiceNodeBack"] forState:UIControlStateNormal];
    [_iconBtn addTarget:self action:@selector(iconBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_iconBtn];

    
    [_iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_photoImgV);
        make.right.equalTo(_photoImgV.mas_left);
        make.bottom.equalTo(_photoImgV).offset(10);
        make.width.mas_equalTo(@60);
    }];
    
    _wifiImgV = [[UIImageView alloc]init];
    _wifiImgV.image = [UIImage imageNamed:@"SenderVoiceNodePlaying"];
    [self.contentView addSubview:_wifiImgV];
    
    [_wifiImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconBtn).offset(-5);
        make.right.equalTo(_iconBtn.mas_right).offset(-15);
        make.width.mas_equalTo(@12);
        make.height.mas_equalTo(@17);
    }];

    _timeLabel = [[UILabel alloc]init];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_iconBtn.mas_bottom).offset(-15);
        make.right.equalTo(_iconBtn.mas_left);
        make.height.mas_equalTo(@20);
    }];
    
    
}


-(void)iconBtnClick{
#warning 新录制的音频可以，但是一旦重启模拟器就不行
    NSError * error;
    if (_filePath) {
        NSData * data = [[NSData alloc] initWithContentsOfFile:_filePath];
        _player = [[AVAudioPlayer alloc]initWithData:data error:&error];;
        if (error) {
            NSLog(@"%@",error);
        }
        [_player play];
    }

}

-(void)setFilePath:(NSString *)filePath{
    _filePath = filePath;
}



@end
