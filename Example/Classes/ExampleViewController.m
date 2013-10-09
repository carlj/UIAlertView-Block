//
//  ViewController.m
//  UIAlertView+Block
//
//  Created by Carl Jahn on 09.10.13.
//  Copyright (c) 2013 Carl Jahn. All rights reserved.
//

#import "ExampleViewController.h"
#import "UIAlertView+Block.h"
@interface ExampleViewController ()

@end

@implementation ExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear: animated];
  
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Hello"
                                                      message: @"Lorem ipsum"
                                                     delegate: nil
                                            cancelButtonTitle: @"Cancle"
                                            otherButtonTitles: @"Other 1", @"Other 2", nil];
  
  alertView.clickedButtonBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
    NSLog(@"%s button clicked at index: %ld", __FUNCTION__, (long)buttonIndex);
  };
  
  [alertView show];

}


@end
