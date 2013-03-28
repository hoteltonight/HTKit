//
//  CAGradientLayer+AHEasing.m
//  HotelTonight
//
//  Created by Jacob Jennings on 2/22/13.
//

/*
 Copyright (c) 2013 Hotel Tonight
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "CAGradientLayer+AHEasing.h"
#import "UIColor+CrossFade.h"

static NSString * const kColorsKey = @"colors";
static NSString * const kLocationsKey = @"locations";

// todo keyframe density instead of between locations?

@implementation CAGradientLayer (AHEasing)

- (void)setEasedGradientColors:(NSArray *)colors
                     locations:(NSArray *)locations
                easingFunction:(AHEasingFunction)easingFunction
     keyframesBetweenLocations:(NSUInteger)keyframesBetweenLocations;
{
    NSDictionary *colorsAndLocations = [[self class] easedGradientColorsAndLocationsWithColors:colors
                                                                                     locations:locations
                                                                                easingFunction:easingFunction
                                                                     keyframesBetweenLocations:keyframesBetweenLocations];
    NSMutableArray *cgColors = [NSMutableArray arrayWithCapacity:[colorsAndLocations[kColorsKey] count]];
    for (UIColor *color in colorsAndLocations[kColorsKey])
    {
        [cgColors addObject:(id)color.CGColor];
    }
    [self setColors:cgColors];
    [self setLocations:colorsAndLocations[kLocationsKey]];
}

+ (NSDictionary *)easedGradientColorsAndLocationsWithColors:(NSArray *)colors
                                                  locations:(NSArray *)locations
                                             easingFunction:(AHEasingFunction)easingFunction
                                  keyframesBetweenLocations:(NSUInteger)keyframesBetweenLocations;
{
    if ([colors count] == 1)
    {
        return colors[0];
    }
    else if (![colors count])
    {
        return nil;
    }
    
    NSUInteger capacity = ([colors count] - 1) * keyframesBetweenLocations;
    NSMutableArray *colorsMutable = [NSMutableArray arrayWithCapacity:capacity];
    NSMutableArray *locationsMutable = [NSMutableArray arrayWithCapacity:capacity];
    
    for (NSUInteger idx = 0; idx < [colors count] - 1; idx++)
    {
        UIColor *fromColor = colors[idx];
        UIColor *toColor = colors[idx + 1];
        
        NSDictionary *colorsAndLocations = [self easedGradientColorsAndLocationsFromColor:fromColor
                                                                                  toColor:toColor
                                                                           easingFunction:easingFunction
                                                                keyframesBetweenLocations:keyframesBetweenLocations];
        NSArray *colorsToAdd, *locationsToAdd;
        if (idx == [colors count] - 2)
        {
            colorsToAdd = colorsAndLocations[kColorsKey];
            locationsToAdd = colorsAndLocations[kLocationsKey];
        }
        else
        {
            NSRange rangeMinusLastElement = NSMakeRange(0, [colorsAndLocations[kColorsKey] count] - 2);
            colorsToAdd = [colorsAndLocations[kColorsKey] objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:rangeMinusLastElement]];
            locationsToAdd = [colorsAndLocations[kLocationsKey] objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:rangeMinusLastElement]];
        }
        [colorsMutable addObjectsFromArray:colorsToAdd];
        [locationsMutable addObjectsFromArray:[self locationsScaledToRangeLocations:locationsToAdd
                                                                       fromLocation:locations[idx]
                                                                         toLocation:locations[idx + 1]]];
    }
    
    return @{kColorsKey : [NSArray arrayWithArray:colorsMutable],
             kLocationsKey : [NSArray arrayWithArray:locationsMutable]};
}

+ (NSDictionary *)easedGradientColorsAndLocationsFromColor:(UIColor *)fromColor
                                                   toColor:(UIColor *)toColor
                                            easingFunction:(AHEasingFunction)easingFunction
                                 keyframesBetweenLocations:(NSUInteger)keyframesBetweenLocations;
{
    NSMutableArray *colorsMutable = [NSMutableArray arrayWithCapacity:keyframesBetweenLocations];
    NSMutableArray *locationsMutable = [NSMutableArray arrayWithCapacity:keyframesBetweenLocations];
    
    CGFloat t = 0.0;
	CGFloat dt = 1.0 / (keyframesBetweenLocations - 1);
	for(size_t frame = 0; frame < keyframesBetweenLocations; ++frame, t += dt)
	{
        UIColor *color = [UIColor colorForFadeBetweenFirstColor:fromColor
                                                    secondColor:toColor
                                                        atRatio:easingFunction(t)
                                             compareColorSpaces:YES];
		[colorsMutable addObject:color];
        [locationsMutable addObject:@(t)];
	}
    
    return @{kColorsKey : [NSArray arrayWithArray:colorsMutable],
             kLocationsKey : [NSArray arrayWithArray:locationsMutable]};
}

+ (NSArray *)locationsScaledToRangeLocations:(NSArray *)locations
                                fromLocation:(NSNumber *)fromLocation
                                  toLocation:(NSNumber *)toLocation;
{
    NSMutableArray *locationsMutable = [NSMutableArray arrayWithCapacity:[locations count]];
    
    CGFloat scale = abs([toLocation doubleValue] - [fromLocation doubleValue]);
    for (NSNumber *location in locations)
    {
        [locationsMutable addObject:@([fromLocation doubleValue] + [location doubleValue] * scale)];
    }
    
    return [NSArray arrayWithArray:locationsMutable];
}

@end
