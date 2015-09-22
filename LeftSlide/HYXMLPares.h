//
//  HYXMLPares.h
//  LeftSlide
//
//  Created by HYX on 15/9/22.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYXMLPares : NSObject <NSXMLParserDelegate>


//解析出得数据，内部是字典类型
@property (strong,nonatomic) NSMutableArray * noteDic ;

// 当前标签的名字 ,currentTagName 用于存储正在解析的元素名
@property (strong ,nonatomic) NSString * currentTagName ;

//开始解析
- (void) start ;

@end
