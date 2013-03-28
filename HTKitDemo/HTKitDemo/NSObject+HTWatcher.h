//
// Created by Jacob Jennings on 3/23/13.
// Copyright (c) 2013 Hotel Tonight. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HTObserveBlock)(NSString *keyPath, id object, NSDictionary *change);

@interface NSObject (HTWatcher)

- (void)observeKeypaths:(NSArray *)keyPaths observingOptions:(NSKeyValueObservingOptions)options withBlock:(HTObserveBlock)observeBlock;

@end
