//
//  XLUpDataViewController.m
//  XLProduct
//
//  Created by Mac on 2018/1/8.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "XLUpDataViewController.h"
//#import "XLFinshBtn.h"
#import "XLUpDataTableViewCell.h"
#import "XLUPImageAPI.h"
//#import "XLImageChooseMgr.h"
#import "XLPOSTPubicAPI.h"
@interface XLUpDataViewController ()

@property (nonatomic, strong) NSMutableDictionary *upDic;

@end

@implementation XLUpDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"基本信息";
    [self setupBackItem];
    self.tableView.tableHeaderView=HCTabelHeadView(0.1);
 
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ident=@"xlupdataCell";
    XLUpDataTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell=[[XLUpDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident withIndex:indexPath];
    }
    WEAKSELF
    cell.headImageClcik = ^(UIButton *headBtn) {
        
//        [[XLImageChooseMgr manager] modifyAvatarWithController:self completion:^(BOOL result, UIImage *image, NSString *msg) {
//
//            [weakSelf requestForUpImage:image withBtn:headBtn];
//        }];
    };
    cell.nameClcik = ^(NSString *nameStr) {
        [weakSelf.upDic setObject:nameStr forKey:@"realname"];
    };
    cell.leftBtnClcik = ^(UIButton *leftBtn) {
        if ([leftBtn.titleLabel.text isEqualToString:@"男"]) {
             [weakSelf.upDic setObject:@"1" forKey:@"gender"];
        }else if ([leftBtn.titleLabel.text isEqualToString:@"在校学生"]){
             [weakSelf.upDic setObject:@"1" forKey:@"identity"];
        }
    };
    cell.rightBtnClcik = ^(UIButton *rightBtn) {
        if ([rightBtn.titleLabel.text isEqualToString:@"女"]) {
            [weakSelf.upDic setObject:@"2" forKey:@"gender"];
        }else if ([rightBtn.titleLabel.text isEqualToString:@"社会人士"]){
            [weakSelf.upDic setObject:@"2" forKey:@"identity"];
        }
    };
    cell.datePickClcik = ^(NSString *dateStr) {
        [weakSelf.upDic setObject:dateStr forKey:@"birthday"];
    };

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 200;
    }
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
//    XLFinshBtn *btn=[[XLFinshBtn alloc]initWithFrame:CGRectMake(25, 15, SCREEN_WIDTH-50, 50) withTile:@"完成"];
//    WEAKSELF
//    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        if (IsEmpty([HCAccountMgr manager].loginInfo.avatar)) {
//            [weakSelf showHUDText:@"请上传头像"];
//            return ;
//        }
//        NSString *name=weakSelf.upDic[@"realname"];
//        if (name.length>8) {
//            [weakSelf showHUDText:@"姓名最多8个字"];
//            return ;
//        }
//        if (IsEmpty(name)) {
//            [weakSelf showHUDText:@"请填写姓名"];
//            return ;
//        }else if (IsEmpty(weakSelf.upDic[@"birthday"])){
//            [weakSelf showHUDText:@"请选择生日"];
//            return ;
//        }else if (IsEmpty(weakSelf.upDic[@"gender"])){
//            [weakSelf showHUDText:@"请选择性别"];
//            return ;
//        }else if (IsEmpty(weakSelf.upDic[@"identity"])){
//            [weakSelf showHUDText:@"请选择身份"];
//            return ;
//        }
//
//        [weakSelf requestForSaveRemue];
//    }];
//    [view addSubview:btn];
    return view;
}
-(NSMutableDictionary *)upDic{
    if (!_upDic) {
        _upDic=[NSMutableDictionary new];
    }
    return _upDic;
}
//上传头像
-(void)requestForUpImage:(UIImage *)iamge withBtn:(UIButton *)btn{
    [self showHUDView:nil];
    XLUPImageAPI *api=[[XLUPImageAPI alloc]init];
    api.image=iamge;
    api.requestUrlstr=@"user/profile/avatarUpload";
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id data) {
        [self hideHUDView];
        if (requestStatus==HCRequestStatusSuccess) {
            NSString *str=data;
            
            [btn setImage:iamge forState:UIControlStateNormal];
            
//            [HCAccountMgr manager].loginInfo.avatar=str;
            [[HCAccountMgr manager] updateLoginInfoToDB];
            [self showHUDText:@"上传成功"];
        }else{
            [self showHUDError:message];
        }
    }];
}
-(void)requestForSaveRemue{
    
    [self showHUDView:nil];
    XLPOSTPubicAPI *api=[[XLPOSTPubicAPI alloc]init];
    api.requestStr=@"user/resume/my";
    api.dicBody=self.upDic;
    
    api.method=YTKRequestMethodPOST;
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
        [self hideHUDView];
        if (requestStatus==HCRequestStatusSuccess) {
            
            //登录信息存数据库
            [[HCAccountMgr manager] saveLoginInfoToDB];
            [HCAccountMgr manager].isLogined = YES;
            
            [[HCAccountMgr manager] updateLoginInfoToDB];
            
            //登录友盟
//            [self loginInUmeng:[HCAccountMgr manager].loginInfo.openim_id andUmengPw:[HCAccountMgr manager].loginInfo.openim_pw];
            
        }else{
            [self showHUDError:message];
        }
    }];
}

-(void)loginInUmeng:(NSString *)umengid  andUmengPw:(NSString*)umengpw
{
    //发送消息啊
    [[HCAccountMgr manager] login];
    
//    [[SPKitExample sharedInstance] callThisAfterISVAccountLoginSuccessWithYWLoginId:umengid passWord:umengpw preloginedBlock:^{
//        /// 可以显示会话列表页面
//
//    } successBlock:^{
//        //  到这里已经完成SDK接入并登录成功，你可以通过exampleMakeConversationListControllerWithSelectItemBlock获得会话列表
//        /// 可以显示会话列表页面
//
//    } failedBlock:^(NSError *aError) {
//        if (aError.code == YWLoginErrorCodePasswordError || aError.code == YWLoginErrorCodePasswordInvalid || aError.code == YWLoginErrorCodeUserNotExsit) {
//            /// 可以显示错误提示
//
//        }
//    }];
    
}
@end
