//
//  LeftViewController.m
//  LeftMenu
//
//  Created by Ruben Nieves on 5/19/14.
//  Copyright (c) 2014 TopBalance Software. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftMenuViewController.h"
@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)tapped:(id)sender
{
	UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
	if (tap.state == UIGestureRecognizerStateEnded) {
        if([self.leftMenuViewController isClosed]) {
            [self.leftMenuViewController openLeftView];
        } else {
            [self.leftMenuViewController closeLeftView];
        }
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
