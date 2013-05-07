//
//  UIView+HTDrawInContext.m
//  HotelTonight
//
//  Created by Jacob Jennings on 11/29/12.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "UIView+HTRaster.h"
#import "HTRasterView+Private.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@implementation UIView (HTRaster)

- (void)drawRect:(CGRect)rect inContext:(CGContextRef)context;
{
    if ([NSThread isMainThread])
    {
        [self setNeedsLayout];
        [self layoutIfNeeded];
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self setNeedsLayout];
            [self layoutIfNeeded];
        });
    }
    self.layer.contentsScale = [[UIScreen mainScreen] scale];
    self.layer.mask.contentsScale = [[UIScreen mainScreen] scale];
    if (self.layer.mask)
    {
        UIImage *layerMaskImage = [self layerMaskImage];
        CGContextClipToMask(context, rect, layerMaskImage.CGImage);
    }
    [self.layer renderInContext:context];
}

- (UIImage *)layerMaskImage
{
    if ([self.layer.mask isKindOfClass:[CAShapeLayer class]])
    {
        ((CAShapeLayer *)self.layer.mask).fillColor = [UIColor whiteColor].CGColor;
    }

    CGSize size = CGSizeMake(self.frame.size.width * self.layer.contentsScale, self.frame.size.height * self.layer.contentsScale);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    
    CGContextScaleCTM(context, self.layer.contentsScale, self.layer.contentsScale);
    [self.layer.mask renderInContext:context];
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *outputImage = [UIImage imageWithCGImage:imageRef];
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
        
    return outputImage;
}

- (HTRasterView *)htRasterImageView
{
    return objc_getAssociatedObject(self, (void *)&@selector(htRasterImageView));
}

- (void)setHtRasterImageView:(HTRasterView *)htRasterImageView
{
    objc_setAssociatedObject(self, (void *)&@selector(htRasterImageView), htRasterImageView, OBJC_ASSOCIATION_ASSIGN);
}

@end
