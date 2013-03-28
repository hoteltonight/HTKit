//
// Created by Jacob Jennings on 3/24/13.
// Copyright (c) 2013 Hotel Tonight. All rights reserved.
//


#import "HTCarSwitcherView.h"

@implementation HTCarSwitcherView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.carDetailsView.frame = (CGRect) {
        .origin.x = 0,
        .origin.y = 0,
        .size = [self.carDetailsView sizeThatFits:self.bounds.size]
    };
#warning Remove RD log
    NSLog(@"\n\n%@", [self performSelector:@selector(recursiveDescription)]);

}

- (void)setCarDetailsView:(UIView<HTCarDetailsProtocol> *)carDetailsView
{
    [_carDetailsView removeFromSuperview];
    _carDetailsView = carDetailsView;
    [self addSubview:carDetailsView];
    [self setNeedsLayout];
}

@end
