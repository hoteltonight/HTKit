//
// Created by Jacob Jennings on 3/23/13.
// Copyright (c) 2013 Hotel Tonight. All rights reserved.
//

#import "NSObject+HTWatcher.h"
#import "SFObservers.h"
#import "HTWatcher.h"
#import <objc/runtime.h>

// relies on observer removal by SFObservers

static NSString const *kHTWatchersKey = @"kHTWatchersKey";

@interface NSObject (HTWatcherPrivate)

@property (nonatomic, strong) NSMutableArray *htWatchers;

@end

@implementation NSObject (HTWatcher)

- (void)observeKeypaths:(NSArray *)keyPaths observingOptions:(NSKeyValueObservingOptions)options withBlock:(HTObserveBlock)observeBlock;
{
    if (!self.htWatchers)
    {
        self.htWatchers = [NSMutableArray array];
    }
    HTWatcher *watcher = [[HTWatcher alloc] init];
    for (NSString *keyPath in keyPaths)
    {
        [self addObserver:watcher
               forKeyPath:keyPath
                  options:options
                  context:NULL];
    }
    watcher.observeBlock = observeBlock;
    [self.htWatchers addObject:watcher];
}

- (NSMutableArray *)htWatchers
{
    return objc_getAssociatedObject(self, &kHTWatchersKey);
}

- (void)setHtWatchers:(NSMutableArray *)htWatchers
{
    objc_setAssociatedObject(self, &kHTWatchersKey, htWatchers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
