//
//  HTGraphicsUtilities.h
//  HotelTonight
//
//  Created by Jacob Jennings on 9/18/12.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#ifndef HotelTonight_HTGraphicsUtilities_h
#define HotelTonight_HTGraphicsUtilities_h

#include <CoreGraphics/CGBase.h>
#import "HTFloatEqual.h"

static CGSize const CGSizeMax = { .width = CGFLOAT_MAX, .height = CGFLOAT_MAX };

CG_INLINE CGPoint
HTPointAtAngleAndDistanceFromPoint(CGPoint fromPoint, CGFloat angle, CGFloat distance)
{
    return CGPointMake(fromPoint.x + distance * cos(angle),
                       fromPoint.y + distance * sin(angle));
}

CG_INLINE CGRect
HTCenterSizeInRect(CGSize size, CGRect rect)
{
    return CGRectMake(round(CGRectGetMidX(rect) - size.width / 2),
                      round(CGRectGetMidY(rect) - size.height / 2),
                      size.width,
                      size.height);
}

CG_INLINE CGRect
HTCenterSizeInRectNoRounding(CGSize size, CGRect rect)
{
    return CGRectMake(CGRectGetMidX(rect) - size.width / 2,
                      CGRectGetMidY(rect) - size.height / 2,
                      size.width,
                      size.height);
}

CG_INLINE CGSize
HTSizeInset(CGSize size, CGFloat xInset, CGFloat yInset)
{
    return CGSizeMake(size.width - xInset * 2, size.height - yInset * 2);
}

CG_INLINE CGSize
HTSizeEdgeInset(CGSize size, UIEdgeInsets edgeInsets)
{
    return CGSizeMake(size.width - edgeInsets.left - edgeInsets.right, size.height - edgeInsets.top - edgeInsets.bottom);
}

CG_INLINE CGSize
HTSizeScale(CGSize size, CGFloat scale)
{
    return CGSizeMake(size.width * scale, size.height * scale);
}

CG_INLINE CGSize
HTSizeEdgeOutset(CGSize size, UIEdgeInsets edgeInsets)
{
    return CGSizeMake(size.width + edgeInsets.left + edgeInsets.right, size.height + edgeInsets.top + edgeInsets.bottom);
}

CG_INLINE
void CGRectDivideWithUsefulPadding(CGRect rect, CGRect *slicePtr, CGRect *remainderPtr, CGRect *paddingPtr, CGFloat sliceAmount, CGFloat padding, CGRectEdge edge)
{
    CGRect slice;

    // slice
    CGRectDivide(rect, &slice, &rect, sliceAmount, edge);
    if (slicePtr) *slicePtr = slice;

    // padding / remainder
    CGRectDivide(rect, &slice, &rect, padding, edge);
    if (remainderPtr) *remainderPtr = rect;
    if (paddingPtr) *paddingPtr = slice;
}

// Divides a source rectangle into two component rectangles, skipping the given
// amount of padding in between them.
//
// This functions like CGRectDivide(), but omits the specified amount of padding
// between the two rectangles. This results in a remainder that is `padding`
// points smaller from `edge` than it would be with CGRectDivide().
//
// rect        - The rectangle to divide.
// slice       - Upon return, the portion of `rect` starting from `edge` and
//               continuing for `sliceAmount` points. This argument may be NULL
//               to not return the slice.
// remainder   - Upon return, the portion of `rect` beginning `padding` points
//               after the end of the `slice`. If `rect` is not large enough to
//               leave a remainder, this will be `CGRectZero`. This argument may
//               be NULL to not return the remainder.
// sliceAmount - The number of points to include in `slice`, starting from the
//               given edge.
// padding     - The number of points of padding to omit between `slice` and
//               `remainder`.
// edge        - The edge from which division begins, proceeding toward the
//               opposite edge.
// Inspired by https://github.com/github/Archimedes/blob/master/Archimedes/CGGeometry%2BMEDConvenienceAdditions.m
CG_INLINE
void CGRectDivideWithPadding(CGRect rect, CGRect *slicePtr, CGRect *remainderPtr, CGFloat sliceAmount, CGFloat padding, CGRectEdge edge)
{
    CGRectDivideWithUsefulPadding(rect, slicePtr, remainderPtr, nil, sliceAmount, padding, edge);
}

CG_INLINE CGRect
HTRectGrowSide(CGRect rect, CGRectEdge edge, CGFloat distance)
{
    CGRect growRect = rect;
    switch (edge) {
        case CGRectMinXEdge:
            growRect.origin.x -= distance;
            growRect.size.width += distance;
            break;
            
        case CGRectMaxXEdge:
            growRect.size.width += distance;
            break;
            
        case CGRectMinYEdge:
            growRect.origin.y -= distance;
            growRect.size.height += distance;
            break;
            
        case CGRectMaxYEdge:
            growRect.size.height += distance;
            break;
    }
    return growRect;
}

CG_INLINE CGFloat
HTEaseInOut(CGFloat t)  // for t = [0, 1], returns an sinusoidal ease-in-out value in [0, 1]
{
    return (sin((t * M_PI - M_PI / 2)) + 1) / 2;
}

CG_INLINE CGAffineTransform
HTCGAffineTransformMakeSkew(CGFloat skewAngle)
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.b = tan(skewAngle);
    return transform;
}

#endif
