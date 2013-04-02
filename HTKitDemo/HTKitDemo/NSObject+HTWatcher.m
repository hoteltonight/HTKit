//
// Created by Jacob Jennings on 3/23/13.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
