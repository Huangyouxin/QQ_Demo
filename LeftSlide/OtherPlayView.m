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
#import "AFHTTPRequestOperation.h"
#import "AFNetworking.h"
#import "WeatherbaseModel.h"

#define WEATHERHTTP_GET  @"http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx/getWeather?theCityCode="
#define WEATHERHTTP_SOAP  @"http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx"
#define WEATHERHTTP_POST  @"http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx/getWeather"
//get http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx/getWeather?theCityCode=上海&theUserID=

@implementation OtherPlayView{
    NSString * currentCityname;
    NSString * currentCityid;
    NSMutableArray * array;
}

- (void) viewDidLoad{
    [super viewDidLoad];
    [self.view setFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height *2)];
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(reloadView:) name:@"reloadViewNotification" object:nil];
    currentCityname = @"";
    currentCityid = @"";
    
    self.navigationItem.title = @"天气预报";
    UIImageView * backImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImage.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:backImage];

    [self setViewNew];
    [self loadDataSDK_GET];
//    [self loadDatabyAFNetwork_SOAP];
//    [self loadDatabyAFNetwork_POST];
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
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2 -50, 130 , 100, 100)];
    label.textColor = [UIColor blackColor];
    [label setFont:[UIFont systemFontOfSize:25]];
    label.backgroundColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"21C";
    [self.view addSubview:label];
    
    UIImageView * iamgeWeather = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2 -100, 140 , 40, 40)];
    iamgeWeather.image = [UIImage imageNamed:@"0.gif"];
    [self.view addSubview:iamgeWeather];
    
    UILabel * wether11 = [[UILabel alloc]initWithFrame:CGRectMake(20 , 250 , 90, 20)];
    wether11.textColor = [UIColor whiteColor];
    [wether11 setFont:[UIFont systemFontOfSize:15]];
    wether11.text = @"风      力：";
    wether11.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:wether11];
    UILabel * wether111 = [[UILabel alloc]initWithFrame:CGRectMake(110 , 250 , 140, 20)];
    wether111.textColor = [UIColor blackColor];
    [wether111 setFont:[UIFont systemFontOfSize:15]];
    wether111.backgroundColor = [UIColor lightGrayColor];
    wether111.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:wether111];
    
    UILabel * wether22 = [[UILabel alloc]initWithFrame:CGRectMake(20 , 280 , 90, 20)];
    wether22.textColor = [UIColor whiteColor];
    [wether22 setFont:[UIFont systemFontOfSize:15]];
    wether22.text = @"湿      度：";
    wether22.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:wether22];
    
    UILabel * wether222 = [[UILabel alloc]initWithFrame:CGRectMake(110 , 280 , 140, 20)];
    wether222.textColor = [UIColor blackColor];
    [wether222 setFont:[UIFont systemFontOfSize:15]];
    wether222.backgroundColor = [UIColor lightGrayColor];
    wether222.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:wether222];
    
    UILabel * wether33 = [[UILabel alloc]initWithFrame:CGRectMake(20 , 310 , 90, 20)];
    wether33.textColor = [UIColor whiteColor];
    [wether33 setFont:[UIFont systemFontOfSize:15]];
    wether33.text = @"空气质量：";
    wether33.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:wether33];
    
    UILabel * wether333 = [[UILabel alloc]initWithFrame:CGRectMake(110 , 310 , 140, 20)];
    wether333.textColor = [UIColor blackColor];
    [wether333 setFont:[UIFont systemFontOfSize:15]];
    wether333.backgroundColor = [UIColor lightGrayColor];
    wether333.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:wether333];
    
    UILabel * wether44 = [[UILabel alloc]initWithFrame:CGRectMake(20 , 340 , 90, 20)];
    wether44.textColor = [UIColor whiteColor];
    [wether44 setFont:[UIFont systemFontOfSize:15]];
    wether44.text = @"紫外线强度：";
    wether44.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:wether44];
    
    UILabel * wether444 = [[UILabel alloc]initWithFrame:CGRectMake(110 , 340 , 140, 20)];
    wether444.textColor = [UIColor blackColor];
    [wether444 setFont:[UIFont systemFontOfSize:15]];
    wether444.backgroundColor = [UIColor lightGrayColor];
    wether444.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:wether444];

    for (int i = 0; i < 5; i++) {
        UIView * viewSub = [[UIView alloc]init];
        CGRect rect = CGRectMake(5 +i*((self.view.frame.size.width-30)/5 + 5) , 380, (self.view.frame.size.width-30)/5, 140);
        NSLog(@"的坐标%0.2f", (self.view.frame.size.width-60)/5);
        viewSub.backgroundColor = [UIColor clearColor];
        viewSub.frame = rect;
        
        [self.view addSubview:viewSub];
        //添加其他控件
        
//        日期
        UILabel * labelDate = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, rect.size.width, 20)];
        labelDate.text = @"9.23";
        labelDate.font = [UIFont systemFontOfSize:12.0f];
        labelDate.textAlignment = NSTextAlignmentCenter;
        labelDate.textColor = [UIColor whiteColor];
        [viewSub addSubview:labelDate];
        
