//
//  otherPlayView.m
//  LeftSlide
//
//  Created by HYX on 15/9/14.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "OtherPlayView.h"
#import "AppDelegate.h"
@implementation OtherPlayView

- (void) viewDidLoad{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor blueColor];
    self.navigationItem.title = @"娱乐列表";
     UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2 -50, self.view.bounds.size.height/2 -20 , 100, 40)];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"2";
    [self.view addSubview:label];
}
@end
