//
//  BillDetailViewController.m
//  云收银
//
//  Created by 黄达能 on 15/8/1.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import "BillDetailViewController.h"
#import "DetailTableViewCell1.h"
#import "DetailTableViewCell2.h"
#import "DetailTableViewCell3.h"


@interface BillDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *table;

@end

@implementation BillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"账单详情";
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 12, 15);
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    [self createTableView];
}
-(void)back
{
    //  [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];//上一个视图
}


-(void)createTableView
{
    _table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _table.delegate=self;
    _table.dataSource=self;
    _table.scrollEnabled=NO;
    [self.view addSubview:_table];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return 60*SCREENHEIGHT/568;
    }
    if(indexPath.row==1)
    {
        return 100*SCREENHEIGHT/568;
    }
    else
        return SCREENHEIGHT-60*SCREENHEIGHT/568-100*SCREENHEIGHT/568-64;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    if(indexPath.row==0)
    {
        DetailTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"DetailTableViewCell1" owner:self options:nil]lastObject];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    if(indexPath.row==1)
    {
        DetailTableViewCell2 *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"DetailTableViewCell2" owner:self options:nil]lastObject];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    if(indexPath.row==2)
    {
        DetailTableViewCell3 *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"DetailTableViewCell3" owner:self options:nil]lastObject];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
