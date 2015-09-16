//
//  AppDelegate.m
//  LeftSlide
//
//  Created by huangzhenyu on 15/6/18.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "AppDelegate.h"
#import "MainPageViewController.h"
#import "LeftSortsViewController.h"
#import "OtherPlayView.h"
#import "FriendlistView.h"
#import "MessingView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];   //设置通用背景颜色
    [self.window makeKeyAndVisible];
    
    self.mainController = [[MainPageViewController alloc] init];
    
//   UINavigationController为最底层
//    self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];
//    LeftSortsViewController *leftVC = [[LeftSortsViewController alloc] init];
//    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
    
    UITabBarController * tabbarconTro = [[UITabBarController alloc]init];
    self.mainTabBarController = tabbarconTro;
    
    OtherPlayView * tabbar2 = [[OtherPlayView alloc]init];
    FriendlistView * tabbar1 = [[FriendlistView alloc]init];
    MessingView * tabbar3 = [[MessingView alloc]init];
    
    UINavigationController * nav1 = [[UINavigationController alloc]initWithRootViewController:tabbar1];
    UINavigationController * nav2 = [[UINavigationController alloc]initWithRootViewController:tabbar2];
    UINavigationController * nav3 = [[UINavigationController alloc]initWithRootViewController:tabbar3];
    
    UITabBarItem * item1 = [[UITabBarItem alloc]initWithTitle:@"好友列表" image:[UIImage imageNamed:@"info"] tag:1001];
    UITabBarItem * item2 = [[UITabBarItem alloc]initWithTitle:@"娱乐列表" image:[UIImage imageNamed:@"info"] tag:1002];
    UITabBarItem * item3 = [[UITabBarItem alloc]initWithTitle:@"更多功能" image:[UIImage imageNamed:@"info"] tag:1003];
    
    tabbar1.tabBarItem = item1;
    tabbar2.tabBarItem = item2;
    tabbar3.tabBarItem = item3;
    self.mainTabBarController.viewControllers  = @[nav1, nav2,nav3];
    
    LeftSortsViewController *leftVC = [[LeftSortsViewController alloc] init];
    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainTabBarController];
    self.window.rootViewController = self.LeftSlideVC;

//    [[UINavigationBar appearance] setBarTintColor:[UIColor purpleColor]];
    
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
