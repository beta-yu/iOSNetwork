//
//  ViewController1.m
//  iOSNetWork
//
//  Created by qiyu on 2020/2/6.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "ViewController1.h"
#import "Masonry.h"

@interface ViewController1 ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:sendButton];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(150);
        make.leadingMargin.greaterThanOrEqualTo(self.view.mas_leading);
        make.trailingMargin.lessThanOrEqualTo(self.view.mas_trailing);
        make.bottom.equalTo(sendButton.mas_top).offset(-50);
        make.height.mas_equalTo(200);
        make.width.mas_greaterThanOrEqualTo(300);
    }];
    
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottomMargin.lessThanOrEqualTo(self.view.mas_bottom);
        make.width.mas_lessThanOrEqualTo(self.view.frame.size.width);
    }];
    
    [sendButton setTitle:@"Send requset" forState:UIControlStateNormal];
    [sendButton sizeToFit];
    sendButton.titleLabel.textColor = [UIColor blueColor];
    [sendButton addTarget:self action:@selector(sendRequest) forControlEvents:UIControlEventTouchUpInside];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)sendRequest {
    NSURL *imageUrl = [NSURL URLWithString:@"https://goss2.cfp.cn/creative/vcg/800/new/VCG211d56cb6c4-MLH.jpg?x-oss-process=image/format,jpg/interlace,1"];
    //若URL为http，默认会被App Transport Security拦截, 可通过简单配置解决https://www.cnblogs.com/huaixu/p/7890425.html
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:imageUrl];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSLog(@"status code:%ld", httpResponse.statusCode);
        } else {
            //默认网络请求在子线程中执行，需要在主线程更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = [UIImage imageWithData:data];
//                [self.imageView sizeToFit];
            });
        }
    }];
    [task resume];
}

@end
