//
//  CameraViewController.h
//  云收银
//
//  Created by 黄达能 on 15/8/4.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
@interface CameraViewController : UIViewController

@property(nonatomic,strong) ZBarReaderView *readerView;

@end