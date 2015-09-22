//
//  UIButton_extra.h
//  LeftSlide
//
//  Created by HYX on 15/9/14.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton_extra : UIButton

- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;

- (void) setLeftImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;
@end
