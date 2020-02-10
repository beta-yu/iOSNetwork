//
//  ViewController2.m
//  iOSNetWork
//
//  Created by qiyu on 2020/2/6.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "ViewController2.h"
#import "Masonry.h"
#import "Weather.h"
#import "WeatherTableViewController.h"
@import AFNetworking;

@interface ViewController2 ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:sendButton];
    self.textField = [[UITextField alloc] init];
    [self.view addSubview:self.textField];
    
    [sendButton setTitle:@"查询" forState:UIControlStateNormal];
//    sendButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    sendButton.titleLabel.textColor = [UIColor blueColor];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [sendButton sizeToFit];
    //绘制圆角button
    sendButton.layer.masksToBounds = YES;
    sendButton.layer.cornerRadius = 4.0;
    sendButton.layer.borderWidth = 2.0;
    sendButton.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.textField.placeholder = @"请输入城市名称";
    self.textField.borderStyle = UITextBorderStyleRoundedRect; //有边框
    
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.trailingMargin.mas_equalTo(self.view.mas_trailingMargin).offset(-5);
        make.width.mas_equalTo(70);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.mas_equalTo(sendButton.mas_baseline);
        make.leadingMargin.mas_equalTo(self.view.mas_leadingMargin).offset(5);
        make.trailing.mas_equalTo(sendButton.mas_leading).offset(-5);
    }];
    
    [sendButton addTarget:self action:@selector(sendRequest1) forControlEvents:UIControlEventTouchUpInside];
}

//- (void)sendRequest {
//    NSString *urlString = [NSString stringWithFormat:@"http://apis.juhe.cn/simpleWeather/query?city=%@&key=7e60d70c81fe273ca7a8b21324701ed4", self.textField.text];
//
//    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]; //转码，URL中涉及汉字
//
//    NSURL *url = [NSURL URLWithString:urlString];
//
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//
//    NSURLSession *session = [NSURLSession sharedSession];
//
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//        if (error) {
//            NSLog(@"Status Code:%ld", httpResponse.statusCode);
//        } else {
//            NSLog(@"Status Code:%ld", httpResponse.statusCode);
//
//            //数据解析
//            Weather *weather = [[Weather alloc] init];
//            NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSDictionary *realtimeData = dict[@"result"][@"realtime"];
//            weather.temperature = realtimeData[@"temperature"];
//            weather.info = realtimeData[@"info"];
//            weather.direct = realtimeData[@"direct"];
//            weather.power = realtimeData[@"power"];
//            weather.api = realtimeData[@"api"];
////            NSLog(@"%@", dict[@"result"][@"realtime"]);
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//            });
//        }
//    }];
//
//    [task resume];
//}

- (void)sendRequest1 {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSString *urlString = [NSString stringWithFormat:@"http://apis.juhe.cn/simpleWeather/query?city=%@&key=7e60d70c81fe273ca7a8b21324701ed4", self.textField.text];

    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]; //转码，URL中涉及汉字

    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            //NSLog(@"%@ %@", response, responseObject);
            //responseObject为Json数据格式，无需转换
            
            NSDictionary *realtimeData = responseObject[@"result"][@"realtime"];
            NSLog(@"%@", realtimeData);
            Weather *weatherInfo = [[Weather alloc] init];
            weatherInfo.temperature = realtimeData[@"temperature"];
            weatherInfo.info = realtimeData[@"info"];
            weatherInfo.direct = realtimeData[@"direct"];
            weatherInfo.power = realtimeData[@"power"];
            weatherInfo.aqi = realtimeData[@"aqi"];
            
            //AFNetworking中该completionHandler会在主线程中执行，不需要切换线程了
            WeatherTableViewController *weatherVC = [[WeatherTableViewController alloc] init];
            weatherVC.weatherInfo = weatherInfo;
            [self.navigationController pushViewController:weatherVC animated:YES];
        }
    }];
    [dataTask resume];
}

@end
