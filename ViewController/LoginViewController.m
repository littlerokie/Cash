//
//  LoginViewController.m
//  云收银
//
//  Created by 黄达能 on 15/7/27.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "BillViewController.h"
#import "LeftMenuViewController.h"
#import "MyTextField.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *isAuto;

@property (weak, nonatomic) IBOutlet UIImageView *logo;

@property (weak, nonatomic) IBOutlet UIButton *Login;

@property (weak, nonatomic) IBOutlet UIButton *Register;

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_email resignFirstResponder];
    [_password resignFirstResponder];

}
-(id)init
{
    if(self=[super initWithNibName:@"LoginViewController" bundle:nil])
    {

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0/255.0 green:193/255.0 blue:217/255.0 alpha:1.0];
    [self createTextField];
    
}
#pragma mark- textfield
-(void)createTextField
{
    CGFloat space,width;
    if(SCREENHEIGHT<500)//iphone 4
    {
        space=15;
        width=10;
    }
    else space=30;
    
    
    
    _email=[[MyTextField alloc]initWithFrame:CGRectMake(0, 0, 0, 50*SCREENHEIGHT/568)withImageName:@"email" withPlaceHolder:@"请输入邮箱"];
    _password=[[MyTextField alloc]initWithFrame:CGRectMake(0, 0, 0,50*SCREENHEIGHT/568) withImageName:@"password" withPlaceHolder:@"请输入密码"];
    _password.secureTextEntry=YES;
    
    _email.translatesAutoresizingMaskIntoConstraints=NO;
    _password.translatesAutoresizingMaskIntoConstraints=NO;
    _email.delegate=self;
    _password.delegate=self;
    [self.view addSubview:_email];
    [self.view addSubview:_password];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_password attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_isAuto attribute:NSLayoutAttributeTop multiplier:1 constant:-space]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_password attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.Login attribute:NSLayoutAttributeLeft multiplier:1 constant:width]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_password attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50*SCREENHEIGHT/568]];//height
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_password attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.Register attribute:NSLayoutAttributeRight multiplier:1 constant:-width]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_email attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_password attribute:NSLayoutAttributeTop multiplier:1 constant:-space]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_email attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_password attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_email attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_password attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];//height
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_email attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_password attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    self.Login.layer.cornerRadius=self.Login.frame.size.height/2;
    self.Login.layer.masksToBounds=YES;
    
    self.Register.layer.cornerRadius=self.Login.frame.size.height/2;
    self.Register.layer.masksToBounds=YES;
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
#pragma mark -登入 注册
- (IBAction)Login:(id)sender {
    BillViewController *bill=[[BillViewController alloc]init];
    [[SlideNavigationController sharedInstance] pushViewController:bill animated:YES];
}
- (IBAction)Regist:(id)sender {
    RegisterViewController *regist=[[RegisterViewController alloc]init];
    [[SlideNavigationController sharedInstance] pushViewController:regist animated:YES];
}


@end
