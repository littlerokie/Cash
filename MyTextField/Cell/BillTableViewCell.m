//
//  BillTableViewCell.m
//  云收银
//
//  Created by 黄达能 on 15/8/9.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import "BillTableViewCell.h"
#import "BillDetailViewController.h"

@interface BillTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *detail;

@property (weak, nonatomic) IBOutlet UILabel *isSuccess;

@property (weak, nonatomic) IBOutlet UILabel *money;

@end


@implementation BillTableViewCell

- (void)awakeFromNib {
    self.detail.layer.cornerRadius=self.detail.frame.size.height/4;
    self.detail.layer.masksToBounds=YES;
    self.detail.backgroundColor=[UIColor colorWithRed:0/255.0 green:193/255.0 blue:217/255.0 alpha:1.0];
}
- (IBAction)detailClick:(id)sender {
    BillDetailViewController *detail=[[BillDetailViewController alloc]init];
    [self.viewController.navigationController pushViewController:detail animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
@end