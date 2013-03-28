//
//  NSObject(HTUpdateAggregator)                                                                                             
//  HotelTonight
//
//  Created by Jonathan Sibley on 2/28/13.
//  Copyright (c) 2013 Hotel Tonight. All rights reserved.
//

#import "NSObject+HTUpdateAggregator.h"
#import <objc/runtime.h>
#import "NSObject+HTWatcher.h"

static NSString const *kUpdateNeededKey = @"UpdateNeededKey";

@implementation NSObject (HTUpdateAggregator)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(
                class_getInstanceMethod(self, @selector(init)),
                class_getInstanceMethod(self, @selector(initUpdateAggregator)));
    });
}

- (instancetype)initUpdateAggregator
{
    self = [self initUpdateAggregator];
    if (self && [self conformsToProtocol:@protocol(HTUpdatable)])
    {
        if ([[self class] respondsToSelector:@selector(keyPathsToTriggerUpdate)])
        {
            __weak NSObject *wSelf = self;
            [self observeKeypaths:[[self class] keyPathsToTriggerUpdate]
                 observingOptions:NSKeyValueObservingOptionNew
                        withBlock:^(NSString *keyPath, id object, NSDictionary *change)
                        {
                            [wSelf setNeedsUpdate];
                        }];
        }
    }
    return self;
}

- (void)setNeedsUpdate
{
    [self performSelector:@selector(updateContentInternal)
               withObject:nil
               afterDelay:0];
    objc_setAssociatedObject(self, &kUpdateNeededKey, (id)kCFBooleanTrue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)updateContentInternal
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(updateContentInternal)
                                               object:nil];
    if ([self respondsToSelector:@selector(updateContent)])
    {
        [(id<HTUpdatable>)self updateContent];
    }
    objc_setAssociatedObject(self, &kUpdateNeededKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)updateContentIfNeeded
{
    if ([objc_getAssociatedObject(self, &kUpdateNeededKey) boolValue])
    {
        [self updateContentInternal];
    }
}

@end
