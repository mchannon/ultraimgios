//
//  DownloadViewController.h
//  ultraimg
//
//  Created by jrrr on 6/6/15.
//  Copyright (c) 2015 Matt Channon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *imageTextField;
@property (weak, nonatomic) IBOutlet UITableView *downloadTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *downloadSearchBar;

@end

