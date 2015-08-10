//
//  RegisterViewController2.h
//  云收银
//
//  Created by 黄达能 on 15/7/28.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"
#import "SlideNavigationController.h"

@interface RegisterViewController2 : UIViewController

@property(nonatomic,strong)SlideNavigationController *slide;

@property(nonatomic,strong)MyTextField *bank;

@property(nonatomic,strong)MyTextField *name;

@property(nonatomic,strong)MyTextField *bankID;

@property(nonatomic,strong)MyTextField *phoneNum;

@end
