//
//  HTExampleTableCellProtocol.h
//  HTStateAwareRasterDemo
//
//  Created by Jacob Jennings on 12/6/12.
//  Copyright (c) 2012 HotelTonight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTExampleRasterizableComponent.h"

@protocol HTExampleTableCellProtocol <NSObject>

@property (nonatomic, strong) HTExampleRasterizableComponent *rasterizableComponent;
@property (nonatomic, strong) NSString *title;

+ (NSString *)reuseIdentifier;

@end
