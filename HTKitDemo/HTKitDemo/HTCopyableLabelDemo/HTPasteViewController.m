//
//  HTPasteViewController.m
//  HTCopyableLabelDemo
//
//  Created by Jonathan Sibley on 7/24/13.
//  Copyright (c) 2013 HotelTonight. All rights reserved.
//

#import "HTPasteViewController.h"

@interface HTPasteViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation HTPasteViewController

- (IBAction)dismissKeyboard:(id)sender
{
    [self.textView resignFirstResponder];
}

@end
