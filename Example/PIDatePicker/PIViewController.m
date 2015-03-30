//
//  PIViewController.m
//  PIDatePicker
//
//  Created by Christopher Jones on 03/30/2015.
//  Copyright (c) 2014 Christopher Jones. All rights reserved.
//

#import "PIViewController.h"

@interface PIViewController ()

@end

@implementation PIViewController

- (void)loadView
{
    UIView *rootView = [[UIView alloc] init];
    rootView.backgroundColor = [UIColor whiteColor];

    PIDatePicker *datePicker = [[PIDatePicker alloc] init];
    datePicker.minimumDate = [NSDate date];
    [rootView addSubview:datePicker];

    datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:datePicker
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:rootView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.f
                                                                          constant:0.f];
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:datePicker
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:rootView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.f
                                                                          constant:0.f];

    [rootView addConstraints:@[centerXConstraint, centerYConstraint]];
    datePicker.backgroundColor = [UIColor greenColor];

    self.view = rootView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
