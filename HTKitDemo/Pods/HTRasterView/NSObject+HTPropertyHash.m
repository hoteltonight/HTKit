//
//  NSObject+HTPropertyHash.m
//  HotelTonight
//
//  Created by Jacob Jennings on 11/28/12.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <objc/runtime.h>
#import "NSObject+HTPropertyHash.h"
#import "HTStateTrackableWorker.h"

@interface NSObject (HTPropertyHashPrivate)

@property (nonatomic, strong) HTStateTrackableWorker *stateTrackableWorker;

@end

@implementation NSObject (HTPropertyHash)
@dynamic shouldTrackState;
@dynamic stateHash;

+ (void)load
{
    method_exchangeImplementations(class_getClassMethod(self, @selector(keyPathsForValuesAffectingValueForKey:)), class_getClassMethod(self, @selector(swizzled_keyPathsForValuesAffectingValueForKey:)));
}

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


- (void)calculateStateHash
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(calculateStateHash)
                                               object:nil];
    if (![self conformsToProtocol:@protocol(HTStateTrackable)])
    {
        return;
    }
    NSString *newHash = [self hashStringForKeyPaths:[(id<HTStateTrackable>)self keyPathsThatAffectState]];
    if (![newHash isEqualToString:self.stateHash])
    {
        self.stateHash = newHash;
    }
}


#pragma mark - Properties


static NSString * const kShouldTrackStateKey = @"kShouldTrackStateKey";
- (BOOL)shouldTrackState
{
    return [objc_getAssociatedObject(self, &kShouldTrackStateKey) boolValue];
}


- (void)setShouldTrackState:(BOOL)shouldTrackState
{
    if (![self conformsToProtocol:@protocol(HTStateTrackable)])
    {
        return;
    }
    BOOL wasTrackingState = self.shouldTrackState;
    objc_setAssociatedObject(self, &kShouldTrackStateKey, @(shouldTrackState), OBJC_ASSOCIATION_RETAIN);
    if (shouldTrackState && !wasTrackingState)
    {
        [self calculateStateHash];
        for (NSString *keyPath in [(id<HTStateTrackable>)self keyPathsThatAffectState])
        {
            [self addObserver:self.stateTrackableWorker forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        }
    }
    else if (!shouldTrackState && wasTrackingState)
    {
        for (NSString *keyPath in [(id<HTStateTrackable>)self keyPathsThatAffectState])
        {
            [self removeObserver:self.stateTrackableWorker forKeyPath:keyPath];
        }
    }
}


static NSString * const kStateHashKey = @"kStateHashKey";
- (NSString *)stateHash
{
    return objc_getAssociatedObject(self, &kStateHashKey);
}

- (void)setStateHash:(NSString *)stateHash
{
    [self willChangeValueForKey:@"stateHash"];
    objc_setAssociatedObject(self, &kStateHashKey, stateHash, OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"stateHash"];
}


static NSString * const kStateTrackableWorker = @"kStateTrackableWorker";
- (HTStateTrackableWorker *)stateTrackableWorker
{
    HTStateTrackableWorker *worker = objc_getAssociatedObject(self, &kStateTrackableWorker);
    if (!worker)
    {
        worker = [[HTStateTrackableWorker alloc] init];
        worker.owner = (NSObject<HTStateTrackable> *)self;
        self.stateTrackableWorker = worker;
    }
    return worker;
}

- (void)setStateTrackableWorker:(HTStateTrackableWorker *)stateTrackableWorker
{
    objc_setAssociatedObject(self, &kStateTrackableWorker, stateTrackableWorker, OBJC_ASSOCIATION_RETAIN);
}


+ (NSSet *)swizzled_keyPathsForValuesAffectingValueForKey:(NSString *)key;
{
    if ([key isEqualToString:@"frameSize"])
    {
        return [NSSet setWithObject:@"frame"];
    }
    return [self swizzled_keyPathsForValuesAffectingValueForKey:key];
}

@end
