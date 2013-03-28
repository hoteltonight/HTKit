//
//  HTCacheKeyCollector.h
//  HTStateAwareRasterDemo
//
//  Created by Jacob Jennings on 12/7/12.
//  Copyright (c) 2012 HotelTonight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTCacheKeyCollector : NSObject

@property (nonatomic, strong) NSMutableArray *cacheKeys;

+ (instancetype)shared;
- (void)cacheKeyAdded:(NSString *)cacheKey;

@end
