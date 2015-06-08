//
//  UploadViewController.h
//  ultraimg
//
//  Created by jrrr on 6/6/15.
//  Copyright (c) 2015 Matt Channon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (weak, nonatomic) IBOutlet UITableView *uploadTableView;

@end

