//
//  Leftcellview.h
//  LeftSlide
//
//  Created by HYX on 15/9/17.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeigh  [[UIScreen mainScreen] bounds].size.height

#import <UIKit/UIKit.h>

@interface Leftcellview : UIView<UITableViewDelegate,UITableViewDataSource>{
    
    UIView * main;
    //表
    UITableView * _bigTableView;
    
    //所有数据的数组
    NSMutableArray * _array; //第三级菜单数组
    
    //表的数据源数组
    NSMutableArray * _CurrentArray;
}

- (id)initWithContentView:(UIView *)contentview;

@end
