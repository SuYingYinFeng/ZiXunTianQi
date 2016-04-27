//
//  HCSCityResultViewController.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/4/26.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSCityResultViewController.h"

static NSString * const ID = @"cell";

@interface HCSCityResultViewController ()

@end

@implementation HCSCityResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"HCS";
    
    
    return cell;
}



@end
