//
//  CameraViewController.m
//  云收银
//
//  Created by 黄达能 on 15/8/4.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface CameraViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    NSTimer *_timer;
}
@property(nonatomic,strong)UIImageView *scanImage;

@property(nonatomic,strong)UIImageView *readLineView;

@property (nonatomic) UIView *scanFrameView;

@property (nonatomic) AVCaptureSession *captureSession;

@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

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
    [_timer invalidate];
    _timer=nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startReading];
    [self createUI];
}
-(void)startReading
{
    // 获取 AVCaptureDevice 实例
    NSError * error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 初始化输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return ;
    }
    // 创建会话
    _captureSession = [[AVCaptureSession alloc] init];
    // 添加输入流
    [_captureSession addInput:input];
    // 初始化输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    // 添加输出流
    [_captureSession addOutput:captureMetadataOutput];
    // 创建dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("ScanQRCodeQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //设置扫描区域
    captureMetadataOutput.rectOfInterest=[self getScanCrop:CGRectMake((SCREENWIDTH-200)/2.0, (SCREENHEIGHT-200)/2.0, 200, 200) readerViewBounds:self.view.bounds];
    // 设置元数据类型 AVMetadataObjectTypeQRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code,nil]];
    
    // 创建输出对象
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:self.view.bounds];
    [self.view.layer addSublayer:_videoPreviewLayer];
    // 开始会话
    [_captureSession startRunning];
}
//计算扫描区域
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    return CGRectMake(x,y, width, height);
}
-(void)createUI
{
    UIImage *backImage=[UIImage imageNamed:@"pick_bg@2x.png"];
    _scanImage=[[UIImageView alloc]initWithImage:backImage];
    _scanImage.frame=CGRectMake((SCREENWIDTH-200)/2.0, (SCREENHEIGHT-200)/2.0, 200, 200);
    [self.view addSubview:_scanImage];
    //加阴影部分
    CGRect bottomViewRect=CGRectMake(0, 0, SCREENWIDTH, _scanImage.frame.origin.y);
    CGRect leftViewFrame=CGRectMake(0, _scanImage.frame.origin.y,(SCREENWIDTH-_scanImage.frame.size.width)/2, _scanImage.frame.size.height);
    CGRect rightViewRect=CGRectMake(SCREENWIDTH-(SCREENWIDTH-_scanImage.frame.size.width)/2, _scanImage.frame.origin.y, (SCREENWIDTH-_scanImage.frame.size.width)/2, _scanImage.frame.size.height);
    CGRect upviewFrame=CGRectMake(0, _scanImage.frame.size.height+_scanImage.frame.origin.y, SCREENWIDTH, SCREENHEIGHT-rightViewRect.origin.y);
    [self addViewWithFrame:bottomViewRect];
    [self addViewWithFrame:rightViewRect];
    [self addViewWithFrame:leftViewFrame];
    [self addViewWithFrame:upviewFrame];
    
    
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake(40, 40, 30, 30);
    [btn1 setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(self.view.frame.size.width-40-30, 40, 30, 30);
    [btn2 setImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(flash) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height-150, 100, 20)];
    label.font=[UIFont systemFontOfSize:12.0f];
    label.text=@"二维码或条形码";
    label.textColor=[UIColor whiteColor];
    [self.view addSubview:label];
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    
    _timer=[NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(loopDrawLine) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    
}
-(void)addViewWithFrame:(CGRect)frame
{
    UIView * greyView = [[UIView alloc] initWithFrame:frame];
    greyView.alpha = 0.3;
    greyView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:greyView];
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
    [self.view addSubview:_readLineView];
    [UIView animateWithDuration:5.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _readLineView.frame=CGRectMake(_scanImage.frame.origin.x, _scanImage.frame.origin.y+_scanImage.frame.size.height,_scanImage.frame.size.width, 3);
    } completion:^(BOOL finished) {
        
    }];
}
#pragma AVCaptureMetadataOutputObjectsDelegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
      fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        NSString *result;
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            result = metadataObj.stringValue;
        } else {
            result =metadataObj.stringValue;
        }
        [self performSelectorOnMainThread:@selector(reportScanResult:) withObject:result waitUntilDone:NO];
    }
}
- (void)reportScanResult:(NSString *)result
{
    [self stopReading];
    [_timer invalidate];
    _timer=nil;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"二维码扫描"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles: nil];
    [alert show];
}
- (void)stopReading
{
    // 停止会话
    [_captureSession stopRunning];
    _captureSession = nil;
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)flash
{
    static BOOL open =1;
    AVCaptureDevice *device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (open) {
            [device setTorchMode:AVCaptureTorchModeOn];
        }
        else{
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        [device unlockForConfiguration];
    }
    open=(open+1)%2;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
