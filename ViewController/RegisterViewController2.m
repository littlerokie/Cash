//
//  RegisterViewController2.m
//  云收银
//
//  Created by 黄达能 on 15/7/28.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import "RegisterViewController2.h"
#import "BillViewController.h"
#import "LeftMenuViewController.h"
#import "MyTextField.h"
#import "LoginViewController.h"



@interface RegisterViewController2 ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UILabel *label2;

@end

@implementation RegisterViewController2
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_bank resignFirstResponder];
    [_name resignFirstResponder];
    [_bankID resignFirstResponder];
    [_phoneNum resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0/255.0 green:193/255.0 blue:217/255.0 alpha:1.0];
    [self createUI];
}

-(void)createUI
{
    CGFloat height=45*SCREENHEIGHT/568;
    
    CGFloat space,width;
    if(SCREENHEIGHT<500)//iphone 4
    {
        space=8;//间距
        width=47;
    }
    else
    {
       space=15;
        width=30;
    }
    
    _bank=[[MyTextField alloc]initWithFrame:CGRectMake(0,0, 0,height) withImageName:@"account" withPlaceHolder:@"请输入您的开户银行，精确到支行"];
    _name=[[MyTextField alloc]initWithFrame:CGRectMake(0,0, 0, height) withImageName:@"name" withPlaceHolder:@"您的姓名"];
    _bankID=[[MyTextField alloc]initWithFrame:CGRectMake(0, 0, 0, height) withImageName:@"card" withPlaceHolder:@"请输入您的银行账号"];
    _phoneNum=[[MyTextField alloc]initWithFrame:CGRectMake(0, 0, 0,height) withImageName:@"phone" withPlaceHolder:@"请输入您的手机号"];
    _bank.delegate=self;
    _name.delegate=self;
    _bankID.delegate=self;
    _phoneNum.delegate=self;
    
    UIButton *nextStep=[UIButton buttonWithType:UIButtonTypeCustom];
    nextStep.frame=CGRectMake(0,0, 0, height);
    nextStep.layer.cornerRadius=nextStep.frame.size.height/2;
    nextStep.layer.masksToBounds=YES;
    nextStep.backgroundColor=[UIColor colorWithRed:95/255.0 green:226/255.0 blue:238/255.0 alpha:1];
    [nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    nextStep.titleLabel.font=[UIFont systemFontOfSize:15];
    [nextStep addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    _bank.translatesAutoresizingMaskIntoConstraints=NO;
    _name.translatesAutoresizingMaskIntoConstraints=NO;
    _bankID.translatesAutoresizingMaskIntoConstraints=NO;
    _phoneNum.translatesAutoresizingMaskIntoConstraints=NO;
    nextStep.translatesAutoresizingMaskIntoConstraints=NO;
    
    [self.view addSubview:_bank];
    [self.view addSubview:_name];
    [self.view addSubview:_bankID];
    [self.view addSubview:_phoneNum];
    [self.view addSubview:nextStep];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bank attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_label2 attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bank attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:width]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bank attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-width]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bank attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_name attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_bank attribute:NSLayoutAttributeBottom multiplier:1 constant:space]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_name attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_bank attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_name attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_bank attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_name attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_bank attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bankID attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_name attribute:NSLayoutAttributeBottom multiplier:1 constant:space]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bankID attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_name attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bankID attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_name attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bankID attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_name attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_phoneNum attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_bankID attribute:NSLayoutAttributeBottom multiplier:1 constant:space]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_phoneNum attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_bankID attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_phoneNum attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_bankID attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_phoneNum attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_bankID attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:nextStep attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_phoneNum attribute:NSLayoutAttributeBottom multiplier:1 constant:space]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:nextStep attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_phoneNum attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:nextStep attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_phoneNum attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:nextStep attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_phoneNum attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
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
    [self textFieldShouldReturn:_bank];
    [self textFieldShouldReturn:_name];
    [self textFieldShouldReturn:_bankID];
    [self textFieldShouldReturn:_phoneNum];
}
-(void)animateTextField:(UITextField *)textField up:(BOOL)up
{
    int movementDistance;
    if(SCREENHEIGHT<500)//iphone 4
    {
         movementDistance=180;
    }
    else
    {
         movementDistance=160;
    }
    const float movementDuration=0.3f;
    
    int movement=(up? -movementDistance:movementDistance);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    
    self.view.frame=CGRectOffset(self.view.frame, 0, movement);
    
    [UIView commitAnimations];
}
#pragma mark -下一步
-(void)next
{
    BillViewController *bill=[[BillViewController alloc]init];
    [[SlideNavigationController sharedInstance] pushViewController:bill animated:YES];
}
@end
