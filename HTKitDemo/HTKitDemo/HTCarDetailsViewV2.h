//
// Created by Jacob Jennings on 3/24/13.
// Copyright (c) 2013 Hotel Tonight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTCarDetailsProtocol.h"

@interface HTCarDetailsViewV2 : UIView<HTCarDetailsProtocol>

@property (nonatomic, copy) NSString *make;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, copy) NSString *colorName;
@property (nonatomic, copy) NSString *carDescription;

@end
