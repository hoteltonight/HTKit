//
//  UIView(LayoutWatchers)                                                                                             
//  HotelTonight
//
//  Created by Ray Lillywhite on 3/12/13.
//  Copyright (c) 2013 Hotel Tonight. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+HTLayoutWatcher.h"
#import "NSObject+HTWatcher.h"

@implementation UIView (HTLayoutWatcher)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(
                class_getInstanceMethod(self, @selector(initWithFrame:)),
                class_getInstanceMethod(self, @selector(initWithFrameHTLayoutWatcher:)));
    });
}

- (instancetype)initWithFrameHTLayoutWatcher:(CGRect)frame
{
    self = [self initWithFrameHTLayoutWatcher:frame];
    if (self && [self conformsToProtocol:@protocol(HTLayoutWatchable)])
    {
        __weak UIView *wSelf = self;
        [self observeKeypaths:[[self class] keyPathsToTriggerLayout]
             observingOptions:NSKeyValueObservingOptionNew
                    withBlock:^(NSString *keyPath, id object, NSDictionary *change)
                    {
                        [wSelf setNeedsLayout];
                    }];
    }
    return self;
}

@end
