//
// Created by Jacob Jennings on 3/23/13.
// Copyright (c) 2013 Hotel Tonight. All rights reserved.
//

#import "HTWatcher.h"

@implementation HTWatcher

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (self.observeBlock)
    {
        self.observeBlock(keyPath, object, change);
    }
}

@end
