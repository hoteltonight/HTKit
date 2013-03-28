//
// Created by Jacob Jennings on 3/24/13.
// Copyright (c) 2013 Hotel Tonight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTCarDetailsProtocol.h"

@interface HTCarSwitcherView : UIView

@property (nonatomic, strong) UIView<HTCarDetailsProtocol> *carDetailsView;

@end
