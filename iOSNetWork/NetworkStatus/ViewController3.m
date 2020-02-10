//
//  ViewController2.m
//  iOSNetWork
//
//  Created by qiyu on 2020/2/10.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "ViewController3.h"
@import Masonry;
@import AFNetworking;

@interface ViewController3 ()

@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Network Status";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20.0f];
    [titleLabel sizeToFit];
    [self.view addSubview:titleLabel];
    
    self.statusLabel = [[UILabel alloc] init];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.font = [UIFont systemFontOfSize:20.0f];
    [self.view addSubview:self.statusLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_centerY).mas_offset(-10);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(50);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerX.mas_equalTo(titleLabel.mas_centerX);
        make.top.mas_equalTo(self.view.mas_centerY).mas_offset(10);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(50);
    }];
    
    [self requestNetworkStatus];
}

/*
 AFNetworkReachabilityStatusUnknown          = -1,
 AFNetworkReachabilityStatusNotReachable     = 0,
 AFNetworkReachabilityStatusReachableViaWWAN = 1,
 AFNetworkReachabilityStatusReachableViaWiFi = 2,
 */
- (void)requestNetworkStatus {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                self.statusLabel.text = @"NotReachable ";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.statusLabel.text = @"ReachableViaWWAN";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.statusLabel.text = @"ReachableViaWiFi";
                break;
            default:
                self.statusLabel.text = @"Unknown";
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}


@end
