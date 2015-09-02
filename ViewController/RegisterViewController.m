//
//  RegisterViewController.m
//  云收银
//
//  Created by 黄达能 on 15/7/28.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterViewController2.h"
#import "MyTextField.h"
#import "DBManager.h"

@interface RegisterViewController ()<UITextFieldDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;

@property(strong,nonatomic)MyTextField *email;

@property(strong,nonatomic)MyTextField *password;

@property(strong,nonatomic)MyTextField *passwordAgain;

@end

@implementation RegisterViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0/255.0 green:193/255.0 blue:217/255.0 alpha:1.0];
    [self createUI];
}

#pragma mark -TextField
-(void)createUI
{
    CGFloat height=45*SCREENHEIGHT/568;
    
    CGFloat space,width;
    if(SCREENHEIGHT<500)
    {
        height=40;
        space=15;
        width=55;
    }
    else
    {
        space=20;
        width=40;
    }
    
    
    _email=[[MyTextField alloc]initWithFrame:CGRectMake(0, 0,0, height) withImageName:@"email" withPlaceHolder:@"请输入邮箱"];
    _password=[[MyTextField alloc]initWithFrame:CGRectMake(0, 0, 0, height) withImageName:@"password" withPlaceHolder:@"请输入密码"];
    _passwordAgain=[[MyTextField alloc]initWithFrame:CGRectMake(0, 0, 0 , height) withImageName:@"password" withPlaceHolder:@"请确认密码"];
    _email.delegate=self;
    _password.delegate=self;
    _passwordAgain.delegate=self;
    
    _email.translatesAutoresizingMaskIntoConstraints=NO;
    _password.translatesAutoresizingMaskIntoConstraints=NO;
    _passwordAgain.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:_email];
    [self.view addSubview:_password];
    [self.view addSubview:_passwordAgain];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_email attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.label attribute:NSLayoutAttributeBottom multiplier:1 constant:space]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_email attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:width]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_email attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-width]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_email attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_password attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_email attribute:NSLayoutAttributeBottom multiplier:1 constant:space]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_password attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_email attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_password attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_email attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_password attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_email attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordAgain attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_password attribute:NSLayoutAttributeBottom multiplier:1 constant:space]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordAgain attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_email attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordAgain attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_email attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordAgain attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_email attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    UIButton *nextStep=[UIButton buttonWithType:UIButtonTypeCustom];
    nextStep.layer.cornerRadius=_email.frame.size.height/2;
    nextStep.layer.masksToBounds=YES;
    nextStep.backgroundColor=[UIColor colorWithRed:95/255.0 green:226/255.0 blue:238/255.0 alpha:1];
    [nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStep addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    nextStep.titleLabel.font=[UIFont systemFontOfSize:14];
    nextStep.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:nextStep];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:nextStep attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_passwordAgain attribute:NSLayoutAttributeBottom multiplier:1 constant:space]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:nextStep attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_email attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:nextStep attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_email attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:nextStep attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_email attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_email resignFirstResponder];
    [_password resignFirstResponder];
    [_passwordAgain resignFirstResponder];
}
//开始编辑时调用的方法
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}
//结束编辑调用的方法
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
    [textField resignFirstResponder];
    return YES;
}
//点击return调用的方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//触摸屏幕调用的方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self textFieldShouldReturn:_email];
    [self textFieldShouldReturn:_password];
    [self textFieldShouldReturn:_passwordAgain];
}
-(void)animateTextField:(UITextField *)textField up:(BOOL)up
{
    int movementDistance=140;
    float movementDuration=0.3f;
    
    int movement=(up? -movementDistance:movementDistance);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    
    self.view.frame=CGRectOffset(self.view.frame, 0, movement);
    
    [UIView commitAnimations];
}
#pragma mark- AlertView
-(void)next
{
    [_email resignFirstResponder];
    [_password resignFirstResponder];
    [_passwordAgain resignFirstResponder];
    NSString *str=[NSString stringWithFormat:@"激活链接将发送到该邮箱:%@",_email.text];
    DXAlertView *alert=[[DXAlertView alloc]initWithTitle:@"请激活邮箱" message:str cancelButtonTitle:@"取消" rightButtonTitle:@"确定"];
    [alert show];
    alert.rightBlock=^(){
        RegisterViewController2 *regist=[[RegisterViewController2 alloc]init];
        [[SlideNavigationController sharedInstance] pushViewController:regist animated:YES];
        
//        NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
//        [userdefaults setObject:_email.text forKey:@"email"];
//        [userdefaults setObject:_password.text forKey:@"password"];
//        [userdefaults synchronize];//同步存储到磁盘中 但不是必须的
//        
//        //清楚userdefaults中的数据
//        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//        DBObject *object=[[DBObject alloc]init];
//        object.email=_email.text;
//        object.passWord=_password.text;
//        [[DBManager shareManager] insertDataWithModel:object];
    };
}

@end
