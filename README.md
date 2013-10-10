#UIAlertView+Block
Simple handle the actions from a UIAlertView with blocks.

[![Build Status](https://travis-ci.org/carlj/UIAlertView-Block.png?branch=master)](https://travis-ci.org/carlj/UIAlertView-Block)
[![Coverage Status](https://coveralls.io/repos/carlj/UIAlertView-Block/badge.png)](https://coveralls.io/r/carlj/UIAlertView-Block)

##Installation
Just drag & drop the [`UIAlertView+Block.h`](UIAlertView+Block/UIAlertView+Block.h) and [`UIAlertView+Block.m`](UIAlertView+Block/UIAlertView+Block.m) to your project.

##Example
First of all take a look at the [Example Project](Example/Classes/ExampleViewController.m)

##Usage
``` objc
UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Hello"
                                                    message: @"Lorem ipsum"
                                                   delegate: nil
                                          cancelButtonTitle: @"Cancel"
                                          otherButtonTitles: @"Button 1", @"Button 2", nil];

alertView.clickedButtonBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
	//Here you go, if a button was clicked
};

[alertView show];
```

If you need more information for the specific block or method, take a look at the [`UIAlertView+Block.h`](UIAlertView+Block/UIAlertView+Block.h) file.

##LICENSE
Released under the [MIT LICENSE](LICENSE)