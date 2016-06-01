//
//  ReceiveCell.h
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/31.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiveCell : UITableViewCell

@property (nonatomic,strong) UIImageView * photoImg;
@property (nonatomic,strong) UILabel * contentLabel;
@property (nonatomic,strong) UIImageView * imgV;

-(void)updateCellHeight:(XMPPMessageArchiving_Message_CoreDataObject *)msgObj;


@end
