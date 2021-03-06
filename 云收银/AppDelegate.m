//
//  AppDelegate.m
//  云收银
//
//  Created by 黄达能 on 15/7/27.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "BillViewController.h"
#import "LeftMenuViewController.h"
#import "SlideNavigationController.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
#if 1
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"User.plist"];
    NSLog(@"%@",filename);
    NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]initWithContentsOfFile:filename];
//    NSLog(@"app %@",dictionary);
#endif
    BillViewController *bill=[[BillViewController alloc]init];
    
    LoginViewController *login=[[LoginViewController alloc]init];
    SlideNavigationController *slide=[[SlideNavigationController alloc]initWithRootViewController:login];
    slide.portraitSlideOffset=self.window.frame.size.width-100;//移动的距离设置
    [SlideNavigationController sharedInstance].menuRevealAnimator = [[SlideNavigationContorllerAnimatorScaleAndFade alloc] initWithMaximumFadeAlpha:.6 fadeColor:[UIColor blackColor] andMinimumScale:.8];//移动的动画
    LeftMenuViewController *left=[[LeftMenuViewController alloc]init];
    [SlideNavigationController sharedInstance].leftMenu=left;
    
    if([[dictionary objectForKey:@"auto"] boolValue])//自动登入
    {
        [[SlideNavigationController sharedInstance] pushViewController:bill animated:NO];
    }
    [self.window setRootViewController:slide];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
