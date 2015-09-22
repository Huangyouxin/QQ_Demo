//
//  HYXMLPares.m
//  LeftSlide
//
//  Created by HYX on 15/9/22.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "HYXMLPares.h"

@implementation HYXMLPares


// 开始解析
-(void)start{
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsDir stringByAppendingPathComponent:@"apple.html"];
//    NSData * data1 = [NSData dataWithContentsOfFile:filePath];
    NSURL * url = [NSURL fileURLWithPath:filePath];
//    NSString *html1 = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
//    NSLog(@"HTML1 = %@",html1);
    //开始解析 xml
    NSXMLParser * parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    parser.delegate = self ;
    
    [parser parse];
    
    NSLog(@"解析搞定...");
    
}
//文档开始时触发 ,开始解析时 只触发一次
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    _noteDic = [NSMutableArray new];
}

// 文档出错时触发
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@",parseError);
}

//遇到一个开始标签触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    //把elementName 赋值给 成员变量 currentTagName
    _currentTagName  = elementName ;
    
    //如果名字 是Note就取出 id
    if ([_currentTagName isEqualToString:@"ArrayOfString"]) {
        
    }
    
}
#pragma mark 该方法主要是解析元素文本的主要场所，由于换行符和回车符等特殊字符也会触发该方法，因此要判断并剔除换行符和回车符
// 遇到字符串时 触发
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    //替换回车符 和空格,其中 stringByTrimmingCharactersInSet 是剔除字符的方法,[NSCharacterSet whitespaceAndNewlineCharacterSet]指定字符集为换行符和回车符;
    
    string  = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string isEqualToString:@""]) {
        return;
    }
    
    if ([_currentTagName isEqualToString:@"string"]) {
        [_noteDic addObject:string];
    }
    
}

//遇到结束标签触发
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    self.currentTagName = nil ;
    //该方法主要是用来 清理刚刚解析完成的元素产生的影响，以便于不影响接下来解析
}

// 遇到文档结束时触发
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.noteDic userInfo:nil];
    //进入该方法就意味着解析完成，需要清理一些成员变量，同时要将数据返回给表示层（表示图控制器） 通过广播机制将数据通过广播通知投送到 表示层
    self.noteDic = nil;
}

@end
