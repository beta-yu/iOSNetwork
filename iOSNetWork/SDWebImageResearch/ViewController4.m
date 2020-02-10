//
//  ViewController4.m
//  iOSNetWork
//
//  Created by qiyu on 2020/2/10.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "ViewController4.h"
@import SDWebImage;
@import Masonry;

@interface ViewController4 ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
    
    UIButton *loadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [loadButton setTitle:@"LoadImage" forState:UIControlStateNormal];
    loadButton.titleLabel.textColor = [UIColor blueColor];
    loadButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [loadButton sizeToFit];
    //绘制圆角button
    loadButton.layer.masksToBounds = YES;
    loadButton.layer.cornerRadius = 7.0;
    loadButton.layer.borderWidth = 2.0;
    loadButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:loadButton];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_centerY).mas_offset(-10);
        make.height.mas_equalTo(200);
        make.width.mas_lessThanOrEqualTo(self.view.mas_width);
    }];
    
    [loadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(90);
    }];
    
    [loadButton addTarget:self action:@selector(loadImage) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadImage {
    self.imageView.sd_imageTransition = SDWebImageTransition.flipFromLeftTransition; // transition animation
    NSURL *url = [NSURL URLWithString:@"https://goss4.cfp.cn/creative/vcg/800/new/VCG41N1193381031.jpg?x-oss-process=image/format,jpg/interlace,1"];
    //有缓存
    [self.imageView sd_setImageWithURL:url];
}

@end
