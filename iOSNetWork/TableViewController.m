//
//  TableViewController.m
//  iOSNetWork
//
//  Created by qiyu on 2020/2/6.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"

@interface TableViewController ()

@property (nonatomic, strong) NSArray *cellTitles;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.cellTitles = @[@"SimpleNetworkRequest", @"WeatherForecast", @"GetNetworkStatus", @"SDWebImageLoadTransition"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellTitles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    cell.textLabel.text = self.cellTitles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            ViewController1 *VC1 = [[ViewController1 alloc] init];
            [self.navigationController pushViewController:VC1 animated:YES];
            break;
        }
        case 1: {
            ViewController2 *VC2 = [[ViewController2 alloc] init];
            [self.navigationController pushViewController:VC2 animated:YES];
            break;
        }
        case 2: {
            ViewController3 *VC3 = [[ViewController3 alloc] init];
            [self.navigationController pushViewController:VC3 animated:YES];
            break;
        }
        case 3: {
            ViewController4 *VC4 = [[ViewController4 alloc] init];
            [self.navigationController pushViewController:VC4 animated:YES];
            break;
        }
        default:
            break;
    }
}





@end
