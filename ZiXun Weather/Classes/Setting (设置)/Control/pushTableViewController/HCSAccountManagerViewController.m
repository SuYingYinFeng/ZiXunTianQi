//
//  HCSAccountManagerViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/6/11.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSAccountManagerViewController.h"

@interface HCSAccountManagerViewController ()

@end

@implementation HCSAccountManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.bounces = NO;
    
    self.tableView.tableFooterView = [UIButton buttonWithType:UIButtonTypeContactAdd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell_account";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"sdkvjc";
    
    return cell;
}



@end
