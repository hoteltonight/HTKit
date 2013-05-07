//
//  CIFilter+HTCICategoryGeometryAdjustment.m
//  HTCoreImageDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



//

#import "CIFilter+HTCICategoryGeometryAdjustment.h"

@implementation CIFilter (HTCICategoryGeometryAdjustment)

+ (CIFilter *)filterWithAffineTransform:(CGAffineTransform)transform;
{
    CIFilter *affineTransformFilter = [CIFilter filterWithName:@"CIAffineTransform"];
    [affineTransformFilter setDefaults];
    [affineTransformFilter setValue:[NSValue valueWithBytes:&transform
                                                   objCType:@encode(CGAffineTransform)]
                             forKey:@"inputTransform"];
    return affineTransformFilter;
}

+ (CIFilter *)filterWithBestAvailableScalingMethod:(CGFloat)scale
{
    CIFilter *scalingFilter = [CIFilter filterLanczosWithScale:scale];
    if (!scalingFilter)
    {
        scalingFilter = [CIFilter filterWithAffineTransform:CGAffineTransformMakeScale(scale, scale)];
    }
    return scalingFilter;
}

+ (CIFilter *)filterLanczosWithScale:(CGFloat)scale;
{
    CIFilter *lanczosFilter = [CIFilter filterWithName:@"CILanczosScaleTransform"];
    [lanczosFilter setDefaults];
    [lanczosFilter setValue:@(scale) forKey:@"inputScale"];
    return lanczosFilter;
}

+ (CIFilter *)filterPerspectiveTransformWithTopLeft:(CGPoint)topLeft
                                           topRight:(CGPoint)topRight
                                        bottomRight:(CGPoint)bottomRight
                                         bottomLeft:(CGPoint)bottomLeft
{
    CIFilter *filter = [CIFilter filterWithName:@"CIPerspectiveTransform"];
    [filter setDefaults];
    [filter setValue:[CIVector vectorWithCGPoint:topLeft] forKey:@"inputTopLeft"];
    [filter setValue:[CIVector vectorWithCGPoint:topRight] forKey:@"inputTopRight"];
    [filter setValue:[CIVector vectorWithCGPoint:bottomRight] forKey:@"inputBottomRight"];
    [filter setValue:[CIVector vectorWithCGPoint:bottomLeft] forKey:@"inputBottomLeft"];
    return filter;
}

+ (CIFilter *)filterPerspectiveTransformWithExtent:(CIVector *)extent
                                           topLeft:(CGPoint)topLeft
                                          topRight:(CGPoint)topRight
                                       bottomRight:(CGPoint)bottomRight
                                        bottomLeft:(CGPoint)bottomLeft
{
    CIFilter *filter = [CIFilter filterWithName:@"CIPerspectiveTransformWithExtent"];
    [filter setDefaults];
    [filter setValue:extent forKey:@"inputExtent"];
    [filter setValue:[CIVector vectorWithCGPoint:topLeft] forKey:@"inputTopLeft"];
    [filter setValue:[CIVector vectorWithCGPoint:topRight] forKey:@"inputTopRight"];
    [filter setValue:[CIVector vectorWithCGPoint:bottomRight] forKey:@"inputBottomRight"];
    [filter setValue:[CIVector vectorWithCGPoint:bottomLeft] forKey:@"inputBottomLeft"];
    return filter;
}

+ (CIFilter *)filterStraightenFilterWithAngle:(CGFloat)angle
{
    CIFilter *filter = [CIFilter filterWithName:@"CIStraightenFilter"];
    [filter setDefaults];
    [filter setValue:@(angle) forKey:@"inputAngle"];
    return filter;
}


@end
