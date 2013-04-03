//
//  UIViewController+HTUpdateAggregator.m
//  HTKitDemo
//
//  Created by Jacob Jennings on 4/3/13.
//  Copyright (c) 2013 HotelTonight. All rights reserved.
//

#import "UIViewController+HTUpdateAggregator.h"
#import "NSObject+HTUpdateAggregator.h"
#import <objc/runtime.h>

@implementation UIViewController (HTUpdateAggregator)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod([UIViewController class], @selector(initWithNibName:bundle:)),
                                       class_getInstanceMethod([UIViewController class], @selector(initUpdateAggregator)));
    });
}

- (id)initUpdateAggregatorWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [self initUpdateAggregatorWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self startObservingForUpdates];
    }
    return self;
}

@end
