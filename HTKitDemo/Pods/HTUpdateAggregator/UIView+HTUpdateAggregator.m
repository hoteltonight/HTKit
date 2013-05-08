//
//  UIView+HTUpdateAggregator.m
//  HTKitDemo
//
//  Created by Jacob Jennings on 4/3/13.
//  Copyright (c) 2013 HotelTonight. All rights reserved.
//

#import "UIView+HTUpdateAggregator.h"
#import "NSObject+HTUpdateAggregator.h"
#import <objc/runtime.h>

@implementation UIView (HTUpdateAggregator)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod([UIView class], @selector(init)),
                                       class_getInstanceMethod([UIView class], @selector(initUpdateAggregator)));
    });
}

- (id)initUpdateAggregator
{
    self = [self initUpdateAggregator];
    if (self)
    {
        [self startObservingForUpdates];
    }
    return self;
}

@end
