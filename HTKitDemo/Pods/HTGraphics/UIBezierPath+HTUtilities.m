//
//  UIBezierPath+HTUtilities.m
//  HotelTonight
//
//  Created by Jacob Jennings on 11/7/12.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "UIBezierPath+HTUtilities.h"

@implementation UIBezierPath (HTUtilities)

+ (UIBezierPath *)bezierPathWithReverseRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)radius
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    if (corners & UIRectCornerTopLeft) {
        [path moveToPoint:CGPointMake(rect.origin.x + radius, rect.origin.y)];
        [path addArcWithCenter:CGPointMake(rect.origin.x + radius, rect.origin.y + radius) radius:radius startAngle:M_PI + M_PI_2 endAngle:M_PI clockwise:NO];
    } else {
        [path moveToPoint:rect.origin];
    }
    
    if (corners & UIRectCornerBottomLeft) {
        [path addLineToPoint:CGPointMake(rect.origin.x, CGRectGetMaxY(rect) - radius)];
        [path addArcWithCenter:CGPointMake(rect.origin.x + radius, CGRectGetMaxY(rect) - radius) radius:radius startAngle:M_PI endAngle:M_PI_2 clockwise:NO];
    } else {
        [path addLineToPoint:CGPointMake(rect.origin.x, CGRectGetMaxY(rect))];
    }

    if (corners & UIRectCornerBottomRight) {
        [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect) - radius, CGRectGetMaxY(rect))];
        [path addArcWithCenter:CGPointMake(CGRectGetMaxX(rect) - radius, CGRectGetMaxY(rect) - radius) radius:radius startAngle:M_PI_2 endAngle:0 clockwise:NO];
    } else {
        [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect))];
    }
    
    if (corners & UIRectCornerTopRight) {
        [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect), rect.origin.y + radius)];
        [path addArcWithCenter:CGPointMake(CGRectGetMaxX(rect) - radius, rect.origin.y + radius) radius:radius startAngle:0 endAngle:M_PI + M_PI_2 clockwise:NO];
    } else {
        [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect), rect.origin.y)];
    }
    
    [path closePath];
    
    return path;
}

- (UIBezierPath *)inversePathInBounds:(CGRect)bounds;
{
	UIBezierPath *path = [[UIBezierPath alloc] init];
    CGRect expandedBounds = CGRectInset(bounds, -10, -10);
	
	[path moveToPoint:expandedBounds.origin];
	[path addLineToPoint:CGPointMake(CGRectGetMinX(expandedBounds), CGRectGetMaxY(expandedBounds))];
	[path addLineToPoint:CGPointMake(CGRectGetMaxX(expandedBounds), CGRectGetMaxY(expandedBounds))];
	[path addLineToPoint:CGPointMake(CGRectGetMaxX(expandedBounds), CGRectGetMinY(expandedBounds))];
	[path closePath];
    
    [path appendPath:self];
	
	return path;
}

@end
