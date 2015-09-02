//
//  PictureViewController.m
//  云收银
//
//  Created by 黄达能 on 15/8/5.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import "PictureViewController.h"
#import "BillViewController.h"

@interface PictureViewController ()

@property (weak, nonatomic) IBOutlet UILabel *walletLabel;

@property (weak, nonatomic) IBOutlet UIImageView *picture;

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIButton *check;

@property (weak, nonatomic) IBOutlet UIImageView *wechat;

@end

@implementation PictureViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _picture.image=[QRCodeGenerator qrImageForString:@"http://www.baidu.com" imageSize:_picture.frame.size.width];
    self.title=@"扫码支付";
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 10, 18);
    [btn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=left;
    
    self.label.text=[NSString stringWithFormat:@"本次收款金额:￥ %@",_string];
    self.check.layer.cornerRadius=self.check.frame.size.height/2;
    self.check.layer.masksToBounds=YES;
    self.check.backgroundColor=[UIColor colorWithRed:38/255.0 green:202/255.0 blue:221/255.0 alpha:1];
    
    if(!_payMethod)
    {
        _walletLabel.text=@"请打开支付宝钱包";
        _wechat.image=[UIImage imageNamed:@"alipay"];
    }
    else
    {
        _walletLabel.text=@"请打开微信";
        _wechat.image=[UIImage imageNamed:@"wechat"];
    }
}
-(void)back
{
    [[SlideNavigationController sharedInstance] popViewControllerAnimated:YES];
}
- (IBAction)backToBill:(id)sender {
    BillViewController *bill=[[BillViewController alloc]init];
    [[SlideNavigationController sharedInstance] pushViewController:bill animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
