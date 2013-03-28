//
//  HTCarDetailsProtocol.h
//  HTKitDemo
//
//  Created by Jacob Jennings on 3/24/13.
//  Copyright (c) 2013 HotelTonight. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTCarDetailsProtocol <NSObject>

- (void)setMake:(NSString *)make;
- (void)setModel:(NSString *)model;
- (void)setColorName:(NSString *)colorName;
- (void)setCarDescription:(NSString *)carDescription;

@end
