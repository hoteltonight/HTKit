//
//  CIFilter+HTCICategoryGradient.m
//  HTCoreImageDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



//

#import "CIFilter+HTCICategoryGradient.h"

@implementation CIFilter (HTCICategoryGradient)

+ (CIFilter *)filterGaussianGradientWithCenter:(CGPoint)center
                                        color0:(UIColor *)color0
                                        color1:(UIColor *)color1
                                        radius:(CGFloat)radius
{
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianGradient"];
    [filter setDefaults];
    [filter setValue:[CIVector vectorWithCGPoint:center] forKey:@"inputCenter"];
    [filter setValue:[CIColor colorWithCGColor:color0.CGColor] forKey:@"inputColor0"];
    [filter setValue:[CIColor colorWithCGColor:color1.CGColor] forKey:@"inputColor1"];
    [filter setValue:@(radius) forKey:@"inputRadius"];
    return filter;
}

+ (CIFilter *)filterLinearGradientWithPoint0:(CGPoint)point0
                                      point1:(CGPoint)point1
                                      color0:(UIColor *)color0
                                      color1:(UIColor *)color1
{
    CIFilter *filter = [CIFilter filterWithName:@"CILinearGradient"];
    [filter setDefaults];
    [filter setValue:[CIVector vectorWithCGPoint:point0] forKey:@"inputPoint0"];
    [filter setValue:[CIVector vectorWithCGPoint:point0] forKey:@"inputPoint1"];
    [filter setValue:[CIColor colorWithCGColor:color0.CGColor] forKey:@"inputColor0"];
    [filter setValue:[CIColor colorWithCGColor:color1.CGColor] forKey:@"inputColor1"];
    return filter;
}

+ (CIFilter *)filterRadialGradientWithCenter:(CGPoint)center
                                     radius0:(CGFloat)radius0
                                     radius1:(CGFloat)radius1
                                      color0:(UIColor *)color0
                                      color1:(UIColor *)color1
{
    CIFilter *filter = [CIFilter filterWithName:@"CIRadialGradient"];
    [filter setDefaults];
    [filter setValue:@(radius0) forKey:@"inputRadius0"];
    [filter setValue:@(radius1) forKey:@"inputRadius1"];
    [filter setValue:[CIColor colorWithCGColor:color0.CGColor] forKey:@"inputColor0"];
    [filter setValue:[CIColor colorWithCGColor:color1.CGColor] forKey:@"inputColor1"];
    return filter;
}


@end
