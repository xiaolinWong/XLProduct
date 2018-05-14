//
//  XLLoginViewController.m
//  XLProduct
//
//  Created by Mac on 2018/1/8.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "XLLoginViewController.h"
#import "XLUpDataViewController.h"
#import "XLloginAPi.h"
#import "XLURLProtocol.h"

@interface XLLoginViewController ()
{
    NSTimer *_timer;
    long _timenum;
}
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UIButton *getNumberBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton  *xieyiLB;
@property (weak, nonatomic) IBOutlet UILabel *codeLB;

@end

@implementation XLLoginViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
 
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //背景阴影
    ViewShadow(_bgView, 0, 0, kXLConeColorl, 0.5, 10.0);
    //登录按钮
    ViewShadowRadius(_loginBtn, 30, 0, 5, kXLShadowBuleColor, 0.5, 2.0);
  
    //进来
    [self.phoneTF becomeFirstResponder];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.phoneTF.text = [defaults objectForKey:kHCLoginAccount];
    
    
    [ _xieyiLB setAttributedTitle:[Utils changeStringColorWithStart:@"点击登录,即表示您同意" colorString:@"《易米帮使用协议》" end:@"" withColor:kHCNavBarColor withFont:SYSTEMFONT(13)] forState:UIControlStateNormal ];
    //协议点击
    [[_xieyiLB rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [Utils opeWebWithUrl:[NSString stringWithFormat:@"%@user/register/protocol.html",kURL] andWithNav:self.navigationController];
    }];
    
    //获取验证码
    [[_getNumberBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if ([Utils checkPhoneNum:self.phoneTF.text]) {
             [self getNumberCode];
        }else{
            [self showHUDText:@"请输入正确手机号"];
        }
    }];
    
    
    //登录按钮
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //第一次
        if ([Utils checkPhoneNum:self.phoneTF.text]) {
            if (IsEmpty(self.passWordTF.text)) {
                [self showHUDText:@"请输入验证码"];
                return ;
            }
            [self requestForLogin];
            
        }else{
            [self showHUDText:@"请输入正确手机号"];
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}

-(void)startTimer
{
    if ([_timer isValid]||_timer !=nil) {
        [_timer invalidate];
        _timer=nil;
    }
    _timenum=60;
    //    [_codeBtn setTitle:[NSString stringWithFormat:@"%ld秒",--_timenum] forState:UIControlStateNormal];
    self.codeLB.text=[NSString stringWithFormat:@"%ld秒",--_timenum];
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handkeTimerAction) userInfo:nil repeats:YES];
}
-(void)handkeTimerAction
{
    self.getNumberBtn.enabled=NO;

    self.codeLB.text=[NSString stringWithFormat:@"%ld秒",--_timenum];
    if (_timenum==0) {
        [_timer invalidate];
        _timer=nil;
        self.codeLB.text=@"重新获取";
        self.getNumberBtn.enabled=YES;
    }
}
#pragma mark network
-(void)getNumberCode{
    
    [self showHUDView:nil];
    XLPubicRequsetApi *api=[[XLPubicRequsetApi alloc]init];
    api.requestStr=@"user/verification_code/send";
    api.dicBody=@{@"username":self.phoneTF.text};
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
        [self hideHUDView];
        if (requestStatus==HCRequestStatusSuccess) {
            //搜索成功
            [self startTimer];
            [self showHUDText:@"获取成功"];
        }else{
            [self showHUDError:message];
        }
    }];
}

//登录
-(void)requestForLogin{
    [self showHUDView:nil];
    XLloginAPi *api=[[XLloginAPi alloc]init];
    api.phoneNumber=self.phoneTF.text;
    api.codeNumber=self.passWordTF.text;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, XLLoginInfo *longinInfo) {
        [self hideHUDView];
        if (requestStatus==HCRequestStatusSuccess) {
            //登录
            //保存账号
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.phoneTF.text forKey:kHCLoginAccount];
//            [HCAccountMgr manager].loginInfo = longinInfo;
            
//            if ([longinInfo.has_resume isEqualToString:@"0"]) {
//                XLUpDataViewController *upDataVC = [[XLUpDataViewController alloc]init];
//                [self.navigationController pushViewController:upDataVC animated:YES];
//                return ;
//            }
            
            //登录信息存数据库
            [[HCAccountMgr manager] saveLoginInfoToDB];
            [HCAccountMgr manager].isLogined = YES;
            
            [[HCAccountMgr manager] updateLoginInfoToDB];
            //绑定推送
//            [UMessage addAlias:longinInfo.user_id type:kUMessageAliasTypeSina response:^(id responseObject, NSError *error) {
            
//            }];
//            //登录友盟
//            [self loginInUmeng:longinInfo.openim_id andUmengPw:longinInfo.openim_pw];

            
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
