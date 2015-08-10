//
//  DetailTableViewCell3.m
//  云收银
//
//  Created by 黄达能 on 15/8/1.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import "DetailTableViewCell3.h"
#import "DXAlertView.h"
@interface DetailTableViewCell3()

@property (weak, nonatomic) IBOutlet UILabel *account;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *isSuccess;

@property (weak, nonatomic) IBOutlet UILabel *billNum;

@property (weak, nonatomic) IBOutlet UILabel *information;

@property (weak, nonatomic) IBOutlet UIButton *refund;

@end

@implementation DetailTableViewCell3

- (void)awakeFromNib {
    self.refund.layer.cornerRadius=self.refund.frame.size.height/2;
    self.refund.layer.masksToBounds=YES;
    self.refund.backgroundColor=[UIColor colorWithRed:0/255.0 green:182/255.0 blue:205/255.0 alpha:1];
}
//交易退款
- (IBAction)refund:(id)sender {
    DXAlertView *alert=[[DXAlertView alloc]initWithTitle:@"本次可退款总额度 :￥880" contentText:@"请输入退款金额 ：" leftButtonTitle:@"取消" rightButtonTitle:@"确认"];
    [alert show];
    alert.rightBlock=^(){
        DXAlertView *view=[[DXAlertView alloc]initWithImage:@"right" withContentText:@"退款成功!" withButtonTitle:@"确定"];
        [view show];
    };
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
