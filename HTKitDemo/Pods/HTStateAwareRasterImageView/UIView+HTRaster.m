//
//  UIView+HTDrawInContext.m
//  HotelTonight
//
//  Created by Jacob Jennings on 11/29/12.
//  Copyright (c) 2012 Hotel Tonight. All rights reserved.
//

#import "UIView+HTRaster.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@implementation UIView (HTRaster)

+ (void)load
{
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(didMoveToSuperview)), class_getInstanceMethod(self, @selector(htRasterDidMoveToSuperview)));
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(willMoveToSuperview:)), class_getInstanceMethod(self, @selector(htRasterWillMoveToSuperview:)));
}

- (void)drawRect:(CGRect)rect inContext:(CGContextRef)context;
{
    [self layoutSubviews];
    self.layer.contentsScale = [[UIScreen mainScreen] scale];
    self.layer.mask.contentsScale = [[UIScreen mainScreen] scale];
    if (self.layer.mask)
    {
        UIImage *layerMaskImage = [self layerMaskImage];
        CGContextClipToMask(context, rect, layerMaskImage.CGImage);
    }
    [self.layer renderInContext:context];
}

- (void)renderAllStateAwareRasterImageViewsFromTheBottomUp;
{
    for (UIView *view in self.subviews)
    {
        [view renderAllStateAwareRasterImageViewsFromTheBottomUp];
    }
    if ([self isKindOfClass:[HTStateAwareRasterImageView class]])
    {
        HTStateAwareRasterImageView *rasterImageView = (HTStateAwareRasterImageView *)self;
        BOOL drawsOnMainThread = rasterImageView.drawsOnMainThread;
        rasterImageView.drawsOnMainThread = YES;
        [rasterImageView regenerateImage:^{
            rasterImageView.drawsOnMainThread = drawsOnMainThread;
        }];
    }
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

- (UIView<HTRasterizableView> *)firstAncestorRasterizableView;
{
    UIView *view = self;
    while (view.superview)
    {
        view = view.superview;
        if (view && view != self && [view conformsToProtocol:@protocol(HTRasterizableView)] && view.htRasterImageView)
        {
            return (UIView<HTRasterizableView> *)view;
        }
    }
    return nil;
}

- (HTStateAwareRasterImageView *)htRasterImageView
{
    return objc_getAssociatedObject(self, (void *)&@selector(htRasterImageView));
}

- (void)setHtRasterImageView:(HTStateAwareRasterImageView *)htRasterImageView
{
    objc_setAssociatedObject(self, (void *)&@selector(htRasterImageView), htRasterImageView, OBJC_ASSOCIATION_ASSIGN);
    [self performSelector:@selector(checkRegisterWithAncestor) withObject:nil afterDelay:0];
}

- (void)htRasterDidMoveToSuperview
{
    [self performSelector:@selector(checkRegisterWithAncestor) withObject:nil afterDelay:0];
    [self htRasterDidMoveToSuperview];
}

- (void)checkRegisterWithAncestor
{
    if (![self isKindOfClass:[HTStateAwareRasterImageView class]])
    {
        return;
    }
    HTStateAwareRasterImageView *firstAncestorRasterImageView = [self firstAncestorRasterizableView].htRasterImageView;
    NSLog(@"\nDidMoveToSuperview: rasterizableView: %@\n firstAncestorRasterizableView: %@", ((HTStateAwareRasterImageView *)self).rasterizableView, [self firstAncestorRasterizableView]);
    if (firstAncestorRasterImageView)
    {
        [firstAncestorRasterImageView registerDescendantRasterImageView:(HTStateAwareRasterImageView *)self];
    }
}

- (void)unregisterWithAncestor
{
    HTStateAwareRasterImageView *firstAncestorRasterImageView = [self firstAncestorRasterizableView].htRasterImageView;
    if (firstAncestorRasterImageView)
    {
        [firstAncestorRasterImageView unregisterDescendantRasterImageView:(HTStateAwareRasterImageView *)self];
    }
}

- (void)htRasterWillMoveToSuperview:(UIView *)newSuperview
{
    if (![self isKindOfClass:[HTStateAwareRasterImageView class]])
    {
        return;
    }
    if (!newSuperview)
    {
        [self unregisterWithAncestor];
    }
    [self htRasterWillMoveToSuperview:newSuperview];
}

@end
