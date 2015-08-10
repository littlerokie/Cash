//
//  LoginViewController.h
//  云收银
//
//  Created by 黄达能 on 15/7/27.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"
#import "SlideNavigationController.h"
@interface LoginViewController : UIViewController

@property(nonatomic,strong)MyTextField *email;

@property(nonatomic,strong)MyTextField *password;

@property(nonatomic,strong)SlideNavigationController *slide;

@end
