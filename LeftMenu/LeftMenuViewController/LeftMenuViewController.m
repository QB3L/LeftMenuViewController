//
//  ViewController.m
//  TopBalance Software
//
//  Created by Ruben Nieves on 9/5/13.
//  Copyright (c) 2013 TopBalance Software. All rights reserved.
//

#import "LeftMenuViewController.h"


@implementation UIViewController (LeftMenuItem)

@dynamic leftMenuViewController;

static const char* leftMenuControllerKey = "LeftMenuViewController";

- (LeftMenuViewController *)leftMenuViewController_core {
    return objc_getAssociatedObject(self, leftMenuControllerKey);
}

- (LeftMenuViewController *)leftMenuViewController {
    LeftMenuViewController *result = [self leftMenuViewController_core];
    if (!result && self.navigationController) {
        result = [self.navigationController leftMenuViewController_core];
        if (!result) {
            for (UIViewController* controller in [self.navigationController.viewControllers reverseObjectEnumerator]) {
                if ([controller isKindOfClass:[LeftMenuViewController class]]) {
                    result = (LeftMenuViewController*)controller;
                } else {
                    result = [controller leftMenuViewController_core];
                }
            }
        }
    }
    return result;
}


- (void)setLeftMenuController:(LeftMenuViewController*)menuController {
    objc_setAssociatedObject(self, leftMenuControllerKey, menuController, OBJC_ASSOCIATION_ASSIGN);
}

@end

@interface LeftMenuViewController ()
@property (retain, nonatomic) UIViewController *leftController;
@property (retain, nonatomic) UIViewController *mainController;
@end

@implementation LeftMenuViewController

#pragma mark - Instance Methods
- (BOOL)isClosed
{
    return self.mainController.view.frame.origin.x == 0 || !_mainController;
}

- (void)openAtCustomLeftViewSize:(NSInteger)leftViewWidth animated:(BOOL)animated
{
    CGRect newFrame = CGRectMake(leftViewWidth, self.mainController.view.frame.origin.y, self.mainController.view.frame.size.width, self.mainController.view.frame.size.height);
    if (animated) {
        __weak LeftMenuViewController *me = self;
        [UIView animateWithDuration:_animationsDuration
                         animations:^ {
                             me.mainController.view.frame = newFrame;
                         }
                         completion:nil];
    } else {
        self.mainController.view.frame = newFrame;
    }
}

- (void)resetLeftSideWidth
{
    self.leftViewWidth = LEFTVIEWCONTROLLER_DEFAULT_LEFT_SIDE;
}

- (void)openLeftView:(BOOL)animated
{
    if ([self isClosed]) {
        CGRect newFrame = CGRectOffset(self.mainController.view.frame, self.leftViewWidth, 0 ); //offset by an amount
        if (animated) {
            __weak LeftMenuViewController *me = self;
            [UIView animateWithDuration:_animationsDuration
                             animations:^ {
                                 me.mainController.view.frame = newFrame;
                             }
                             completion:nil];
        } else {
            self.mainController.view.frame = newFrame;
        }
    }
}

- (void)closeLeftView:(BOOL)animated
{
    if (![self isClosed]) {
        CGRect newFrame = CGRectOffset(self.mainController.view.frame, -self.leftViewWidth, 0 ); //offset by an amount
        if (animated) {
            __weak LeftMenuViewController *me = self;
            [UIView animateWithDuration:_animationsDuration
                             animations:^ {
                                 me.mainController.view.frame = newFrame;
                             }
                             completion:nil];
        } else {
            self.mainController.view.frame = newFrame;
        }

    }
}

- (void)toggleLeftView:(BOOL)animated
{
    CGRect newFrame = CGRectZero;
    if ([self isClosed]) {
        newFrame = CGRectOffset(self.mainController.view.frame, self.leftViewWidth, 0 ); //offset by an amount
    } else {
        newFrame = CGRectOffset(self.mainController.view.frame, -self.leftViewWidth, 0 ); //offset by an amount
    }
    if (animated) {
        __weak LeftMenuViewController *me = self;
        [UIView animateWithDuration:_animationsDuration
                         animations:^ {
                             me.mainController.view.frame = newFrame;
                         }
                         completion:nil];
    } else {
        self.mainController.view.frame = newFrame;
    }
}

- (void)openLeftView
{
    [self openLeftView:YES];
}
- (void)closeLeftView
{
    [self closeLeftView:YES];
}

- (void)toggleLeftView
{
    [self toggleLeftView:YES];
}

- (void)setMenuController:(UIViewController *)newController
{
    if (newController == _leftController) { //Don't reassign
        return;
    }
    //Assign
    if (_leftController != nil) {
        [self.leftController.view removeFromSuperview];
        [self.leftController setLeftMenuController:nil];
        self.leftController = nil;
    }
    self.leftController = newController;
    [self.leftController setLeftMenuController:self];
    [self.view addSubview:self.leftController.view];
    [self.view sendSubviewToBack:self.leftController.view];
    self.leftController.view.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);

}

- (void)setCenterController:(UIViewController *)newController
{
    if (newController == _mainController) { //Don't reassign
        return;
    }
    
    NSInteger origin = [self isClosed] ? 0 : _leftViewWidth;
    
    //Assign
    if (_mainController != nil) {
        [self.mainController.view removeFromSuperview];
        [self.mainController setLeftMenuController:nil];
        self.mainController = nil;
    }
    self.mainController = newController;
    [self.mainController setLeftMenuController:self];
    [self.view addSubview:self.mainController.view];
    [self.view bringSubviewToFront:self.mainController.view];
    self.mainController.view.frame = CGRectMake(origin, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    //Set shadow for mainviewcontroller
    UIView *shadowedView = self.mainController.view;
    if (shadowedView) {
        UIBezierPath* newShadowPath = [UIBezierPath bezierPathWithRect:shadowedView.bounds];
        shadowedView.layer.masksToBounds = NO;
        shadowedView.layer.shadowRadius = 10;
        shadowedView.layer.shadowOpacity = 0.5;
        shadowedView.layer.shadowColor = [[UIColor blackColor] CGColor];
        shadowedView.layer.shadowOffset = CGSizeZero;
        shadowedView.layer.shadowPath = [newShadowPath CGPath];
    }
    
}

#pragma mark - View and Object Lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _leftViewWidth = LEFTVIEWCONTROLLER_DEFAULT_LEFT_SIDE;
        _animationsDuration = 0.6;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _leftViewWidth = LEFTVIEWCONTROLLER_DEFAULT_LEFT_SIDE;
        _animationsDuration = 0.6;
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        self.view.frame = window.bounds;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
