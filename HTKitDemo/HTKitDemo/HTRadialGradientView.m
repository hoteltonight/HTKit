//
//  HTRadialGradientView.m
//  HotelTonight
//
//  Created by Ray Lillywhite on 2/14/12.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "HTRadialGradientView.h"
#import <QuartzCore/QuartzCore.h>

NSString * const kHTRadialGradientException = @"HTRadialGradientException";

@implementation HTRadialGradientView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _radius = 250.0;
        _startColor = [UIColor clearColor];
        _endColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        _renderTransform = CGAffineTransformIdentity;
        self.opaque = NO;
        self.userInteractionEnabled = NO;
        
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    }
    return self;
}

#pragma mark - Accessors

- (void)setCenterOffset:(CGPoint)centerOffset
{
    _centerOffset = centerOffset;
    [self setNeedsDisplay];
}

- (void)setOuterRadiusOffset:(CGPoint)outerRadiusOffset
{
    _outerRadiusOffset = outerRadiusOffset;
    [self setNeedsDisplay];
}

- (void)setStartColor:(UIColor *)startColor
{
    _startColor = startColor;
    [self setNeedsDisplay];
}

- (void)setEndColor:(UIColor *)endColor
{
    _endColor = endColor;
    [self setNeedsDisplay];
}

- (void)setRadius:(CGFloat)radius
{
    _radius = radius;
    [self setNeedsDisplay];
}

- (void)setColors:(NSArray *)colors
{
    _colors = colors;
    [self setNeedsDisplay];
}

- (void)setRenderTransform:(CGAffineTransform)renderTransform
{
    _renderTransform = renderTransform;
    [self setNeedsDisplay];
}

#pragma mark - Utilities

- (void)parseColor:(UIColor *)color intoArray:(CGFloat[])array
{
    const CGFloat *components = CGColorGetComponents([color CGColor]);
    size_t numberOfComponents = CGColorGetNumberOfComponents([color CGColor]);
    if (numberOfComponents == 4)
    {
        for (int i = 0; i < 4; ++i)
        {
            array[i] = components[i];
        }
    }
    else if (numberOfComponents == 2)
    {
        for (int i = 0; i < 3; ++i)
        {
            array[i] = components[0];
        }
        array[3] = components[1];
    }
    else
    {
        @throw [NSException exceptionWithName:kHTRadialGradientException
                                       reason:[NSString stringWithFormat:@"Could not convert color to RGBA: %@", color]
                                     userInfo:nil];
    }
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    NSArray *colors = self.colors;
    if (colors == nil)
    {
        UIColor *startColor = self.startColor;
        if (startColor == nil)
        {
            startColor = [UIColor clearColor];
        }
        
        UIColor *endColor = self.endColor;
        if (endColor == nil)
        {
            endColor = [UIColor clearColor];
        }
        
        colors = @[startColor, endColor];
    }
    
    CGFloat locations[colors.count];
    CGFloat components[colors.count * 4];
    for (int i = 0; i < colors.count; ++ i)
    {
        UIColor *color = colors[i];
        locations[i] = (CGFloat)i / (CGFloat)colors.count;
        [self parseColor:color intoArray:components + 4 * i];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, colors.count);
    
    CGPoint startPoint = CGPointMake(roundf(self.bounds.size.width / 2.0 + self.centerOffset.x), roundf(self.bounds.size.height / 2.0 + self.centerOffset.y));
    CGPoint endPoint = startPoint;
    endPoint.x += self.outerRadiusOffset.x;
    endPoint.y += self.outerRadiusOffset.y;
    
    CGContextConcatCTM(ctx, self.renderTransform);
    
    CGContextDrawRadialGradient(ctx, gradient, startPoint, self.innerRadius, endPoint, self.radius, kCGGradientDrawsAfterEndLocation | kCGGradientDrawsBeforeStartLocation);
    
    CGContextRestoreGState(ctx);
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}

- (void)layoutSubviews
{
    [self setNeedsDisplay];
}

#pragma mark - HTRasterizableView protocol

- (NSArray *)keyPathsThatAffectState
{
    return @[
    @"centerOffset",
    @"outerRadiusOffset",
    @"startColor",
    @"endColor",
    @"colors",
    @"radius",
    @"innerRadius",
    @"renderTransform",
    @"frameSize"];
}

@end
