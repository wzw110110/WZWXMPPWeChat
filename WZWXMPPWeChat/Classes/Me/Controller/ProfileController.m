//
//  ProfileController.m
//  WZWXMPPWeChat
//
//  Created by iOS on 16/5/30.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "ProfileController.h"
#import "XMPPvCardTemp.h"
#import "TitleCell.h"
#import "PhotoCell.h"
#import "UpdateInfoController.h"

@interface ProfileController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UpdateInfoControllerDelete>

@property (nonatomic,copy) NSArray * titleArray;
@property (nonatomic,copy) NSArray * dataArray;
@property (nonatomic,strong) PhotoCell * photoCell;
@property (nonatomic,strong) TitleCell * titleCell;
@property (nonatomic,strong) TitleCell * selectedCell;
@property (nonatomic,strong) NSIndexPath * selectedIndexPath;

@end

@implementation ProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
   //初始化界面
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取数据源
    [self loadData];
}

#pragma mark - 加载数据源
-(void)loadData{
    _titleArray = @[@[@"头像",@"名字",@"微信号"],@[@"公司",@"部门",@"职位",@"邮箱"]];
    //初始化电子名片模型
    XMPPvCardTemp * myVCard = [XMPPTool sharedXMPPTool].vCard.myvCardTemp;
    //图像
    UIImage * photImg;
    if (myVCard.photo) {
        photImg = [UIImage imageWithData:myVCard.photo];
    }else{
        photImg = [UIImage imageNamed:@"DefaultHead"];
    }
    //用户名
    NSString * loginUser = [WZWAccount shareAccount].loginUser;
    //获取头像
    _dataArray = @[@[photImg,myVCard.nickname,loginUser],@[myVCard.orgName!=nil?myVCard.orgName:@"",myVCard.orgUnits.count>0?myVCard.orgUnits[0]:@"",myVCard.title,myVCard.emailAddresses.count>0?myVCard.emailAddresses[0]:@""]];

    
}

#pragma mark - 表格视图代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return [_titleArray[section]count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    }
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * titleArr = _titleArray[indexPath.section];
    NSArray * dataArr = _dataArray[indexPath.section];
   
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        _photoCell = [tableView dequeueReusableCellWithIdentifier:@"photoCell"];
        if (!_photoCell) {
            _photoCell = [[PhotoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"photoCell"];
        }
        _photoCell.nameLabel.text = _titleArray[0][0];
        _photoCell.imageView.image = _dataArray[0][0];
        _photoCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return _photoCell;
    }else{
        _titleCell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        if (!_titleCell) {
            _titleCell = [[TitleCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"titleCell"];
        }
        _titleCell.nameLabel.text = titleArr[indexPath.row];
        _titleCell.valueLable.text = dataArr[indexPath.row];
        if (!(indexPath.section ==0 && indexPath.row == 2)) {
            _titleCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return _titleCell;

    }
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0 && indexPath.row == 0) {
        //选择图片
        [self chooseImg];
    }else if (indexPath.section ==0 && indexPath.row == 2) {
        return;
    }else{
        _selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        //跳转到下一个视图控制器
        UpdateInfoController * updateInfoVC = [[UpdateInfoController alloc]init];
        updateInfoVC.cell = _selectedCell;
        _selectedIndexPath = indexPath;
        [self.navigationController pushViewController:updateInfoVC animated:YES];
        updateInfoVC.delegate = self;
    }

}

#pragma mark - 选择图片
-(void)chooseImg{
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
    [sheet showInView:self.view];
}

//actionSheet代理方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 2) return;
    
    //初始化图片选择器
    UIImagePickerController * imgPC = [[UIImagePickerController alloc]init];
    //设置代理
    imgPC.delegate = self;
    //允许编辑图片
    imgPC.allowsEditing = YES;
    if (buttonIndex == 0) {//拍照
        imgPC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{//从相册中选择
        imgPC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    //显示控制器
    [self presentViewController:imgPC animated:YES completion:nil];
}

//图片选择器的代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取选择的图片
    UIImage * chooseImg = info[UIImagePickerControllerEditedImage];
    //更改cell里面的图片
    _photoCell.imageView.image = chooseImg;
    //移除图片选择的控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    //把新的图片保存到服务器
    [self updateInfoController:nil didFinishedSave:nil];
}

//编辑电子名片的代理
-(void)updateInfoController:(UpdateInfoController *)updateVC didFinishedSave:(id)sender{
    //获取当前的电子名片
    XMPPvCardTemp * myVCard = [XMPPTool sharedXMPPTool].vCard.myvCardTemp;
    //重新设置头像
    myVCard.photo = UIImageJPEGRepresentation(_photoCell.imageView.image, 0.75);
    //先赋值，再将改过的值改过来
    myVCard.nickname = _dataArray[0][1];
    NSArray * dataArr = _dataArray[1];
    myVCard.orgName = dataArr[0];
    myVCard.orgUnits = @[dataArr[1]];
    myVCard.title = dataArr[2];
    myVCard.emailAddresses = @[dataArr[3]];
    
    
    //重新设置myVCard里面的所有属性
    NSString * tempStr = _selectedCell.valueLable.text;
    
    
    
    if (_selectedIndexPath.section == 0) {
        myVCard.nickname = tempStr;
    }
    
    if (_selectedIndexPath.section == 1) {
        switch (_selectedIndexPath.row) {
            case 0:
                myVCard.orgName = tempStr;
                break;
            case 1:
                myVCard.orgUnits = @[tempStr];
                break;
            case 2:
                myVCard.title = tempStr;
                break;
            case 3:
            {
                //只保存一个邮箱
                if (tempStr.length>0) {
                    myVCard.emailAddresses = @[tempStr];
                }
            }
                break;
                
            default:
                break;
        }
    }
    
    //把图片保存到单例中
    [WZWAccount shareAccount].photoData = myVCard.photo;
    [[WZWAccount shareAccount] saveToSandBox];
    //把数据保存到服务器
    [[XMPPTool sharedXMPPTool].vCard updateMyvCardTemp:myVCard];
}

#pragma mark - 初始化界面
-(void)initView{
    self.title = @"个人信息";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"我" forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"barbuttonicon_back"] forState:UIControlStateNormal];
    leftBtn.imageEdgeInsets=UIEdgeInsetsMake(5, 0, 5, 0);
    leftBtn.frame=CGRectMake(0, 0, 30, 100);
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
