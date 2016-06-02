//
//  RecentChatCell.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/6/1.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "RecentChatCell.h"
#import "NSDate+MJ.h"

@interface RecentChatCell ()

@property (nonatomic,strong) UIImageView * photoImgV;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * msgIntroLabel;
@property (nonatomic,strong) UILabel * timeLabel;

@end

@implementation RecentChatCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    _photoImgV = [[UIImageView alloc]init];
    [self.contentView addSubview:_photoImgV];
    
    [_photoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.width.and.height.equalTo(@50);
    }];
    
    _nameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_nameLabel];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_photoImgV);
        make.left.equalTo(_photoImgV.mas_right).offset(10);
    }];
    
    _msgIntroLabel = [[UILabel alloc]init];
    _msgIntroLabel.font = [UIFont systemFontOfSize:14];
    _msgIntroLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_msgIntroLabel];
    
    [_msgIntroLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.bottom.equalTo(_photoImgV);
        make.width.lessThanOrEqualTo(@(WZWScreenW-100));
    }];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_timeLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(_photoImgV);
    }];
}

-(void)configCellWithModel:(XMPPMessageArchiving_Message_CoreDataObject *)msgObj{
    _timeLabel.text = [self handleTimeWithDate:msgObj.timestamp];
    //outgoing = 0，获得消息
    if (msgObj.isOutgoing) {//发送消息
        UIImage * img;
        img = [UIImage imageWithData:[WZWAccount shareAccount].photoData];
        if (img) {
            _photoImgV.image = img;
        }else{
            _photoImgV.image = [UIImage imageNamed:@"DefaultHead"];
        }
        _nameLabel.text = [WZWAccount shareAccount].loginUser;
    }else{//获取消息
        XMPPUserCoreDataStorageObject * user = [[XMPPTool sharedXMPPTool].rosterStorage userForJID:msgObj.bareJid xmppStream:[XMPPTool sharedXMPPTool].xmppStream managedObjectContext:[XMPPTool sharedXMPPTool].rosterStorage.mainThreadManagedObjectContext];
        _nameLabel.text = [user.displayName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"@%@",WZWDomain] withString:@""];
        //显示好友的头像
        if (user.photo) {
            _photoImgV.image = user.photo;
        }else{
            //从服务器获取头像
            NSData * imgData = [[XMPPTool sharedXMPPTool].avatar photoDataForJID:user.jid];
            if (imgData) {
                _photoImgV.image = [UIImage imageWithData:imgData];
            }else{
                _photoImgV.image = [UIImage imageNamed:@"DefaultHead"];
            }
            
        }

    }
    _msgIntroLabel.text = [NSString stringWithFormat:@"%@:%@",_nameLabel.text,msgObj.body];
}

//处理时间问题
-(NSString *)handleTimeWithDate:(NSDate *)timeStamp{
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    if ([timeStamp isToday]) {
        [fmt setDateFormat:@"hh:mm"];
        return[NSString stringWithFormat:@"今天 %@",[fmt stringFromDate:timeStamp]];
    }else{
        [fmt setDateFormat:@"yyyy/MM/dd"];
        return [fmt stringFromDate:timeStamp];
    }
    return @"";
}

@end
