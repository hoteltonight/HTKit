//
// Created by Jacob Jennings on 4/17/13.
// Copyright (c) 2013 Hotel Tonight. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTStateTrackable;

@interface HTStateTrackableWorker : NSObject

@property (nonatomic, weak) NSObject<HTStateTrackable> *owner;

@end
