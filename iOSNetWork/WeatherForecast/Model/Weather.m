//
//  Weather.m
//  iOSNetWork
//
//  Created by qiyu on 2020/2/6.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "Weather.h"

@implementation Weather 

- (instancetype)init {
    self.titleNames = @[@"天气：", @"温度：", @"风力：", @"风向：", @"空气质量指数："];
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    Weather *weather = [[Weather alloc] init];
    weather.info = self.info;
    weather.temperature = self.temperature;
    weather.direct = self.direct;
    weather.power = self.power;
    weather.aqi = self.aqi;
    return weather;
}

@end
