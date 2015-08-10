//
//  CameraViewController.m
//  云收银
//
//  Created by 黄达能 on 15/8/4.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()<ZBarReaderViewDelegate>
{
    NSTimer *_timer;
}
@property(nonatomic,strong)UIImageView *scanImage;

@property(nonatomic,strong)UIImageView *readLineView;

@end

@implementation CameraViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    _readerView=[[ZBarReaderView alloc]init];
    _readerView.backgroundColor=[UIColor clearColor];
    _readerView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _readerView.readerDelegate = self;
    //关闭闪光灯
    _readerView.torchMode = 0;
    
    UIImage *backImage=[UIImage imageNamed:@"pick_bg@2x.png"];
    _scanImage=[[UIImageView alloc]initWithImage:backImage];
    _scanImage.frame=CGRectMake((_readerView.frame.size.width-200)/2.0, (_readerView.frame.size.height-200)/2.0, 200, 200);
    
    //扫描区域
    CGRect scanMaskRect=[self getScanCrop:_scanImage.frame readerViewBounds:_readerView.bounds];
    _readerView.scanCrop=scanMaskRect;
    
    [self createUI];
    [_readerView addSubview:_scanImage];
    [self.view addSubview:_readerView];
    
    [_readerView start];
    
    _timer=[NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(loopDrawLine) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
}
-(void)createUI
{
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake(40, 40, 30, 30);
    [btn1 setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(self.view.frame.size.width-40-30, 40, 30, 30);
    [btn2 setImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(flash) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, 450, 100, 20)];
    label.font=[UIFont systemFontOfSize:12.0f];
    label.text=@"二维码或条形码";
    [_readerView addSubview:label];
    [_readerView addSubview:btn1];
    [_readerView addSubview:btn2];
}

//扫描区域计算
//这点比较重要，我们常用的二维码扫描软件的有效扫描区域一般都是中央区域，其他部分是不进行扫描的，ZBar可以通过ZBarReaderView的scanCrop属性设置扫描区域，它的默认值是CGRect(0,0, 1,1),表示整个ZBarReaderView区域都是有效的扫描区域。我们需要把扫描区域坐标计算为对应的百度分数坐标，也就是以上代码中调用的
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    return CGRectMake(x,y, width, height);
}
#pragma mark -delegate
-(void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    [_readerView stop];
    for(ZBarSymbol *sym in symbols)
    {
        NSString *str=sym.data;
        DXAlertView *view=[[DXAlertView alloc]initWithImage:@"right" withContentText:str withButtonTitle:@"确定"];
        view.rightBlock=^(){
            [_readerView start];
        };
        [view show];
        break;
    }
}
#pragma mark -扫描动画
-(void)loopDrawLine
{
    if(_readLineView)
    {
        [_readLineView removeFromSuperview];
    }
    CGRect rect=CGRectMake(_scanImage.frame.origin.x, _scanImage.frame.origin.y,_scanImage.frame.size.width, 3);
    _readLineView=[[UIImageView alloc]initWithFrame:rect];
    [_readLineView setImage:[UIImage imageNamed:@"line.png"]];
    [_readerView addSubview:_readLineView];
    [UIView animateWithDuration:5.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _readLineView.frame=CGRectMake(_scanImage.frame.origin.x, _scanImage.frame.origin.y+_scanImage.frame.size.height,_scanImage.frame.size.width, 3);
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)back
{
    [[SlideNavigationController sharedInstance] popViewControllerAnimated:YES];
    [_timer invalidate];
    _timer=nil;
}

- (void)flash {
    _readerView.torchMode=(_readerView.torchMode+1)%2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
