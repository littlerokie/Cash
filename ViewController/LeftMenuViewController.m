//
//  LeftMenuViewController.m
//  云收银
//
//  Created by 黄达能 on 15/7/29.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "BillViewController.h"
#import "LimitMoneyChangeViewController.h"
#import "PasswordChangeViewController.h"
#import "AccountChangeViewController.h"
#import "PayViewController.h"

@interface LeftMenuViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *table;

@end

@implementation LeftMenuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _array=[NSArray arrayWithObjects:@"扫码支付",@"交易管理",@"密码修改",@"账户修改",@"限额提升",@"网络账单",@"安全退出", nil];
    [self createTableView];
}
-(void)createTableView
{
    _table=[[UITableView alloc]initWithFrame:CGRectMake(0,20,100,self.view.frame.size.height-20) style:UITableViewStylePlain];
    _table.delegate=self;
    _table.dataSource=self;
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    _table.scrollEnabled=NO;
    [self.view addSubview:_table];
    [_table selectRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text=_array[indexPath.row];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.font=[UIFont systemFontOfSize:13.0f];
    cell.textLabel.textColor=[UIColor colorWithRed:0/255.0 green:193/255.0 blue:217/255.0 alpha:1.0];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor colorWithRed:37/255.0 green:201/255.0 blue:221/255.0 alpha:1.0];
    cell.textLabel.highlightedTextColor=[UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc;
    switch (indexPath.row) {
        case 0:
            if ([UIScreen mainScreen].bounds.size.height<500) {//iphone 4
                vc=[[PayViewController alloc]initWithNibName:@"PayViewController_iphone4" bundle:nil];
            }
            else
            {
                vc=[[PayViewController alloc]initWithNibName:@"PayViewController" bundle:nil];
            }
            break;
        case 1:
            vc=[[BillViewController alloc]init];
            break;
        case 2:
            vc=[[PasswordChangeViewController alloc]init];
            break;
        case 3:
            vc=[[AccountChangeViewController alloc]init];
            break;
        case 4:
            vc=[[LimitMoneyChangeViewController alloc]init];
            break;
        case 5:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
            return;
            break;
        case 6:
            [tableView deselectRowAtIndexPath:[tableView  indexPathForSelectedRow] animated:YES];
            [[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
            [_table selectRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
            return;
        default:
            break;
    }
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:NO
                                                                     andCompletion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
