//
//  ViewController.h
//  TopBalance Software
//
//  Created by Ruben Nieves on 9/5/13.
//  Copyright (c) 2013 TopBalance Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#define LEFTVIEWCONTROLLER_DEFAULT_LEFT_SIDE 276

@interface LeftMenuViewController : UIViewController

@property (retain, readonly, nonatomic) UIViewController *leftController;
@property (retain, readonly, nonatomic) UIViewController *mainController;
@property (assign, nonatomic) NSInteger leftViewWidth;
@property (assign, nonatomic) CGFloat animationsDuration;

- (BOOL)isClosed;
- (void)openAtCustomLeftViewSize:(NSInteger)leftViewWidth animated:(BOOL)animated;
- (void)resetLeftSideWidth;
- (void)openLeftView:(BOOL)animated;
- (void)openLeftView;
- (void)closeLeftView:(BOOL)animated;
- (void)closeLeftView;
- (void)toggleLeftView;
- (void)setMenuController:(UIViewController *)newController;
- (void)setCenterController:(UIViewController *)newController;
@end


// category on UIViewController to provide access to the menu
@interface UIViewController (LeftMenuItem)
@property(nonatomic,readonly,retain) LeftMenuViewController *leftMenuViewController;

@end
