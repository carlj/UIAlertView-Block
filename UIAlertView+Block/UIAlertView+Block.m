//
//  UIAlertView+Block.m
//  AlertView
//
//  Created by Carl Jahn on 09.10.13.
//  Copyright (c) 2013 Carl Jahn. All rights reserved.
//

#import "UIAlertView+Block.h"
#import <objc/objc-runtime.h>

static void *AlertClickedBlockKey = &AlertClickedBlockKey;
static void *AlertWillDismissBlockKey = &AlertWillDismissBlockKey;
static void *AlertDidDismissBlockKey = &AlertWillDismissBlockKey;

static void *AlertCancelBlockKey = &AlertCancelBlockKey;
static void *AlertWillPresentBlockKey = &AlertWillPresentBlockKey;
static void *AlertDidPresentBlockKey = &AlertDidPresentBlockKey;

static void *AlertShouldEnableFirstButtonBlockKey = &AlertShouldEnableFirstButtonBlockKey;


@interface UIAlertView ()<UIAlertViewDelegate>

@end

@implementation UIAlertView (Block)

- (void)testIfDelegateIsSelf {
  
  if (self.delegate != self) {
    self.delegate = self;
  }

}

#pragma mark -
#pragma mark Custom Setter Methods
- (void)setClickedButtonBlock:(AlertViewClickBlock)clickedButtonBlock {
  
  [self testIfDelegateIsSelf];
  
  objc_setAssociatedObject(self, &AlertClickedBlockKey, clickedButtonBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)setWillDismissBlock:(AlertViewClickBlock)willDismissBlock {

  [self testIfDelegateIsSelf];
  
  objc_setAssociatedObject(self, &AlertWillDismissBlockKey, willDismissBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)setDidDismissBlock:(AlertViewClickBlock)didDismissBlock {

  [self testIfDelegateIsSelf];
  
  objc_setAssociatedObject(self, &AlertDidDismissBlockKey, didDismissBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setCancelBlock:(AlertViewBlock)cancelBlock {

  [self testIfDelegateIsSelf];
  
  objc_setAssociatedObject(self, &AlertCancelBlockKey, cancelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setWillPresentBlock:(AlertViewBlock)willPresentBlock {

  [self testIfDelegateIsSelf];
  
  objc_setAssociatedObject(self, &AlertWillPresentBlockKey, willPresentBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setDidPresentBlock:(AlertViewBlock)didPresentBlock {

  [self testIfDelegateIsSelf];
  
  objc_setAssociatedObject(self, &AlertDidPresentBlockKey, didPresentBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setShouldEnableFirstButtonBlock:(AlertViewBoolBlock)shouldEnableFirstButtonBlock {

  [self testIfDelegateIsSelf];
  
  objc_setAssociatedObject(self, &AlertShouldEnableFirstButtonBlockKey, shouldEnableFirstButtonBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark -
#pragma mark Custom Getter Methods
- (AlertViewClickBlock)clickedButtonBlock {
  
  return objc_getAssociatedObject(self, AlertClickedBlockKey);
}

- (AlertViewClickBlock)willDismissBlock {
  
  return objc_getAssociatedObject(self, AlertWillDismissBlockKey);
}

- (AlertViewClickBlock)didDismissBlock {
  
  return objc_getAssociatedObject(self, AlertDidDismissBlockKey);
}

- (AlertViewBlock)cancelBlock {
  
  return objc_getAssociatedObject(self, AlertCancelBlockKey);
}

- (AlertViewBlock)willPresentBlock {
  
  return objc_getAssociatedObject(self, AlertWillPresentBlockKey);
}

- (AlertViewBlock)didPresentBlock {
  
  return objc_getAssociatedObject(self, AlertDidPresentBlockKey);
}

- (AlertViewBoolBlock)shouldEnableFirstButtonBlock {
  
  return objc_getAssociatedObject(self, AlertShouldEnableFirstButtonBlockKey);
}

#pragma mark -
#pragma mark UIAlertViewDelegate Methods


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  
  if (self.clickedButtonBlock) {
    
    __weak typeof(self) weakSelf = self;
    self.clickedButtonBlock(weakSelf, buttonIndex);
    self.clickedButtonBlock = nil;
  }
  
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
  
  if (self.willDismissBlock) {
    
    __weak typeof(self) weakSelf = self;
    self.willDismissBlock(weakSelf, buttonIndex);
    self.willDismissBlock = nil;
  }
  
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  
  if (self.didDismissBlock) {
    
    __weak typeof(self) weakSelf = self;
    self.didDismissBlock(weakSelf, buttonIndex);
    self.didDismissBlock = nil;
  }

}
 
 
- (void)alertViewCancel:(UIAlertView *)alertView {

  if (self.cancelBlock) {
    
    __weak typeof(self) weakSelf = self;
    self.cancelBlock(weakSelf);
    self.cancelBlock = nil;
  }
  
}
 
- (void)willPresentAlertView:(UIAlertView *)alertView {
  
  if (self.willPresentBlock) {
    
    __weak typeof(self) weakSelf = self;
    self.willPresentBlock(weakSelf);
    self.willPresentBlock = nil;
  }
  
}

- (void)didPresentAlertView:(UIAlertView *)alertView {

  if (self.didPresentBlock) {
    
    __weak typeof(self) weakSelf = self;
    self.didPresentBlock(weakSelf);
    self.didPresentBlock = nil;
  }
  
}
 
 
- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {

  BOOL result = YES;
  if (self.shouldEnableFirstButtonBlock) {
    
    __weak typeof(self) weakSelf = self;
    result = self.shouldEnableFirstButtonBlock(weakSelf);
    self.didPresentBlock = nil;
  }
  
  return result;
  
}

@end