//        天气图标
        UIImageView * amgeTP = [[UIImageView alloc]initWithFrame:CGRectMake((rect.size.width-20)/2, 35, 20, 20)];
        amgeTP.image = [UIImage imageNamed:[NSString stringWithFormat:@"2%d.gif",i]];
//        amgeTP.image = [UIImage imageNamed:@"30.gif"];
//        NSLog(@"20%d",[)

        [viewSub addSubview:amgeTP];
        
//        weather 
        UILabel * labelWeather = [[UILabel alloc]initWithFrame:CGRectMake(-3, 70, rect.size.width+10, 20)];
        labelWeather.text = @"小雨转中雨";
        labelWeather.font = [UIFont systemFontOfSize:12.0f];
        labelWeather.textAlignment = NSTextAlignmentCenter;
        labelWeather.textColor = [UIColor whiteColor];
        [viewSub addSubview:labelWeather];
        
//        temperature
        UILabel * labelTemperature = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, rect.size.width, 20)];
        labelTemperature.text = @"28、19";
        labelTemperature.font = [UIFont systemFontOfSize:12.0f];
        labelTemperature.textAlignment = NSTextAlignmentCenter;
        labelTemperature.textColor = [UIColor whiteColor];
        [viewSub addSubview:labelTemperature];
    }

}

#pragma mark 获取的数据分类处理
- (void) dataDispose:(NSArray *)array{
    WeatherbaseModel * weathermode = [[WeatherbaseModel alloc]init];
    NSMutableArray * pickaray = [[NSMutableArray alloc]init];
    weathermode.strDate = [array[3] substringWithRange:NSMakeRange(5, 5)];
    weathermode.strTemp = [array[4] substringWithRange:NSMakeRange(10, 3)];
    weathermode.strWind = [array[4] substringWithRange:NSMakeRange(20, 6)];
    weathermode.strHumid = [array[4] substringWithRange:NSMakeRange(30, 3)];
    weathermode.strAir = [array[5] substringWithRange:NSMakeRange(5, 2)];
    weathermode.strUVL = [array[5] substringWithRange:NSMakeRange(14, 1)];
    
    //其它数据
    weathermode.strsunExp = [array[6] substringFromIndex:7];
    weathermode.strdressExp = [array[7] substringFromIndex:6];
    weathermode.strtravelExp = [array[8] substringFromIndex:6];
    weathermode.strsportExp = [array[9] substringFromIndex:6];
    weathermode.strxiche = [array[10] substringFromIndex:6];
    weathermode.strhuazhuang = [array[11] substringFromIndex:6];
    weathermode.strclodExp = [array[12] substringFromIndex:6];
    weathermode.strAirpollutionExp = [array[13] substringFromIndex:8];
    weathermode.strComfortleveExp = [array[15] substringFromIndex:7];
    [pickaray addObject:weathermode];
    
    
}

#pragma mark NSURLConnection 异步网络访问

- (void) loadDataSDK_GET {
    
    NSString * str1 = currentCityname;
    NSString * str2 = currentCityid;
    NSString * urlStr = WEATHERHTTP_GET;
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

#pragma mark AFNetworking网络访问

/*
 * SOAP 方式
 */
- (void) loadDatabyAFNetwork_SOAP{
    
//    SOAP 1.2 格式
    NSString *soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     "<soap:Body>"
     "<getWeather xmlns=\"http://WebXml.com.cn/\">"
     "<theCityCode>%@</theCityCode>"
     "<theUserID>%@</theUserID>"
     "</getWeather>"
     "</soap:Body>"
     "</soap:Envelope>", currentCityname, currentCityid
     ];
    NSURL *url = [NSURL URLWithString:WEATHERHTTP_SOAP];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    [request addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSData * responseData = operation.responseData;
            NSString * responseStr = operation.responseString;
        NSLog(@"XMLSTRing: %@",responseStr);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"错误代码：%@",operation.responseString);
            NSLog(@"发生错误：%@",error);
        }];
    
    [operation start];
}

/*
 * POST 方式
 */

- (void) loadDatabyAFNetwork_POST{
    
//    __weak OtherPlayView *weakSelf = self;
//   NSString * BaseURLString = WEATHERHTTP_POST;
//   NSURL *baseURL = [NSURL URLWithString:BaseURLString];
 
//    NSDictionary *parameters = @{@"theCityCode":currentCityname,@"theUserID":@""};
//    AFHTTPSessionManager * sessionmanage = [[AFHTTPSessionManager alloc]init];
//    sessionmanage.responseSerializer =  [AFXMLParserResponseSerializer serializer];
//    sessionmanage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
//    [sessionmanage POST:BaseURLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSString* newStr =responseObject.res;
//        NSLog(@"data: %@",newStr);
//    }failure:^(NSURLSessionDataTask *task, NSError *error){
//        NSLog(@"error: %@",error);
//    }];
//    
    
//    [client POST:BaseURLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"XML: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//    [client postPath:@"weather.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString* newStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"POST请求:%@",newStr);
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
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
    [self  dataDispose:array];
    NSLog(@"%@",array);
}

@end
