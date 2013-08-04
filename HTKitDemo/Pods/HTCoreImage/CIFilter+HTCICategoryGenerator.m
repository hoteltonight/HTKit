//
//  CIFilter+HTCICategoryGenerator.m
//  HTCoreImageDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "CIFilter+HTCICategoryGenerator.h"

@implementation CIFilter (HTCICategoryGenerator)

+ (CIFilter *)filterCheckerboardGeneratorWithCenter:(CGPoint)center
                                             color0:(UIColor *)color0
                                             color1:(UIColor *)color1
                                              width:(CGFloat)width
                                          sharpness:(CGFloat)sharpness
{
    CIFilter *filter = [CIFilter filterWithName:@"CICheckerboardGenerator"];
    [filter setDefaults];
    [filter setValue:[CIVector vectorWithCGPoint:center] forKey:@"inputCenter"];
    [filter setValue:[CIColor colorWithCGColor:color0.CGColor] forKey:@"inputColor0"];
    [filter setValue:[CIColor colorWithCGColor:color1.CGColor] forKey:@"inputColor1"];
    [filter setValue:@(width) forKey:@"inputWidth"];
    [filter setValue:@(sharpness) forKey:@"inputSharpness"];
    return filter;
}

+ (CIFilter *)filterConstantColorGeneratorWithColor:(UIColor *)color
{
    CIFilter *filter = [CIFilter filterWithName:@"CICheckerboardGenerator"];
    [filter setDefaults];
    [filter setValue:[CIColor colorWithCGColor:color.CGColor] forKey:@"inputColor"];
    return filter;
}

+ (CIFilter *)filterRandomGenerator
{
    CIFilter *filter = [CIFilter filterWithName:@"CIRandomGenerator"];
    [filter setDefaults];
    return filter;
}

+ (CIFilter *)filterStarShineGeneratorWithCenter:(CGPoint)center
                                           color:(UIColor *)color
                                          radius:(CGFloat)radius
                                      crossScale:(CGFloat)crossScale
                                      crossAngle:(CGFloat)crossAngle
                                    crossOpacity:(CGFloat)crossOpacity
                                      crossWidth:(CGFloat)crossWidth
                                         epsilon:(CGFloat)epsilon
{
    CIFilter *filter = [CIFilter filterWithName:@"CIStarShineGenerator"];
    [filter setDefaults];
    [filter setValue:[CIVector vectorWithCGPoint:center] forKey:@"inputCenter"];
    [filter setValue:[CIColor colorWithCGColor:color.CGColor] forKey:@"inputColor"];
    [filter setValue:@(radius) forKey:@"inputRadius"];
    [filter setValue:@(crossScale) forKey:@"inputCrossScale"];
    [filter setValue:@(crossAngle) forKey:@"inputCrossAngle"];
    [filter setValue:@(crossOpacity) forKey:@"inputCrossOpacity"];
    [filter setValue:@(crossWidth) forKey:@"inputCrossWidth"];
    [filter setValue:@(epsilon) forKey:@"inputEpsilon"];
    return filter;
}

+ (CIFilter *)filterStripesGeneratorWithCenter:(CGPoint)center
                                        color0:(UIColor *)color0
                                        color1:(UIColor *)color1
                                         width:(CGFloat)width
                                     sharpness:(CGFloat)sharpness
{
    CIFilter *filter = [CIFilter filterWithName:@"CICheckerboardGenerator"];
    [filter setDefaults];
    [filter setValue:[CIVector vectorWithCGPoint:center] forKey:@"inputCenter"];
    [filter setValue:[CIColor colorWithCGColor:color0.CGColor] forKey:@"inputColor0"];
    [filter setValue:[CIColor colorWithCGColor:color1.CGColor] forKey:@"inputColor1"];
    [filter setValue:@(width) forKey:@"inputWidth"];
    [filter setValue:@(sharpness) forKey:@"inputSharpness"];
    return filter;
}

@end
