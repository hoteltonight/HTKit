//
//  UIView(HTLayoutWatcher)
//  HotelTonight
//
//  Created by Ray Lillywhite on 3/12/13.
//  Copyright (c) 2013 Hotel Tonight. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTLayoutWatchable

+ (NSArray *)keyPathsToTriggerLayout;

@end

@interface UIView (HTLayoutWatcher)

@end
