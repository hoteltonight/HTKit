//
// Created by Jacob Jennings on 3/7/13.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <CoreGraphics/CoreGraphics.h>
#import "UIImage+HTCoreImage.h"
#import "HTFloatEqual.h"

@implementation UIImage (HTCoreImage)

- (CIImage *)toCIImage
{
    if (self.CGImage)
    {
        return [CIImage imageWithCGImage:self.CGImage];
    }
    return self.CIImage;
}

- (CGAffineTransform)transformToRotateByHalfPis:(NSUInteger)halfPis
{
    halfPis %= 4;
    if (halfPis == 0)
    {
        return CGAffineTransformIdentity;
    }
    CGAffineTransform transform = CGAffineTransformMakeRotation(halfPis * M_PI_2);
    CGSize scaledSize = (CGSize) { .width = self.size.width * self.scale, .height = self.size.height * self.scale };
    if ([[self class] halfPisFromUpForOrientation:self.imageOrientation] % 2 == 1)
    {
        scaledSize = (CGSize) { .width = scaledSize.height, .height = scaledSize.width };
    }
    switch (halfPis)
    {
        case 1:
        {
            transform = CGAffineTransformTranslate(transform, -scaledSize.width, -scaledSize.height);
        }
        case 2:
        {
            transform = CGAffineTransformTranslate(transform, -scaledSize.height, 0);
        }
        case 3:
        {
            transform = CGAffineTransformTranslate(transform, -scaledSize.width, 0);
        }
        default:break;
    }
    return transform;
}

- (CGAffineTransform)transformToRotateToOrientation:(UIImageOrientation)imageOrientation
{
    return [self transformToRotateByHalfPis:[[self class] halfPisBetweenOrientation:self.imageOrientation
                                                                     andOrientation:imageOrientation]];
}

+ (UIImageOrientation)orientationByRotatingByHalfPis:(NSUInteger)halfPis fromOrientation:(UIImageOrientation)orientation
{
    halfPis %= 4;
    NSUInteger halfPisFromUp = [self halfPisFromUpForOrientation:orientation];
    halfPisFromUp += halfPis;
    UIImageOrientation orientationForHalfPisFromUp = [self orientationForHalfPisFromUp:halfPisFromUp];
    return orientationForHalfPisFromUp;
}

+ (NSUInteger)halfPisFromUpForOrientation:(UIImageOrientation)orientation
{
    switch (orientation)
    {
        case UIImageOrientationUp:return 0;
        case UIImageOrientationRight:return 1;
        case UIImageOrientationDown:return 2;
        case UIImageOrientationLeft:return 3;
        default:return 0;
    }
}

+ (NSUInteger)halfPisBetweenOrientation:(UIImageOrientation)orientation1 andOrientation:(UIImageOrientation)orientation2
{
    NSUInteger halfPisBetweenOrientations = [self halfPisFromUpForOrientation:orientation2] + 4 - [self halfPisFromUpForOrientation:orientation1];
    halfPisBetweenOrientations %= 4;
    return halfPisBetweenOrientations;
}

+ (UIImageOrientation)orientationForHalfPisFromUp:(NSUInteger)halfPisFromUp
{
    switch (halfPisFromUp)
    {
        case 0:return UIImageOrientationUp;
        case 1:return UIImageOrientationRight;
        case 2:return UIImageOrientationDown;
        case 3:return UIImageOrientationLeft;
        default:return UIImageOrientationUp;
    }
}

- (CGRect)rectInPortraitBottomLeftOriginCoordinatesForRect:(CGRect)rect;
{
    return (CGRect) {
        .origin.x = rect.origin.x,
        .origin.y = MAX(self.size.width, self.size.height) - rect.origin.y - rect.size.height,
        .size = rect.size
    };
}

@end
