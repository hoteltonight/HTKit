//
//  HTCarDetailsViewV1.h
//  HTKitDemo
//
//  Created by Jacob Jennings on 3/23/13.
//  Copyright (c) 2013 HotelTonight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTCarDetailsProtocol.h"

@interface HTCarDetailsViewV1 : UIView<HTCarDetailsProtocol>

@property (nonatomic, copy) NSString *make;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, copy) NSString *colorName;
@property (nonatomic, copy) NSString *carDescription;

@end
