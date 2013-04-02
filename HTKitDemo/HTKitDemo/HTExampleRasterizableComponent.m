//
//  HTExampleRasterizableComponent.m
//  HTStateAwareRasterDemo
//
//  Created by Jacob Jennings on 12/6/12.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
