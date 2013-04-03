//
//  HTRadialGradientView.h
//  HotelTonight
//
//  Created by Ray Lillywhite on 2/14/12.
//  Copyright (c) 2012 Hotel Tonight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTRasterView.h"

extern NSString * const kHTRadialGradientException;

@interface HTRadialGradientView : UIView <HTRasterizableView>

@property (nonatomic, assign) CGPoint centerOffset;
@property (nonatomic, assign) CGPoint outerRadiusOffset;
@property (nonatomic, strong) UIColor *startColor;
@property (nonatomic, strong) UIColor *endColor;
@property (nonatomic, strong) NSArray *colors; // takes precedent over startColor/endColor, leave this nil to use startColor/endColor
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat innerRadius;
@property (nonatomic, assign) CGAffineTransform renderTransform; // preferred over layer transform to prevent artifacts.

@end
