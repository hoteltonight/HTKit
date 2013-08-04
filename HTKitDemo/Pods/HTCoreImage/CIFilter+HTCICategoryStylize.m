//
//  CIFilter+HTCICategoryStylize.m
//  HTCoreImageDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



//

#import "CIFilter+HTCICategoryStylize.h"

@implementation CIFilter (HTCICategoryStylize)

+ (CIFilter *)filterBlendWithMaskWithBackgroundImage:(CIImage *)backgroundImage maskImage:(CIImage *)maskImage
{
    CIFilter *filter = [CIFilter filterWithName:@"CIBlendWithMask"];
    [filter setDefaults];
    [filter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    [filter setValue:maskImage forKey:@"inputMaskImage"];
    return filter;
}

+ (CIFilter *)filterBloomWithRadius:(CGFloat)radius intensity:(CGFloat)intensity
{
    CIFilter *filter = [CIFilter filterWithName:@"CIBloom"];
    [filter setDefaults];
    [filter setValue:@(radius) forKey:@"inputRadius"];
    [filter setValue:@(intensity) forKey:@"inputIntensity"];
    return filter;
}

+ (CIFilter *)filterGloomWithRadius:(CGFloat)radius intensity:(CGFloat)intensity
{
    CIFilter *filter = [CIFilter filterWithName:@"CIGloom"];
    [filter setDefaults];
    [filter setValue:@(radius) forKey:@"inputRadius"];
    [filter setValue:@(intensity) forKey:@"inputIntensity"];
    return filter;
}

+ (CIFilter *)filterHighlightShadowAdjustWithHighlightAmount:(CGFloat)highlightAmount shadowAmount:(CGFloat)shadowAmount
{
    CIFilter *filter = [CIFilter filterWithName:@"CIHighlightShadowAdjust"];
    [filter setDefaults];
    [filter setValue:@(highlightAmount) forKey:@"inputHighlightAmount"];
    [filter setValue:@(shadowAmount) forKey:@"inputShadowAmount"];
    return filter;
}

+ (CIFilter *)filterPixellateWithCenter:(CGPoint)center scale:(CGFloat)scale
{
    CIFilter *filter = [CIFilter filterWithName:@"CIPixellate"];
    [filter setDefaults];
    [filter setValue:[CIVector vectorWithCGPoint:center] forKey:@"inputCenter"];
    [filter setValue:@(scale) forKey:@"inputScale"];
    return filter;
}


@end
