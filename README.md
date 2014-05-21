LeftMenuViewController
======================

Simple View Controller to reveal menu on left side of your app. Similar to many popular apps. It is meant to offer the simplest customizable version for this functionality.


Screenshots
--------------------
![QBLog](http://www.topbalancesoftware.com/apps/gitmedia/leftmenu.gif)

Getting Started
=================

Install
--------------------
1. Load all files under LeftMenuViewController in sample project to your own project.
2. `#import "LeftMenuViewController.h"`

Usage
--------------------
Look at sample application's AppDelegate for basic usage
Example:
```
    LeftViewController *leftView = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
    MainViewController *mainView = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    self.menuController = [[LeftMenuViewController alloc] init];
    [self.menuController setMenuController:leftView];
    [self.menuController setCenterController:mainView];
    self.window.rootViewController = self.menuController;
	[_window makeKeyAndVisible];
```

Also take a look at header file for basic usage.

MIT License
--------------------
    The MIT License (MIT)

    Copyright (c) 2014 Ruben Nieves

    Permission is hereby granted, free of charge, to any person obtaining a copy of
    this software and associated documentation files (the "Software"), to deal in
    the Software without restriction, including without limitation the rights to
    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
    the Software, and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
