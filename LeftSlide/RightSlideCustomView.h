//
//  RightSlideCustomView.h
//  LeftSlide
//
//  Created by HYX on 15/9/17.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightSlideCustomView : UIView{
    CGPoint openPointCenter;
    CGPoint closePointCenter;
}

-(id)initWithView:(UIView*)contentview parentView:(UIView*) parentview;

@property (nonatomic, strong) UIView *parentView; //抽屉视图的父视图
@property (nonatomic, strong) UIView *contenView; //抽屉显示内容的视图

@end
