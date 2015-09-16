//
//  FriendlistView.m
//  LeftSlide
//
//  Created by HYX on 15/9/14.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "FriendlistView.h"
#import "AppDelegate.h"

@implementation FriendlistView

- (void) viewDidLoad{
     [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"好友列表";
    
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    UIButton *menuBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn2.frame = CGRectMake(270, 0, 20, 18);
    [menuBtn2 setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn2 addTarget:self action:@selector(openOrCloseRightList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn2];

}

- (void)openOrCloseLeftList{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.mainController openOrCloseLeftList];
}

- (void)openOrCloseRightList{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.mainController openOrCloseRightList];
}

@end
