//
//  UIButton_extra.m
//  LeftSlide
//
//  Created by HYX on 15/9/14.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "UIButton_extra.h"

@implementation UIButton_extra

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType{

    UIFont *font = [UIFont systemFontOfSize:12.0f];
    CGSize titlesize = [title sizeWithFont:font];
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-10.0,0.0,0.0,-titlesize.width)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:font];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(52.0,-image.size.width,0.0,0.0)];
    [self setTitle:title forState:stateType];
}

@end
