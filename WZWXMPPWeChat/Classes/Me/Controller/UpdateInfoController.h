//
//  UpdateInfoController.h
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/30.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "BaseViewController.h"
#import "TitleCell.h"

@class UpdateInfoController;
@protocol UpdateInfoControllerDelete <NSObject>

-(void)updateInfoController:(UpdateInfoController *)updateVC didFinishedSave:(id)sender;

@end
@interface UpdateInfoController : BaseViewController

@property (nonatomic,weak)id<UpdateInfoControllerDelete>delegate;

@property (nonatomic,strong) TitleCell * cell;

@end
