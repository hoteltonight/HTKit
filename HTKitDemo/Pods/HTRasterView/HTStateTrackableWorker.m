//
// Created by Jacob Jennings on 4/17/13.
// Copyright (c) 2013 Hotel Tonight. All rights reserved.
//

#import "HTStateTrackableWorker.h"
#import "NSObject+HTPropertyHash.h"

@implementation HTStateTrackableWorker

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    [self.owner performSelector:@selector(calculateStateHash) withObject:nil afterDelay:0.1 inModes:@[NSRunLoopCommonModes]];
}

@end
