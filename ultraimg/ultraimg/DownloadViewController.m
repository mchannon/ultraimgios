//
//  DownloadViewController.m
//  ultraimg
//
//  Created by jrrr on 6/6/15.
//  Copyright (c) 2015 Matt Channon. All rights reserved.
//

#import "DownloadViewController.h"

@interface DownloadViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downloadTapped:(id)sender {
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 400, 40)];
    
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

@end
