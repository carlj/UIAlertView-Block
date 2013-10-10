//
//  UIAlertView_BlockTests.m
//  UIAlertView+BlockTests
//
//  Created by Carl Jahn on 09.10.13.
//  Copyright (c) 2013 Carl Jahn. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIAlertView+Block.h"
@interface UIAlertView_BlockTests : XCTestCase

@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, strong, readonly) UIAlertView *defaultAlertView;

@end

@implementation UIAlertView_BlockTests

- (void)setUp {
  [super setUp];
  
  self.semaphore = dispatch_semaphore_create(0);
}

- (void)waitForAnimationFinished {
  
  double delayInSeconds = 1.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){

    dispatch_semaphore_signal(self.semaphore);
  });

  dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
}

- (UIAlertView *)generateDefaultAlertViewForTests {
  
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Hello"
                                                      message: @"Lorem ipsum"
                                                     delegate: self
                                            cancelButtonTitle: @"Cancle"
                                            otherButtonTitles: @"Other 1", @"Other 2", nil];

  return alertView;
}

- (void)testIfTheDelegateIsCorrect {

  UIAlertView *alertView = [self generateDefaultAlertViewForTests];
  alertView.clickedButtonBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
  };
  
  _XCTPrimitiveAssertEqualObjects(alertView, alertView.delegate, @"Delegate arent the same");
}

- (void)testIfClickBlockGetsCalled {
  
  UIAlertView *alertView = [self generateDefaultAlertViewForTests];
  
  __block BOOL blockExecuted = NO;
  alertView.clickedButtonBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
    blockExecuted = YES;
  };
  
  [alertView show];
  [self waitForAnimationFinished];

  
  [alertView dismissWithClickedButtonIndex: 0 animated: YES];
  [self waitForAnimationFinished];
  

  _XCTPrimitiveAssertFalse(blockExecuted, @"click block dont called");
}

- (void)testIfDeverseBlocksGetsCalled {
  
  UIAlertView *alertView = [self generateDefaultAlertViewForTests];
  
  __block NSInteger blockCounter = 0;
  alertView.clickedButtonBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
    blockCounter = 1;
  };
  
  alertView.willDismissBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
    blockCounter = 2;
  };
  
  [alertView show];
  [self waitForAnimationFinished];
  
  
  [alertView dismissWithClickedButtonIndex: 0 animated: YES];
  [self waitForAnimationFinished];
  
  
  _XCTPrimitiveAssertTrue(blockCounter == 2, @"dont called all blocks");
}

@end
