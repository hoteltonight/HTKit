//
//  HTExampleRasterizableComponent.m
//  HTStateAwareRasterDemo
//
//  Created by Jacob Jennings on 12/6/12.
//  Copyright (c) 2012 HotelTonight. All rights reserved.
//

#import "HTExampleRasterizableComponent.h"
#import <QuartzCore/QuartzCore.h>

@interface HTExampleRasterizableComponent ()

@property (nonatomic, strong) CAShapeLayer *maskShapeLayer;

@end

@implementation HTExampleRasterizableComponent

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.contentsScale = [[UIScreen mainScreen] scale];
        _maskShapeLayer = [CAShapeLayer layer];
        self.layer.mask = _maskShapeLayer;
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.maskShapeLayer.frame = self.bounds;
    self.maskShapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:self.roundedCorners
                                                       cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)].CGPath;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self setNeedsLayout];
}

- (void)setRoundedCorners:(UIRectCorner)roundedCorners
{
    _roundedCorners = roundedCorners;
    [self setNeedsLayout];
}

- (NSArray *)keyPathsThatAffectState
{
    return @[
    @"cornerRadius",
    @"roundedCorners"];
}

- (UIEdgeInsets)capEdgeInsets
{
    return UIEdgeInsetsMake(self.cornerRadius,
                            self.cornerRadius,
                            self.cornerRadius,
                            self.cornerRadius);
}

- (BOOL)useMinimumFrameForCaps
{
    return YES;
}

@end
