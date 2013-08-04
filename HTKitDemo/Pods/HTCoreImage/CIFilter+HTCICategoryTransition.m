//
//  CIFilter+HTCICategoryTransition.m
//  HTCoreImageDemo
//
//  Created by Jacob Jennings on 4/2/13.
//

#import "CIFilter+HTCICategoryTransition.h"

@implementation CIFilter (HTCICategoryTransition)

+ (CIFilter *)filterBarsSwipeTransitionWithTargetImage:(CIImage *)targetImage
                                                 angle:(CGFloat)angle
                                                 width:(CGFloat)width
                                             barOffset:(CGFloat)barOffset
                                                  time:(CGFloat)time;
{
    CIFilter *filter = [CIFilter filterWithName:@"CIBarsSwipeTransition"];
    [filter setDefaults];
    [filter setValue:targetImage forKey:@"inputTargetImage"];
    [filter setValue:@(angle) forKey:@"inputAngle"];
    [filter setValue:@(width) forKey:@"inputWidth"];
    [filter setValue:@(barOffset) forKey:@"inputBarOffset"];
    [filter setValue:@(time) forKey:@"inputTime"];
    return filter;
}

+ (CIFilter *)filterCopyMachineTransitionWithTargetImage:(CIImage *)targetImage
                                                  extent:(CIVector *)extent
                                                   color:(UIColor *)color
                                                    time:(CGFloat)time
                                                   angle:(CGFloat)angle
                                                   width:(CGFloat)width
                                                 opacity:(CGFloat)opacity
{
    CIFilter *filter = [CIFilter filterWithName:@"CICopyMachineTransition"];
    [filter setDefaults];
    [filter setValue:targetImage forKey:@"inputTargetImage"];
    [filter setValue:extent forKey:@"inputExtent"];
    [filter setValue:[CIColor colorWithCGColor:color.CGColor] forKey:@"inputColor"];
    [filter setValue:@(time) forKey:@"inputTime"];
    [filter setValue:@(angle) forKey:@"inputAngle"];
    [filter setValue:@(width) forKey:@"inputWidth"];
    [filter setValue:@(opacity) forKey:@"inputOpacity"];
    return filter;
}

+ (CIFilter *)filterDisintegrateWithMaskTransitionWithTargetImage:(CIImage *)targetImage
                                                        maskImage:(CIImage *)maskImage
                                                             time:(CGFloat)time
                                                     shadowRadius:(CGFloat)shadowRadius
                                                    shadowDensity:(CGFloat)shadowDensity
                                                     shadowOffset:(CGPoint)shadowOffset
{
    CIFilter *filter = [CIFilter filterWithName:@"CIDisintegrateWithMaskTransition"];
    [filter setDefaults];
    [filter setValue:targetImage forKey:@"inputTargetImage"];
    [filter setValue:maskImage forKey:@"inputMaskImage"];
    [filter setValue:@(time) forKey:@"inputTime"];
    [filter setValue:@(shadowRadius) forKey:@"inputShadowRadius"];
    [filter setValue:@(shadowDensity) forKey:@"inputShadowDensity"];
    [filter setValue:[CIVector vectorWithCGPoint:shadowOffset] forKey:@"inputShadowOffset"];
    return filter;
}

+ (CIFilter *)filterDissolveTransitionWithTargetImage:(CIImage *)targetImage time:(CGFloat)time
{
    CIFilter *filter = [CIFilter filterWithName:@"CIDissolveTransition"];
    [filter setDefaults];
    [filter setValue:targetImage forKey:@"inputTargetImage"];
    [filter setValue:@(time) forKey:@"inputTime"];
    return filter;
}

+ (CIFilter *)filterFlashTransitionWithTargetImage:(CIImage *)targetImage
                                            center:(CGPoint)center
                                            extent:(CIVector *)extent
                                             color:(UIColor *)color
                                              time:(CGFloat)time
                                maxStriationRadius:(CGFloat)maxStriationRadius
                                 striationStrength:(CGFloat)striationStrength
                                 striationContrast:(CGFloat)striationContrast
                                inputFadeThreshold:(CGFloat)inputFadeThreshold
{
    CIFilter *filter = [CIFilter filterWithName:@"CIFlashTransition"];
    [filter setDefaults];
    [filter setValue:targetImage forKey:@"inputTargetImage"];
    [filter setValue:[CIVector vectorWithCGPoint:center] forKey:@"inputCenter"];
    [filter setValue:extent forKey:@"inputExtent"];
    [filter setValue:[CIColor colorWithCGColor:color.CGColor] forKey:@"inputColor"];
    [filter setValue:@(time) forKey:@"inputTime"];
    [filter setValue:@(maxStriationRadius) forKey:@"inputMaxStriationRadius"];
    [filter setValue:@(striationStrength) forKey:@"inputStriationStrength"];
    [filter setValue:@(striationContrast) forKey:@"inputStriationContrast"];
    [filter setValue:@(inputFadeThreshold) forKey:@"inputFadeThreshold"];
    return filter;
}

+ (CIFilter *)filterModTransitionWithTargetImage:(CIImage *)targetImage
                                          center:(CGPoint)center
                                           color:(UIColor *)color
                                            time:(CGFloat)time
                                           angle:(CGFloat)angle
                                          radius:(CGFloat)radius
                                     compression:(CGFloat)compression
{
    CIFilter *filter = [CIFilter filterWithName:@"CIModTransition"];
    [filter setDefaults];
    [filter setValue:targetImage forKey:@"inputTargetImage"];
    [filter setValue:[CIVector vectorWithCGPoint:center] forKey:@"inputCenter"];
    [filter setValue:[CIColor colorWithCGColor:color.CGColor] forKey:@"inputColor"];
    [filter setValue:@(time) forKey:@"inputTime"];
    [filter setValue:@(angle) forKey:@"inputAngle"];
    [filter setValue:@(radius) forKey:@"inputRadius"];
    [filter setValue:@(compression) forKey:@"inputCompression"];
    return filter;
}

+ (CIFilter *)filterSwipeTransitionWithTargetImage:(CIImage *)targetImage
                                            extent:(CIVector *)extent
                                             color:(UIColor *)color
                                              time:(CGFloat)time
                                             angle:(CGFloat)angle
                                             width:(CGFloat)width
                                           opacity:(CGFloat)opacity
{
    CIFilter *filter = [CIFilter filterWithName:@"CISwipeTransition"];
    [filter setDefaults];
    [filter setValue:targetImage forKey:@"inputTargetImage"];
    [filter setValue:extent forKey:@"inputExtent"];
    [filter setValue:[CIColor colorWithCGColor:color.CGColor] forKey:@"inputColor"];
    [filter setValue:@(time) forKey:@"inputTime"];
    [filter setValue:@(angle) forKey:@"inputAngle"];
    [filter setValue:@(width) forKey:@"inputWidth"];
    [filter setValue:@(opacity) forKey:@"inputOpacity"];
    return filter;
}


@end
