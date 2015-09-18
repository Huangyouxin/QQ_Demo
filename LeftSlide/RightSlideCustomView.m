//
//  RightSlideCustomView.m
//  LeftSlide
//
//  Created by HYX on 15/9/17.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeigh  [[UIScreen mainScreen] bounds].size.height

#import "RightSlideCustomView.h"

#define OPENCENTERX  kScreenWidth*2/3
#define DIVIDWIDTH 10.0 //OPENCENTERX 对应确认是否打开或关闭的分界线。

@implementation RightSlideCustomView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithView:(UIView *)contentview parentView:(UIView *)parentview
{
    self = [super initWithFrame:CGRectMake(0, 0, contentview.frame.size.width, contentview.frame.size.height)];
    
    if (self) {
        self.contenView = contentview;
        self.parentView = parentview;
        
        [self addSubview:contentview];
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handlePan:)];
        [self addGestureRecognizer:panGestureRecognizer];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handleTap:)];
        
        [self addGestureRecognizer:tapGestureRecognizer];
        
        openPointCenter = CGPointMake(self.parentView.center.x + OPENCENTERX,
                                      self.parentView.center.y);
        
        NSLog(@"openPointCenter x:%0.f,openPointCenter y:%0.f",openPointCenter.x,
              openPointCenter.y);
    }
    
    return self;
}

-(void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    CGPoint translation = [recognizer translationInView:self.parentView];
    
    float x = self.center.x + translation.x;
    NSLog(@"translation x:%f", translation.x);
    
    if (x < self.parentView.center.x) {
        x = self.parentView.center.x;
    }
    self.center = CGPointMake(x, openPointCenter.y);
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        [UIView beginAnimations:nil context:nil];

//        [UIView animateWithDuration:0.75
//                              delay:0.01
//                            options:UIViewAnimationOptionCurveEaseInOut
//                         animations:^(void)
//            {
                if (x > openPointCenter.x -  DIVIDWIDTH) {
                    self.center = openPointCenter;
                }else{
                    self.center = CGPointMake(openPointCenter.x - OPENCENTERX,
                                           openPointCenter.y);
                }
//            }completion:^(BOOL isFinish){
//         }];
        [UIView commitAnimations];
    }
    [recognizer setTranslation:CGPointZero inView:self.parentView];
}

-(void) handleTap:(UITapGestureRecognizer*) recognizer
{
    //动画改变
    [UIView beginAnimations:nil context:nil];

//    [UIView animateWithDuration:0.75
//                          delay:0.01
//                        options:UIViewAnimationOptionCurveEaseOut animations:^(void){
                            self.center = CGPointMake(openPointCenter.x - OPENCENTERX,
                                                      openPointCenter.y);
//                        }completion:nil];
    [UIView commitAnimations];

    
}

@end
