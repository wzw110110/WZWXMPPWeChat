//
//  ToolbarView.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/31.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "ToolbarView.h"

@implementation ToolbarView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    _voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_voiceBtn setBackgroundImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
    [_voiceBtn setBackgroundImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateSelected];
    [self addSubview:_voiceBtn];
    
    [_voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(self).offset(5);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
    }];
    
    _typeSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_typeSelectBtn setBackgroundImage:[UIImage imageNamed:@"TypeSelectorBtn_Black"] forState:UIControlStateNormal];
    [self addSubview:_typeSelectBtn];
    
    [_typeSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_equalTo(self).offset(-5);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
    }];
    
    _emotionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_emotionBtn setBackgroundImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
    [self addSubview:_emotionBtn];
    
    [_emotionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_equalTo(_typeSelectBtn.mas_left).offset(-10);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
    }];
    
    _contentTF = [[UITextField alloc]init];
    _contentTF.returnKeyType = UIReturnKeySend;
    _contentTF.borderStyle = UITextBorderStyleRoundedRect;
    _contentTF.hidden = NO;
    [self addSubview:_contentTF];
    
    [_contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(_voiceBtn.mas_right).offset(10);
        make.right.mas_equalTo(_emotionBtn.mas_left).offset(-10);
        make.height.mas_equalTo(35);
    }];
    
    _sayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sayBtn setTitle:@"按住说话" forState:UIControlStateNormal];
    [_sayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _sayBtn.layer.cornerRadius = 5;
    _sayBtn.layer.borderWidth = 1;
    _sayBtn.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _sayBtn.hidden = YES;
    [self addSubview:_sayBtn];
    
    [_sayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(_voiceBtn.mas_right).offset(10);
        make.right.mas_equalTo(_emotionBtn.mas_left).offset(-10);
        make.height.mas_equalTo(35);
    }];
}

@end
