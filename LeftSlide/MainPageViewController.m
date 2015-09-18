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

@interface MainPageViewController (){
    
    UITabBarController * tabbarView;
}

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //导航栏设置
    self.title = @"好友列表";
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    //主视图背景颜色
    self.view.backgroundColor = [UIColor whiteColor];

    //添加左侧
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    self.menuBtn = menuBtn;
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];

    //添加右侧
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(270, 0, 20, 18);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    self.rightBtn = rightBtn;
    [rightBtn addTarget:self action:@selector(openOrCloseRightList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    //标签栏按钮
    [self addtabbarlist];
}

- (void) openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
        [self setButtonHiddenYES];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
        [self setButtonHiddenNO];
    }
}

- (void) openOrCloseRightList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openRightView];
        [self setButtonHiddenYES];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeRightView];
        [self setButtonHiddenNO];
    }
}

- (void) setButtonHiddenYES{
    [UIView beginAnimations:nil context:nil];

    _rightBtn.hidden = YES;
    _menuBtn.hidden = YES;
    [UIView commitAnimations];
}

- (void) setButtonHiddenNO{
    [UIView beginAnimations:nil context:nil];

    _rightBtn.hidden = NO;
    _menuBtn.hidden = NO;
    [UIView commitAnimations];
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
    if (tempAppDelegate.LeftSlideVC.closed) {
        [self setButtonHiddenNO];
    }else{
        [self setButtonHiddenYES];
    }
}

- (void) addtabbarlist{
    
    tabbarView = [[UITabBarController alloc]init];
    tabbarView.delegate = self;
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


#pragma mark UITabbarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    NSLog(@"第二步");

    //点击tabbar改变导航栏标题
    NSLog(@"选择tabbar的Tag值：%d", viewController.tabBarItem.tag);
    
    int Select_tag = viewController.tabBarItem.tag;
    switch (Select_tag) {
        case 1001:
            self.title = @"好友列表";
            break;
        case 1002:
            self.title = @"娱乐列表";
            break;
        case 1003:
            self.title = @"更多列表";
            break;
        default:
            break;
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSLog(@"第一步");
    return YES;
}

@end
