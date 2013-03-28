//
//  HTCacheKeyCollector.m
//  HTStateAwareRasterDemo
//
//  Created by Jacob Jennings on 12/7/12.
//  Copyright (c) 2012 HotelTonight. All rights reserved.
//

#import "HTCacheKeyCollector.h"

@interface HTCacheKeyCollector ()

@end

@implementation HTCacheKeyCollector

+ (instancetype)shared
{
    static HTCacheKeyCollector *cacheKeyCollector;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cacheKeyCollector = [[HTCacheKeyCollector alloc] init];
    });
    return cacheKeyCollector;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _cacheKeys = [NSMutableArray array];
    }
    return self;
}

- (void)cacheKeyAdded:(NSString *)cacheKey;
{
    [self.cacheKeys addObject:cacheKey];
}

@end
