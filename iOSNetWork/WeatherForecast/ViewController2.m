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

@interface ViewController2 () <UITableViewDataSource>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITableView *tableView;

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
//    sendButton.contentEdgeInsets = UIEdgeInsetsZero;
    sendButton.titleLabel.textColor = [UIColor blueColor];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [sendButton sizeToFit];
    
    self.textField.placeholder = @"请输入城市名称";
    self.textField.borderStyle = UITextBorderStyleRoundedRect; //有边框
    
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.leading.mas_equalTo(self.view.mas_leading);
        make.trailing.mas_equalTo(self.view.mas_trailing);
        make.bottom.mas_equalTo(self.view.mas_centerY);
    }];
    
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom).offset(10);
        make.trailingMargin.mas_equalTo(self.view.mas_trailingMargin).offset(-5);
        make.width.mas_equalTo(92);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.mas_equalTo(sendButton.mas_baseline);
        make.leadingMargin.mas_equalTo(self.view.mas_leadingMargin).offset(5);
        make.trailing.mas_equalTo(sendButton.mas_leading).offset(-5);
    }];
    
    [sendButton addTarget:self action:@selector(sendRequest) forControlEvents:UIControlEventTouchUpInside];
}

- (void)sendRequest {
    NSString *urlString = [NSString stringWithFormat:@"http://apis.juhe.cn/simpleWeather/query?city=%@&key=7e60d70c81fe273ca7a8b21324701ed4", self.textField.text];

    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]; //转码，URL中涉及汉字

    NSURL *url = [NSURL URLWithString:urlString];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (error) {
            NSLog(@"Status Code:%ld", httpResponse.statusCode);
        } else {
            NSLog(@"Status Code:%ld", httpResponse.statusCode);
            
            //数据解析
            Weather *weather = [[Weather alloc] init];
            NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *realtimeData = dict[@"result"][@"realtime"];
            weather.temperature = realtimeData[@"temperature"];
            weather.info = realtimeData[@"info"];
            weather.direct = realtimeData[@"direct"];
            weather.power = realtimeData[@"power"];
//            NSLog(@"%@", dict[@"result"][@"realtime"]);
            dispatch_async(dispatch_get_main_queue(), ^{

            });
        }
    }];

    [task resume];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
