//
//  UIAlertView+Block.h
//  AlertView
//
//  Created by Carl Jahn on 09.10.13.
//  Copyright (c) 2013 Carl Jahn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertViewClickBlock)(UIAlertView *alertView, NSInteger buttonIndex);
typedef void(^AlertViewBlock)(UIAlertView *alertView);
typedef BOOL(^AlertViewBoolBlock)(UIAlertView *alertView);

@interface UIAlertView (Block)

@property (nonatomic, copy) AlertViewClickBlock clickedButtonBlock;
@property (nonatomic, copy) AlertViewClickBlock willDismissBlock;
@property (nonatomic, copy) AlertViewClickBlock didDismissBlock;

@property (nonatomic, copy) AlertViewBlock cancelBlock;
@property (nonatomic, copy) AlertViewBlock willPresentBlock;
@property (nonatomic, copy) AlertViewBlock didPresentBlock;

@property (nonatomic, copy) AlertViewBoolBlock shouldEnableFirstButtonBlock;

@end
