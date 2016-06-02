//
//  RecentChatCell.h
//  WZWXMPPWeChat
//
//  Created by iOS on 16/6/1.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecentChatCell : UITableViewCell

-(void)configCellWithModel:(XMPPMessageArchiving_Message_CoreDataObject *)msgObj;

@end
