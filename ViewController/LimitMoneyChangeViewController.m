//
//  LimitMoneyChangeViewController.m
//  云收银
//
//  Created by 黄达能 on 15/7/30.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import "LimitMoneyChangeViewController.h"
#import "MyTextField.h"

@interface LimitMoneyChangeViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;

@property(nonatomic,strong)MyTextField *phoneNum;

@property(nonatomic,strong)MyTextField *name;

@property(nonatomic,strong)MyTextField *email;

@end

@implementation LimitMoneyChangeViewController

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"限额提升";
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
    
    CGFloat height=40*SCREENHEIGHT/568;
    CGFloat space,width;
    if(SCREENHEIGHT<500)
    {
        height=40;
        space=10;
        width=47;
    }
    else
    {
        space=15;
        width=38;
    }
    
    _phoneNum=[[MyTextField alloc]initWithFrame:CGRectMake(0, 0, 0, height) withImageName:@"phone" withPlaceHolder:@"电话"];
    _name=[[MyTextField alloc]initWithFrame:CGRectMake(0, 0, 0, height) withImageName:@"name" withPlaceHolder:@"姓名"];
    _email=[[MyTextField alloc]initWithFrame:CGRectMake(0, 0, 0, height) withImageName:@"email" withPlaceHolder:@"邮箱"];
    _phoneNum.delegate=self;
    _name.delegate=self;
    _email.delegate=self;
    
    _phoneNum.translatesAutoresizingMaskIntoConstraints=NO;
    _name.translatesAutoresizingMaskIntoConstraints=NO;
    _email.translatesAutoresizingMaskIntoConstraints=NO;
    _phoneNum.backgroundColor=[UIColor colorWithRed:30/255.0 green:194/255.0 blue:213/255.0 alpha:1];
    _name.backgroundColor=[UIColor colorWithRed:30/255.0 green:194/255.0 blue:213/255.0 alpha:1];
    _email.backgroundColor=[UIColor colorWithRed:30/255.0 green:194/255.0 blue:213/255.0 alpha:1];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 0, height);
    [btn setTitle:@"确认修改" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius=height/2;
    btn.layer.masksToBounds=YES;
    btn.backgroundColor=[UIColor colorWithRed:95/255.0 green:226/255.0 blue:238/255.0 alpha:1];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    btn.translatesAutoresizingMaskIntoConstraints=NO;
    
    [self.view addSubview:_phoneNum];
    [self.view addSubview:_name];
    [self.view addSubview:_email];
    [self.view addSubview:btn];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_phoneNum attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_label attribute:NSLayoutAttributeBottom multiplier:1 constant:space-10]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_phoneNum attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:width]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_phoneNum attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-width]];
    [_phoneNum addConstraint:[NSLayoutConstraint constraintWithItem:_phoneNum attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_name attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_phoneNum attribute:NSLayoutAttributeBottom multiplier:1 constant:space]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_name attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_phoneNum attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_name attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_phoneNum attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_name attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_phoneNum attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_email attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_name attribute:NSLayoutAttributeBottom multiplier:1 constant:space]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_email attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_phoneNum attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_email attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_phoneNum attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_email attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_phoneNum attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_email attribute:NSLayoutAttributeBottom multiplier:1 constant:space]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_phoneNum attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_phoneNum attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_phoneNum attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
   
}
-(void)btnClick
{
    
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
    [self textFieldShouldReturn:_phoneNum];
    [self textFieldShouldReturn:_name];
}
-(void)animateTextField:(UITextField *)textField up:(BOOL)up
{
    int movementDistance;
    if (SCREENHEIGHT<500) {
        movementDistance=110;
    }
    else{
         movementDistance=60;
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
    
}


@end
