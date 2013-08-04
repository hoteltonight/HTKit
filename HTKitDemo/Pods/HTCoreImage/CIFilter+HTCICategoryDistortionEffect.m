//
//  CIFilter+HTCICategoryDistortionEffect.m
//  HTCoreImageDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



//

#import "CIFilter+HTCICategoryDistortionEffect.h"

@implementation CIFilter (HTCICategoryDistortionEffect)

+ (CIFilter *)filterCircleSplashDistortionWithCenter:(CGPoint)center radius:(CGFloat)radius
{
    CIFilter *filter = [CIFilter filterWithName:@"CICircleSplashDistortion"];
    [filter setDefaults];
    [filter setValue:[CIVector vectorWithCGPoint:center] forKey:@"inputCenter"];
    [filter setValue:@(radius) forKey:@"inputRadius"];
    return filter;
}

+ (CIFilter *)filterHoleDistortionWithCenter:(CGPoint)center radius:(CGFloat)radius
{
    CIFilter *filter = [CIFilter filterWithName:@"CIHoleDistortion"];
    [filter setDefaults];
    [filter setValue:[CIVector vectorWithCGPoint:center] forKey:@"inputCenter"];
    [filter setValue:@(radius) forKey:@"inputRadius"];
    return filter;
}

+ (CIFilter *)filterLightTunnelWithCenter:(CGPoint)center
                                 rotation:(CGFloat)rotation
                                   radius:(CGFloat)radius
{
    CIFilter *filter = [CIFilter filterWithName:@"CILightTunnel"];
    [filter setDefaults];
    [filter setValue:[CIVector vectorWithCGPoint:center] forKey:@"inputCenter"];
    [filter setValue:@(rotation) forKey:@"inputRotation"];
    [filter setValue:@(radius) forKey:@"inputRadius"];
    return filter;
}

+ (CIFilter *)filterPinchDistortionWithCenter:(CGPoint)center
                                       radius:(CGFloat)radius
                                        scale:(CGFloat)scale
{
    CIFilter *filter = [CIFilter filterWithName:@"CIPinchDistortion"];
    [filter setDefaults];
    [filter setValue:[CIVector vectorWithCGPoint:center] forKey:@"inputCenter"];
    [filter setValue:@(radius) forKey:@"inputRadius"];
    [filter setValue:@(scale) forKey:@"inputScale"];
    return filter;
}

+ (CIFilter *)filterTwirlDistortionWithCenter:(CGPoint)center radius:(CGFloat)radius angle:(CGFloat)angle
{
    CIFilter *filter = [CIFilter filterWithName:@"CITwirlDistortion"];
    [filter setDefaults];
    [filter setValue:[CIVector vectorWithCGPoint:center] forKey:@"inputCenter"];
    [filter setValue:@(radius) forKey:@"inputRadius"];
    [filter setValue:@(angle) forKey:@"inputAngle"];
    return filter;
}

+ (CIFilter *)filterCropWithRect:(CGRect)rect;
{
    CIFilter *cropFilter = [CIFilter filterWithName:@"CICrop"];
    [cropFilter setValue:[CIVector vectorWithCGRect:rect] forKey:@"inputRectangle"];
    return cropFilter;
}

@end
