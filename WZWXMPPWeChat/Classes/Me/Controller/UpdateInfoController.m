//
//  UpdateInfoController.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/30.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "UpdateInfoController.h"
#import "UpdateInfoCell.h"

@interface UpdateInfoController ()

@property (nonatomic,strong) UpdateInfoCell * infoCell ;

@end

@implementation UpdateInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化界面
    [self initView];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _infoCell = [tableView dequeueReusableCellWithIdentifier:@"infoCell"];
    if (!_infoCell) {
        _infoCell = [[UpdateInfoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"infoCell"];
        _infoCell.infoTF.text = _cell.valueLable.text;
    }
    return _infoCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 初始化界面
-(void)initView{
    self.title = _cell.nameLabel.text;
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    leftBtn.frame=CGRectMake(0, 0, 30, 50);
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0, 0, 30, 50);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}

//保存
-(void)rightBtnClick:(UIButton *)btn{
    _cell.valueLable.text = _infoCell.infoTF.text;
    [self.navigationController popViewControllerAnimated:YES];
    
    //通过上一个视图控制器实现代理方法
    if ([self.delegate respondsToSelector:@selector(updateInfoController:didFinishedSave:)]) {
        [self.delegate updateInfoController:self didFinishedSave:btn];
    }
}

//取消
-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
