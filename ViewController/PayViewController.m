//
//  PayViewController.m
//  云收银
//
//  Created by 黄达能 on 15/7/31.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import "PayViewController.h"
#import "CameraViewController.h"
#import "PictureViewController.h"

@interface PayViewController ()

@property (strong, nonatomic) IBOutlet UILabel *calculator;

@property (strong, nonatomic) IBOutlet UILabel *number;

@property (strong, nonatomic) IBOutlet UILabel *totalNum;

@end

@implementation PayViewController

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [SlideNavigationController sharedInstance].navigationBarHidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SlideNavigationController sharedInstance].navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0,20,100, 60);
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(25, 15, 20, 20)];
    image.image=[UIImage imageNamed:@"broadside"];
    [btn addSubview:image];
    [btn addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.view.backgroundColor=[SlideNavigationController sharedInstance].navigationBar.barTintColor;
    
    _calculator.backgroundColor=[UIColor colorWithRed:220/255.0 green:221/255.0 blue:222/255.0 alpha:1];
    _number.textAlignment=NSTextAlignmentRight;
    [self changeButton];
    
    DVSwitch *switcher=[[DVSwitch alloc]initWithStringsArray:@[@"商户扫码",@"用户扫码"]];
    switcher.layer.borderWidth=1.5;
    switcher.layer.cornerRadius=15;
    switcher.layer.masksToBounds=YES;
    switcher.layer.borderColor=[UIColor whiteColor].CGColor;
    switcher.labelTextColorInsideSlider=self.view.backgroundColor;
    switcher.translatesAutoresizingMaskIntoConstraints=NO;
    switcher.font=[UIFont systemFontOfSize:13];
    [switcher setPressedHandler:^(NSUInteger index){
        UIButton *btn=(UIButton *)[self.view viewWithTag:60];//开始扫描 按钮
        if ([btn.titleLabel.text isEqualToString:@"开始扫描"]) {
            [btn setTitle:@"生成二维码" forState:UIControlStateNormal];
        }
        else{
            [btn setTitle:@"开始扫描" forState:UIControlStateNormal];
        }
    }];
    [self.view addSubview:switcher];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:switcher attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_calculator attribute:NSLayoutAttributeTop multiplier:1 constant:-10]];//y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:switcher attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_calculator attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];//x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:switcher attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:120]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:switcher attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30]];
}
-(void)changeButton
{
    for(int i=1;i<=10;i++)
    {
        UIButton *btn=(UIButton *)[self.view viewWithTag:i];
        btn.layer.cornerRadius=10;
        btn.layer.masksToBounds=YES;
        btn.layer.borderWidth=2.2;
        btn.layer.borderColor=[UIColor whiteColor].CGColor;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    for(int i=2;i<7;i++)
    {
        UIButton *btn=(UIButton *)[self.view viewWithTag:i*10];
        btn.layer.cornerRadius=10;
        btn.layer.masksToBounds=YES;
        btn.layer.borderWidth=2.2;
        btn.layer.borderColor=[UIColor whiteColor].CGColor;
        if(btn.tag==20)
        {
            [btn addTarget:self action:@selector(clearAll) forControlEvents:UIControlEventTouchUpInside];
        }
        if (btn.tag==30)
        {
            [btn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
        }
        if (btn.tag==40)
        {
            btn.layer.borderColor=[UIColor colorWithRed:255/255.0 green:237/255.0 blue:0/255.0 alpha:1].CGColor;
            [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:237/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
        }
        if (btn.tag==50)
        {
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        if(btn.tag==60)//开始扫描
        {
            btn.layer.borderColor=[UIColor colorWithRed:255/255.0 green:237/255.0 blue:0/255.0 alpha:1].CGColor;
            [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:237/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(goStart:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    for(int i=1;i<3;i++)
    {
        UIButton *btn=(UIButton *)[self.view viewWithTag:i*100];
        if(btn.tag==100)//支付宝
        {
            btn.layer.cornerRadius=10;
            btn.layer.masksToBounds=YES;
            btn.backgroundColor=[UIColor colorWithRed:255/255.0 green:146/255.0 blue:0 alpha:1];
            [btn addTarget:self action:@selector(pay1) forControlEvents:UIControlEventTouchUpInside];
            btn.layer.borderWidth=2.0f;
            btn.layer.borderColor=[UIColor whiteColor].CGColor;
        }
        else//微信
        {
            btn.layer.cornerRadius=10;
            btn.layer.masksToBounds=YES;
            btn.backgroundColor=[UIColor colorWithRed:0/255.0 green:203/255.0 blue:53/255.0 alpha:1];
            [btn addTarget:self action:@selector(pay2) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
}



-(void)add
{
    NSMutableString *string=[NSMutableString stringWithString:_number.text];
    [string appendString:@"+"];
    _number.text=string;
}
-(void)delete
{
    NSMutableString *string=[NSMutableString stringWithString:_number.text];
    if (string.length>0) {
        [string deleteCharactersInRange:NSMakeRange(string.length-1, 1)];//删除最后一个字符
        _number.text=string;
    }
    NSMutableString *string2=[NSMutableString stringWithString:_number.text];
    NSArray *array=[string2 componentsSeparatedByString:@"+"];
    float count=0;
    for (int i=0; i<array.count; i++) {
        float x=[array[i] floatValue];
        count=x+count;
    }
    _totalNum.text=[NSString stringWithFormat:@"=%.2f",count];
}
-(void)clearAll
{
    _number.text=@"";
    _totalNum.text=@"=0.00";
}
//点数字 或者小数点
-(void)btnClick:(UIButton *)btn
{
    NSString *string=_number.text;
    NSMutableString *str=[NSMutableString stringWithString:string];
    if(btn.tag==10)
    {
        [str appendString:[NSString stringWithFormat:@"0"]];
    }
    if(btn.tag==50)
    {
        [str appendString:[NSString stringWithFormat:@"."]];
    }
    if(btn.tag!=10&&btn.tag!=50)
    {
        [str appendString:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
    }
    _number.text=str;
    
    NSMutableString *string2=[NSMutableString stringWithString:_number.text];
    NSArray *array=[string2 componentsSeparatedByString:@"+"];
    float count=0;
    for (int i=0; i<array.count; i++) {
        float x=[array[i] floatValue];
        count=x+count;
    }
    _totalNum.text=[NSString stringWithFormat:@"=%.2f",count];

}

//按开始扫描按钮
-(void)goStart:(UIButton *)btn
{
    if([btn.titleLabel.text isEqualToString:@"开始扫描"])
    {
        //使用ZBar自带的
//        ZBarReaderViewController *reader=[ZBarReaderViewController new];
//        reader.readerDelegate=self;
//        ZBarImageScanner *scanner=reader.scanner;
//        [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
//        
//        reader.showsZBarControls=YES;
//        
//        [self presentViewController:reader animated:YES completion:nil];
        
        CameraViewController *camera=[CameraViewController new] ;
        [[SlideNavigationController sharedInstance] pushViewController:camera animated:YES];
    }
    if([btn.titleLabel.text isEqualToString:@"生成二维码"])
    {
        PictureViewController *picture;
        if(SCREENHEIGHT<500)//iphone 4
        {
            picture=[[PictureViewController alloc]initWithNibName:@"PictureViewController_iphone4" bundle:nil];
        }
        else
        {
            picture=[[PictureViewController alloc]initWithNibName:@"PictureViewController" bundle:nil];
        }
        NSMutableString *str=[NSMutableString stringWithString:_totalNum.text];
        [str deleteCharactersInRange:NSMakeRange(0, 1)];
        picture.string=str;
        picture.payMethod=_payMethod;
        [[SlideNavigationController sharedInstance] pushViewController:picture animated:YES];
    }
}

//支付宝
-(void)pay1
{
    _payMethod=0;
    UIButton *btn=(UIButton *)[self.view viewWithTag:100];
    btn.layer.borderWidth=2.0f;
    btn.layer.borderColor=[UIColor whiteColor].CGColor;
    
    UIButton *btn1=(UIButton *)[self.view viewWithTag:200];
    btn1.layer.borderWidth=0;
}
//微信支付
-(void)pay2
{
    _payMethod=1;
    UIButton *btn=(UIButton *)[self.view viewWithTag:200];
    btn.layer.borderWidth=2.0f;
    btn.layer.borderColor=[UIColor whiteColor].CGColor;
    
    UIButton *btn1=(UIButton *)[self.view viewWithTag:100];
    btn1.layer.borderWidth=0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
