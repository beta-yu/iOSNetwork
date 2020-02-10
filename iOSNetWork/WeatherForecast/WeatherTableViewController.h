//
//  WeatherTableViewController.h
//  iOSNetWork
//
//  Created by qiyu on 2020/2/10.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherTableViewController : UITableViewController

@property (nonatomic, copy) Weather *weatherInfo;

@end

NS_ASSUME_NONNULL_END
