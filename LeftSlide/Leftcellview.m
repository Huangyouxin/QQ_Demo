//
//  Leftcellview.m
//  LeftSlide
//
//  Created by HYX on 15/9/17.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "Leftcellview.h"
#import "Model.h"
#import "MyTableViewCell.h"
#import "DetialView.h"

@implementation Leftcellview{
    NSMutableArray * aaaa;
    BOOL fristDid;
}


- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
                // Initialization code
    }
    return self;
}



- (id)initWithContentView:(UIView *)contentview{
    
    fristDid = NO;
    self = [super initWithFrame:CGRectMake(0, 0, contentview.frame.size.width, contentview.frame.size.height)];
    
    [contentview addSubview:self];
//    self.maskView  = contentview;
    _array = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i = 0; i < 3; i++) {
        NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:0];
        
        for (int j = 0; j < 3; j++)
        {
            Model*model=[[Model alloc]init];
            model.str1 =[NSString stringWithFormat:@"张三%d",i];
            model.str2 = [NSString stringWithFormat:@"aaaa%d",j];
            model.isExpand = NO;
            [arr addObject:model];
        }
        
        [_array addObject:arr];  //第三级菜单数组
    }
    
    //表数据源数组 == 第一级菜单数组
    _CurrentArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i = 0; i<_array.count; i++) {
        [_CurrentArray addObject:@[]];
    }
    
    //创建表
    _bigTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, contentview.frame.size.width *2/3, contentview.frame.size.height) style:UITableViewStyleGrouped];
    _bigTableView.delegate = self;
    _bigTableView.dataSource = self;
    [self addSubview:_bigTableView];
    
    aaaa = [NSMutableArray arrayWithObjects:@"第一 ", @"第二 ", @"第三",nil];

    return self;
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //节行数
    return _CurrentArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellIdentifier = @"Cell";
    
    MyTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    else
    {
        if (cell.model)
        {
            if (cell.model != [[_CurrentArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row])
            {
                
                cell.model = [[_CurrentArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                if (cell.model.isExpand==NO)
                {
                    cell.model=nil;
                }
            }
        }else
        {
            cell.model = [[_CurrentArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            if (cell.model.isExpand==NO) {
                cell.model=nil;
            }
        }
    }
    cell.indentationLevel = 1;

    [cell layoutSubviews];
    
    
    //    MyTableViewCell *cell = [[MyTableViewCell alloc]init];
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_CurrentArray objectAtIndex:section]count];
}

//点击单元格 展开、收缩 model信息
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell*cell=(MyTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    Model * model=[[_array objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    model.isExpand = !model.isExpand;
    
    if (cell.model) {
        cell.model=nil;
    }else
    {
        cell.model=model;
    }
    [cell layoutSubviews];
    [tableView reloadData];
}
//设置区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
//判断model是否被展示 来控制单元格高度
//可以在自定义view中 写+号方法计算 以下因没具体数据是省略写法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Model*model=[[_array objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    if (!model.isExpand)
    {
        return   44;
    }else
    {
        return  124;
    }
    
    
}
//自定义区头 把区头model 创建的view写这里
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 2/3 , 44)];
    view.backgroundColor = [UIColor lightTextColor];
    UILabel * Textlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 100 - 54, 44)];
    [view addSubview:Textlabel];
    Textlabel.textAlignment = NSTextAlignmentCenter;
    Textlabel.textColor = [UIColor blackColor];
//    Textlabel.backgroundColor = [UIColor grayColor];
    Textlabel.text = aaaa[section];
    
    UIButton*btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(kScreenWidth *2/3 - 50, 0, 44,44);
//    [btn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
//    [btn.imageView setImage:[UIImage imageNamed:@"arrow_right"]];
    [btn setBackgroundImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
    btn.tag = section;
    [btn addTarget:self action:@selector(expand:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    return view;
}

- (void)expand:(UIButton*)btn
{

    if([[_CurrentArray objectAtIndex:btn.tag] isEqualToArray:@[]]){
        
        [_CurrentArray replaceObjectAtIndex:btn.tag withObject:[_array objectAtIndex:btn.tag]];
        
    }else{
        
        [_CurrentArray replaceObjectAtIndex:btn.tag withObject:@[]];
        
    }
    [_bigTableView reloadData];
    
}

@end
