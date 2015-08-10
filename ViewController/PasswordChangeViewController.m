//
//  PasswordChangeViewController.m
//  云收银
//
//  Created by 黄达能 on 15/7/31.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import "PasswordChangeViewController.h"
#import "MyTextField.h"

@interface PasswordChangeViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)MyTextField *currentPass;

@property(nonatomic,strong)MyTextField *password;

@property(nonatomic,strong)MyTextField *passwordAgain;

@end

@implementation PasswordChangeViewController

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_currentPass resignFirstResponder];
    [_password resignFirstResponder];
    [_passwordAgain resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"密码修改";
    self.view.backgroundColor=[UIColor colorWithRed:30/255.0 green:194/255.0 blue:213/255.0 alpha:1];
    [self createNav];
    [self createUI];
}

-(void)createNav
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 20, 20);
    [btn setImage:[UIImage imageNamed:@"broadside"] forState:UIControlStateNormal];
    [btn addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=left;
    [SlideNavigationController sharedInstance].leftBarButtonItem=left;
}

-(void)createUI
{
    CGFloat height=43*SCREENHEIGHT/568;
    CGFloat space,width;
    if (SCREENHEIGHT<500)
    {
        height=40;
        space=15;
        width=55;
    }
    else
    {
        space=20;
        width=50;
    }
    
    _currentPass=[[MyTextField alloc]initWithFrame:CGRectMake(0, 0, 0, height) withImageName:@"password" withPlaceHolder:@"当前密码"];
    _currentPass.delegate=self;
    _password=[[MyTextField alloc]initWithFrame:CGRectMake(0, 0, 0, height) withImageName:@"password" withPlaceHolder:@"新密码"];
    _password.delegate=self;
    _passwordAgain=[[MyTextField alloc]initWithFrame:CGRectMake(0, 0, 0, height) withImageName:@"password" withPlaceHolder:@"确认新密码"];
    _passwordAgain.tag=10;
    _passwordAgain.delegate=self;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 0,height);
    [btn setTitle:@"确认修改" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius=btn.frame.size.height/2;
    btn.layer.masksToBounds=YES;
    btn.backgroundColor=[UIColor colorWithRed:95/255.0 green:226/255.0 blue:238/255.0 alpha:1];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    
    _currentPass.translatesAutoresizingMaskIntoConstraints=NO;
    _password.translatesAutoresizingMaskIntoConstraints=NO;
    _passwordAgain.translatesAutoresizingMaskIntoConstraints=NO;
    _currentPass.backgroundColor=[UIColor colorWithRed:30/255.0 green:194/255.0 blue:213/255.0 alpha:1];
    _password.backgroundColor=[UIColor colorWithRed:30/255.0 green:194/255.0 blue:213/255.0 alpha:1];
    _passwordAgain.backgroundColor=[UIColor colorWithRed:30/255.0 green:194/255.0 blue:213/255.0 alpha:1];
    btn.translatesAutoresizingMaskIntoConstraints=NO;
    
    [self.view addSubview:_currentPass];
    [self.view addSubview:_password];
    [self.view addSubview:_passwordAgain];
    [self.view addSubview:btn];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_currentPass attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:100]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_currentPass attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:width]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_currentPass attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-width]];
    [_currentPass addConstraint:[NSLayoutConstraint constraintWithItem:_currentPass attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant: height]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_password attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_currentPass attribute:NSLayoutAttributeBottom multiplier:1 constant:space]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_password attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_currentPass attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_password attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_currentPass attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_password attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_currentPass attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordAgain attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_password attribute:NSLayoutAttributeBottom multiplier:1 constant:space]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordAgain attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_currentPass attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordAgain attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_currentPass attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordAgain attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_currentPass attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_passwordAgain attribute:NSLayoutAttributeBottom multiplier:1 constant:space]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_currentPass attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_currentPass attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_currentPass attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
}
-(void)btnClick
{
    [_currentPass resignFirstResponder];
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
    [self textFieldShouldReturn:_currentPass];
    [self textFieldShouldReturn:_password];
    [self textFieldShouldReturn:_passwordAgain];
}
-(void)animateTextField:(UITextField *)textField up:(BOOL)up
{
    int movementDistance;
    if(SCREENHEIGHT<500)//iphone 4
    {
        if (textField.tag==10) {
            movementDistance=50;
        }
        else
        {
            movementDistance=30;
        }
    }
    else
    {
        movementDistance=0;
    }
    const float movementDuration=0.3f;
    
    int movement=(up? -movementDistance:movementDistance);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    
    self.view.frame=CGRectOffset(self.view.frame, 0, movement);
    
    [UIView commitAnimations];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
