//
//  MainPageViewController.m
//  LeftSlide
//
//  Created by huangzhenyu on 15/6/18.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "MainPageViewController.h"
#import "AppDelegate.h"
#import "OtherPlayView.h"
#import "MessingView.h"
#import "FriendlistView.h"
#define vBackBarButtonItemName  @"backArrow.png"    //导航条返回默认图片名
@interface MainPageViewController (){
    UITabBarController * tabbarView;
}

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];

    //添加右侧
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(270, 0, 20, 18);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(openOrCloseRightList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    [self addtabbarlist];
}

- (void) openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

- (void) openOrCloseRightList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openRightView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeRightView];
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}

- (void) addtabbarlist{
    tabbarView = [[UITabBarController alloc]init];
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
    tabbarView.viewControllers  = @[nav1, nav2,nav3];
    tabbarView.view.frame = self.view.bounds;
    [self.view addSubview:tabbarView.view];
}


@end
