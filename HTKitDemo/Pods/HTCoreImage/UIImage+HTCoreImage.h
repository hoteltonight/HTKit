//
// Created by Jacob Jennings on 3/7/13.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>

static inline NSString * NSStringFromUIImageOrientation(UIImageOrientation imageOrientation)
{
    switch(imageOrientation)
    {
        case UIImageOrientationUp:return @"UIImageOrientationUp";
        case UIImageOrientationDown:return @"UIImageOrientationDown";
        case UIImageOrientationLeft:return @"UIImageOrientationLeft";
        case UIImageOrientationRight:return @"UIImageOrientationRight";
        case UIImageOrientationUpMirrored:return @"UIImageOrientationUpMirrored";
        case UIImageOrientationDownMirrored:return @"UIImageOrientationDownMirrored";
        case UIImageOrientationLeftMirrored:return @"UIImageOrientationLeftMirrored";
        case UIImageOrientationRightMirrored:return @"UIImageOrientationRightMirrored";
    }
    return nil;
}

static inline BOOL UIImageOrientationIsMirrored(UIImageOrientation imageOrientation)
{
    switch(imageOrientation)
    {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            return YES;
        default:break;
    }
    return NO;
}

@interface UIImage (HTCoreImage)

- (CIImage *)toCIImage;
- (CGAffineTransform)transformToRotateToOrientation:(UIImageOrientation)imageOrientation;
- (CGRect)rectInPortraitBottomLeftOriginCoordinatesForRect:(CGRect)rect;
- (CGAffineTransform)transformToRotateByHalfPis:(NSUInteger)halfPis;

@end