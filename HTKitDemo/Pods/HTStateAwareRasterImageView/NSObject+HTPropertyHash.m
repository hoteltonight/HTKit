//
//  NSObject+HTPropertyHash.m
//  HotelTonight
//
//  Created by Jacob Jennings on 11/28/12.
//  Copyright (c) 2012 Hotel Tonight. All rights reserved.
//

#import "NSObject+HTPropertyHash.h"

@implementation NSObject (HTPropertyHash)

- (NSString *)hashStringForKeyPaths:(NSArray *)keyPaths
{
    NSMutableString *hashString = [[NSMutableString alloc] initWithString:NSStringFromClass([self class])];
    for (NSString *keyPath in keyPaths)
    {
        NSObject *objectForKeyPath = [self valueForKeyPath:keyPath];
        NSString *description = nil;
        if ([objectForKeyPath isKindOfClass:[NSArray class]])
        {
            NSArray *array = ((NSArray *)objectForKeyPath);
            NSMutableString *descriptionMutable = [[NSMutableString alloc] init];
            [descriptionMutable appendString:@"( "];
            
            [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [descriptionMutable appendString:[self descriptionForObject:obj keyPath:nil]];
                if (idx < [array count] - 1)
                {
                    [descriptionMutable appendString:@", "];
                }
            }];
            
            [descriptionMutable appendString:@" )"];
            description = [descriptionMutable copy];
        }
        else
        {
            description = [self descriptionForObject:objectForKeyPath keyPath:keyPath];
        }
        
        [hashString appendFormat:@"\n%@: %@", keyPath, description];
    }
    return hashString;
}

- (NSString *)descriptionForObject:(NSObject *)object keyPath:(NSString *)keyPath
{
    if (keyPath
        && [self respondsToSelector:@selector(hashDescriptionForKeyPath:)])
    {
        return [(id<HTCustomHash>)self hashDescriptionForKeyPath:keyPath];
    }
    else if ([object respondsToSelector:@selector(hashDescription)])
    {
        return [(id<HTCustomHash>)object hashDescription];
    } else if (object && CFGetTypeID((__bridge CFTypeRef)object) == CGColorGetTypeID()) {
        CGColorRef colorRef = (CGColorRef)CFBridgingRetain(object);
        return [self descriptionForCGColor:colorRef];
    }
    else
    {
        return [object description];
    }
}

- (NSString *)descriptionForCGColor:(CGColorRef)colorRef;
{
    const CGFloat *colorComponents = CGColorGetComponents(colorRef);
    return [NSString stringWithFormat:@"(%f %f %f %f)", colorComponents[0], colorComponents[1], colorComponents[2], colorComponents[3]];
}

@end
