//
//  NSObject(HTUpdateAggregator)                                                                                             
//  HotelTonight
//
//  Created by Jonathan Sibley on 2/28/13.
//  Copyright (c) 2013 Hotel Tonight. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTUpdatable

- (void)updateContent;

@optional

+ (NSArray *)keyPathsToTriggerUpdate;

@end

@interface NSObject (HTUpdateAggregator)

- (void)setNeedsUpdate;
- (void)updateContentIfNeeded;

@end
