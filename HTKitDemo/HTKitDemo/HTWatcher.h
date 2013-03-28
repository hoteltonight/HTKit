//
// Created by Jacob Jennings on 3/23/13.
// Copyright (c) 2013 Hotel Tonight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+HTWatcher.h"

//  Used as associated object to avoid overriding observeValue… on NSObject in category

@interface HTWatcher : NSObject

@property (nonatomic, copy) HTObserveBlock observeBlock;

@end
