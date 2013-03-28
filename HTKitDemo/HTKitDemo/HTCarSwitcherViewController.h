//
// Created by Jacob Jennings on 3/24/13.
// Copyright (c) 2013 Hotel Tonight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTCarSwitcherView.h"

@interface HTCarSwitcherViewController : UIViewController

@property (nonatomic, strong) NSNumber *carSwitcherVersion;
- (IBAction)switchCarsTapped:(id)sender;

@end
