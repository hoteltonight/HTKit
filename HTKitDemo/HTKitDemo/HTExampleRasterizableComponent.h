//
//  HTExampleRasterizableComponent.h
//  HTStateAwareRasterDemo
//
//  Created by Jacob Jennings on 12/6/12.
//  Copyright (c) 2012 HotelTonight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTStateAwareRasterImageView.h"

@interface HTExampleRasterizableComponent : UIView <HTRasterizableView>

@property (nonatomic, assign) UIRectCorner roundedCorners;
@property (nonatomic, assign) CGFloat cornerRadius;

@end
