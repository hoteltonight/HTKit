//
//  HTViewController.m
//  HTCopyableLabelDemo
//
//  Created by Jonathan Sibley on 7/24/13.
//  Copyright (c) 2013 HotelTonight. All rights reserved.
//

#import "HTCopyViewController.h"
#import "HTCopyableLabel.h"

@interface HTCopyViewController () <HTCopyableLabelDelegate>

@property (nonatomic, weak) IBOutlet HTCopyableLabel    *label1;

@property (nonatomic, weak) IBOutlet UIView             *labelContainer1;
@property (nonatomic, weak) IBOutlet HTCopyableLabel    *label2;
@property (nonatomic, weak) IBOutlet HTCopyableLabel    *label3;
@property (nonatomic, weak) IBOutlet HTCopyableLabel    *label4;

@property (nonatomic, weak) IBOutlet UIView             *labelContainer2;
@property (nonatomic, weak) IBOutlet HTCopyableLabel    *label5;

@end

@implementation HTCopyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.label2.copyableLabelDelegate = self;
    self.label3.copyableLabelDelegate = self;
    self.label4.copyableLabelDelegate = self;

    self.label5.copyableLabelDelegate = self;
    [self.labelContainer2 addGestureRecognizer:self.label5.longPressGestureRecognizer];
}

#pragma mark - HTCopyableLabelDelegate

- (NSString *)stringToCopyForCopyableLabel:(HTCopyableLabel *)copyableLabel
{
    NSString *stringToCopy = @"";

    if (copyableLabel == self.label2
        || copyableLabel == self.label3
        || copyableLabel == self.label4)
    {
        stringToCopy = [NSString stringWithFormat:@"%@\n\n%@\n\n%@", self.label2.text, self.label3.text, self.label4.text];
    }
    else if (copyableLabel == self.label5)
    {
        stringToCopy = self.label5.text;
    }

    return stringToCopy;
}

- (CGRect)copyMenuTargetRectInCopyableLabelCoordinates:(HTCopyableLabel *)copyableLabel
{
    CGRect rect;

    if (copyableLabel == self.label2
        || copyableLabel == self.label3
        || copyableLabel == self.label4)
    {
        // The UIMenuController will appear close to container, indicating all of its contents will be copied
        rect = [self.labelContainer1 convertRect:self.labelContainer1.bounds toView:copyableLabel];
    }
    else if (copyableLabel == self.label5)
    {
        // The UIMenuController will appear close to the label itself
        rect = copyableLabel.bounds;
    }

    return rect;
}

@end
