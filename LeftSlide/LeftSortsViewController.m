//
//  LeftSortsViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AppDelegate.h"
#import "otherViewController.h"
#import "UIButton_extra.h"
@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation LeftSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];

    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.frame =CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width ,self.view.bounds.size.height);
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    
    UIScrollView *newview =[[UIScrollView alloc]init];
    self.testview = newview;
    newview.frame = self.view.bounds;
    newview.alwaysBounceVertical = YES;
    int i;
    //添加6个Button
    for(i =1; i<7;i++)
    {
        
        UIButton_extra * button = [UIButton_extra buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(-5, -25 +i*76,100,  80);
        
        if (i == 1) {
            
            [button setImage:[UIImage imageNamed:@"apply"] withTitle:@"扫一扫" forState:UIControlStateNormal];
            
        }else if (i == 2){
            
            [button setImage:[UIImage imageNamed:@"messing"] withTitle:@"群邮件" forState:UIControlStateNormal];
            
        }else if (i == 3){
            
            [button setImage:[UIImage imageNamed:@"moveing"] withTitle:@"建群组" forState:UIControlStateNormal];
            
        }else if (i == 4){
            
            [button setImage:[UIImage imageNamed:@"turemessing"] withTitle:@"群电话" forState:UIControlStateNormal];
            
        }else if (i == 5){
            
            [button setImage:[UIImage imageNamed:@"wrong"] withTitle:@"加好友" forState:UIControlStateNormal];
            
        }else if (i == 6){
            
            [button setImage:[UIImage imageNamed:@"munus"] withTitle:@"设置" forState:UIControlStateNormal];
        }
        
        [newview addSubview:button];
        
    }
    
    [self.view addSubview:newview];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        [cell.imageView setImage:[UIImage imageNamed:@"messing"]];
        cell.textLabel.text = @"开通会员";
    } else if (indexPath.row == 1) {
        [cell.imageView setImage:[UIImage imageNamed:@"apply"]];
        cell.textLabel.text = @"QQ钱包";
    } else if (indexPath.row == 2) {
        [cell.imageView setImage:[UIImage imageNamed:@"turemessing"]];
        cell.textLabel.text = @"网上营业厅";
    } else if (indexPath.row == 3) {
        [cell.imageView setImage:[UIImage imageNamed:@"moveing"]];
        cell.textLabel.text = @"个性装扮";
    } else if (indexPath.row == 4) {
        [cell.imageView setImage:[UIImage imageNamed:@"wrong"]];
        cell.textLabel.text = @"我的收藏";
    } else if (indexPath.row == 5) {
        [cell.imageView setImage:[UIImage imageNamed:@"apply"]];
        cell.textLabel.text = @"我的相册";
    } else if (indexPath.row == 6) {
        [cell.imageView setImage:[UIImage imageNamed:@"messing"]];
        cell.textLabel.text = @"我的文件";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    otherViewController *vc = [[otherViewController alloc] init];
    [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
    
    [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 120;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    UIImageView * imageppp = [[UIImageView alloc]init];
    imageppp.frame = CGRectMake(70, 2, 100, 90);
    [imageppp setImage:[UIImage imageNamed:@"Imagetou"]];
    UITextField * textfiled = [[UITextField alloc]init];
    textfiled.frame = CGRectMake(15, 98,self.tableview.bounds.size.width, 20);
    textfiled.placeholder = @"个人标签";
    textfiled.backgroundColor = [UIColor grayColor];
    textfiled.textColor = [UIColor whiteColor];
    [view addSubview:imageppp];
    [view addSubview:textfiled];
    return view;
}


#pragma mark ScrollView




@end
