//
//  otherPlayView.m
//  LeftSlide
//
//  Created by HYX on 15/9/14.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "OtherPlayView.h"
#import "AppDelegate.h"
#import "UIButton_extra.h"
#import "HYXMLPares.h"

#define WEATHERHTTP  @"http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx/getWeather?theCityCode="
// http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx/getWeather?theCityCode=上海&theUserID=

@implementation OtherPlayView{
    NSString * currentCityname;
    NSString * currentCityid;
    NSMutableArray * array;
}

- (void) viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(reloadView:) name:@"reloadViewNotification" object:nil];
    currentCityname = @"";
    currentCityid = @"";
    
    self.navigationItem.title = @"天气预报";
    UIImageView * backImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImage.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:backImage];

    [self setViewNew];
    [self loadData];
    
}

- (void) setpostValue:(NSString *)cityName id:(NSString *)cityId{
    currentCityname  = cityName;
    currentCityid = cityId;
}

- (void) setViewNew{
    UIButton_extra * cityBtn = [UIButton_extra buttonWithType:UIButtonTypeCustom];
    CGRect rect = CGRectMake(self.view.bounds.size.width/2 -70, 70, 100, 40);
    cityBtn.frame = rect;
    [cityBtn setLeftImage:[UIImage imageNamed:@"addcity"] withTitle:@"上海" forState:UIControlStateNormal];
    [cityBtn addTarget:self action:@selector(addcityAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cityBtn];
    currentCityid = @"";
    currentCityname = @"上海";
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2 -50, 150 , 100, 100)];
    label.textColor = [UIColor blackColor];
    [label setFont:[UIFont systemFontOfSize:25]];
    label.backgroundColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"温度值";
    [self.view addSubview:label];
    
    UIImageView * iamgeWeather = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2 -75, 270 , 40, 40)];
    iamgeWeather.image = [UIImage imageNamed:@"0.gif"];
    [self.view addSubview:iamgeWeather];
    
    
}

// NSURLConnection 异步
- (void) loadData{
    
    NSString * str1 = currentCityname;
//    NSString * appStr = @"&theUserID=";
    NSString * str2 = currentCityid;
    NSString * urlStr = WEATHERHTTP;
//    urlStr = [urlStr stringByAppendingString:str1];
//    urlStr = [urlStr stringByAppendingString:@"&theUserID="];
//    urlStr = [urlStr stringByAppendingString:str2];
    urlStr = [urlStr stringByAppendingFormat:@"%@&theUserID=%@",str1,str2];
    NSString* URL = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:URL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0f]; //maximal timeout is 30s
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(
                       NSURLResponse *response,
                                  NSData *data,
                      NSError *connectionError
      ){
        if ([data length] > 0 && connectionError == nil) {
            NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *filePath = [documentsDir stringByAppendingPathComponent:@"apple.html"];
            [data writeToFile:filePath atomically:YES];
            NSLog(@"Successfully saved the file to %@",filePath);
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"HTML = %@",html);
        }else if ([data length] == 0 && connectionError == nil){
            NSLog(@"Nothing was downloaded.");
        }else if (connectionError != nil){
            NSLog(@"Error happened = %@",connectionError);
        }
    }];
}

- (void) addcityAction:(id) sender{
    NSLog(@"添加城市。。。");
//    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(reloadView:) name:@"reloadViewNotification" object:nil];
    //TBXMLParser 解析
    HYXMLPares * xmlPares = [HYXMLPares new];
    [xmlPares start];
}


//解析完传回数据
- (void) reloadView:(NSNotification *)notification{
    NSLog(@"数据传输。。。");
    NSMutableArray * listArray = [notification object];
    array = listArray;
    NSLog(@"%@",array);
}

@end
