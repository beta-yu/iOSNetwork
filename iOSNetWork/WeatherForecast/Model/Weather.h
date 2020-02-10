//
//  Weather.h
//  iOSNetWork
//
//  Created by qiyu on 2020/2/6.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Weather : NSObject <NSCopying>

@property (nonatomic, copy) NSString *temperature;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *direct;
@property (nonatomic, copy) NSString *power;
@property (nonatomic, copy) NSString *aqi;
@property (nonatomic, copy) NSArray *titleNames;

@end

NS_ASSUME_NONNULL_END
