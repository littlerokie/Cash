//
//  BillViewController.m
//  云收银
//
//  Created by 黄达能 on 15/7/28.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import "BillViewController.h"
#import "BillTableViewCell.h"
#import "BillDetailViewController.h"


@interface BillViewController ()<UITableViewDataSource,UITableViewDelegate,SlideNavigationControllerDelegate,MJRefreshBaseViewDelegate,SlideDeleteCellDelegate>

@property(nonatomic,strong)UITableView *table;

@property(nonatomic,strong)ODRefreshControl *refresh;

@property(nonatomic,strong)MJRefreshFooterView *footer;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation BillViewController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //_header.scrollView=nil;
}
#pragma mark -SlideNavigationDelegate
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.title=@"我的账单";
    _dataArray = [[NSMutableArray alloc] initWithArray:@[@"Cell1",@"Cell2",@"Cell3",@"Cell4",@"Cell5",@"Cell6",@"Cell7",@"Cell8"]];
    [self createNav];
    [self createSegement];
    [self createTableView];
}
#pragma mark -refresh
-(void)setUpRefresh
{
    _footer=[MJRefreshFooterView footer];
    _footer.delegate=self;
    _footer.scrollView=_table;
    _refresh=[[ODRefreshControl alloc]initInScrollView:_table];
    [_refresh addTarget:self action:@selector(refreshViewBeginRefreshing) forControlEvents:UIControlEventValueChanged];
}
-(void)refreshViewBeginRefreshing
{
    [self performSelector:@selector(loadData) withObject:self afterDelay:2];
}
-(void)loadData
{
    [_refresh endRefreshing];
}
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [_footer endRefreshing];
}


-(void)createSegement
{
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 94)];
    image.backgroundColor=[UIColor colorWithRed:30/255.0 green:194/255.0 blue:213/255.0 alpha:1];
    
    NSArray *array=[NSArray arrayWithObjects:@"全部交易",@"交易成功",@"交易失败", nil];
    UISegmentedControl *segmented=[[UISegmentedControl alloc]initWithItems:array];
    segmented.frame=CGRectMake((self.view.frame.size.width-200)/2, 64, 200, 25);
    segmented.tintColor=[UIColor whiteColor];//选中颜色为白色
    segmented.selectedSegmentIndex=0;
    [segmented addTarget:self action:@selector(segmentedControl:) forControlEvents:UIControlEventValueChanged];
    
    //设置各种状态的字体和颜色
    [segmented setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0f],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    image.userInteractionEnabled=YES;
    [image addSubview:segmented];
    [self.view addSubview:image];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0,94, image.frame.size.width, 15)];
    label.text=@"2015年 05月 交易笔数16 交易总金额：6699.6 退款1笔(1.99元)";
    label.font=[UIFont systemFontOfSize:9.0f];
    label.textAlignment=NSTextAlignmentCenter;
    label.backgroundColor=[UIColor colorWithRed:220/255.0 green:221/255.0 blue:222/255.0 alpha:1];
    [self.view addSubview:label];
}
#pragma mark- 导航栏
-(void)createNav
{
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0/255.0 green:193/255.0 blue:215/255.0 alpha:1.0];
    //导航栏title的字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    for (UIView *subView in self.navigationController.navigationBar.subviews) {
        
        if ([subView isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            for (UIView *sView in subView.subviews) {
                if ([sView isKindOfClass:[UIImageView class]]) {
                    [sView removeFromSuperview];
                }
            }
        }
    }
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 20, 20);
    [btn setImage:[UIImage imageNamed:@"broadside"] forState:UIControlStateNormal];
    [btn addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=left;
    [SlideNavigationController sharedInstance].leftBarButtonItem=left;
    
}

-(void)segmentedControl:(id)sender
{
    switch ([sender selectedSegmentIndex]) {
        case 0:
            NSLog(@"0");
            break;
        case 1:
            NSLog(@"1");
            break;
        case 2:
            NSLog(@"2");
            break;
            
        default:
            break;
    }
}
#pragma mark - tableView
-(void)createTableView
{
    _table=[[UITableView alloc]initWithFrame:CGRectMake(0, 109, self.view.frame.size.width, self.view.frame.size.height-109) style:UITableViewStylePlain];
    _table.delegate=self;
    _table.dataSource=self;
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    _table.backgroundColor=[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    [self.view addSubview:_table];
    [self setUpRefresh];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    BillTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell==nil)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"BillTableViewCell" owner:self
                                        options:nil]lastObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.delegate=self;
    cell.viewController=self;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BillDetailViewController *detail=[[BillDetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}
-(void)slideToDeleteCell:(SlideDeleteCell *)slideDeleteCell
{
    NSIndexPath *indexPath=[_table indexPathForCell:slideDeleteCell];
    [_dataArray removeObjectAtIndex:indexPath.row];
    [_table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
@end
