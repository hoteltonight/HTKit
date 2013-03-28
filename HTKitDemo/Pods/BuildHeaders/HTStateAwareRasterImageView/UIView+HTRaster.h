//
//  UIView+HTDrawInContext.h
//  HotelTonight
//
//  Created by Jacob Jennings on 11/29/12.
//  Copyright (c) 2012 Hotel Tonight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTStateAwareRasterImageView.h"

@interface UIView (HTRaster)

@property (nonatomic, assign) HTStateAwareRasterImageView *htRasterImageView;

- (void)drawRect:(CGRect)rect inContext:(CGContextRef)context;
- (UIImage *)layerMaskImage;
- (void)renderAllStateAwareRasterImageViewsFromTheBottomUp;
- (UIView<HTRasterizableView> *)firstAncestorRasterizableView;

@end
