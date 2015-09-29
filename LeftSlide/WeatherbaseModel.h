//
//  WeatherbaseModel.h
//  LeftSlide
//
//  Created by HYX on 15/9/28.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherbaseModel : NSObject

//天气的基本信息

@property(copy,nonatomic)NSString *strDate;
@property(copy,nonatomic)NSString *strTemp;
@property(copy,nonatomic)NSString *strWind;
@property(copy,nonatomic)NSString *strHumid;
@property(copy,nonatomic)NSString *strAir;
@property(copy,nonatomic)NSString *strUVL;


@property (copy, nonatomic) NSString * strsunExp;
@property (copy, nonatomic) NSString * strdressExp;
@property (copy, nonatomic) NSString * strtravelExp;
@property (copy, nonatomic) NSString * strsportExp;
@property (copy, nonatomic) NSString * strhuazhuang;
@property (copy, nonatomic) NSString * strxiche;
@property (copy, nonatomic) NSString * strclodExp;
@property (copy, nonatomic) NSString * strAirpollutionExp;
@property (copy, nonatomic) NSString * strComfortleveExp;

@end
