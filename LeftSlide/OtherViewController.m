//
//  otherViewController.m
//  LGDeckViewController
//
//  Created by huangzhenyu on 15/6/1.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "OtherViewController.h"
#import "AppDelegate.h"
#import "RightSlideCustomView.h"
@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"三折叠列表demo";
    [self setViewbuild];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setViewbuild{
    
    CGRect rect = CGRectMake(0, 0,
                             self.view.frame.size.width,
                             self.view.frame.size.height);
    NSLog(@"w:%f, h:%f", rect.size.width, rect.size.height);
    
    //左侧页面
    UIImageView *imageleft = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_png"]];
    imageleft.frame = rect;
    UIView * 
    [self.view addSubview:imageleft];
    
    //内容页面
    UIView *contentView = [[UIView alloc] initWithFrame:rect];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sub_png"]];
    imageView.frame = rect;
    [contentView addSubview:imageView];
    
    RightSlideCustomView *customView = [[RightSlideCustomView alloc]initWithView:contentView parentView:self.view];
    [[customView layer] setShadowOffset:CGSizeMake(10, 10)];
    [[customView layer] setShadowRadius:20];
    [[customView layer] setShadowOpacity:1];
    [[customView layer] setShadowColor:[UIColor blackColor].CGColor];
    [self.view addSubview:customView];
}


@end
