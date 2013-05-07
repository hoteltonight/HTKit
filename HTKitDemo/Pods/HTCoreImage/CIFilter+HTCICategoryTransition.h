//
//  CIFilter+HTCICategoryTransition.h
//  HTCoreImageDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



//

#import <CoreImage/CoreImage.h>

@interface CIFilter (HTCICategoryTransition)

// osx only
// CIPageCurlTransition
// CIRippleTransition

+ (CIFilter *)filterBarsSwipeTransitionWithTargetImage:(CIImage *)targetImage
                                                 angle:(CGFloat)angle // default π
                                                 width:(CGFloat)width
                                             barOffset:(CGFloat)barOffset
                                                  time:(CGFloat)time NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterCopyMachineTransitionWithTargetImage:(CIImage *)targetImage
                                                  extent:(CIVector *)extent
                                                   color:(UIColor *)color
                                                    time:(CGFloat)time
                                                   angle:(CGFloat)angle
                                                   width:(CGFloat)width
                                                 opacity:(CGFloat)opacity NS_AVAILABLE_IOS(6_0); // default 1.3 ???

+ (CIFilter *)filterDisintegrateWithMaskTransitionWithTargetImage:(CIImage *)targetImage
                                                        maskImage:(CIImage *)maskImage
                                                             time:(CGFloat)time
                                                     shadowRadius:(CGFloat)shadowRadius
                                                    shadowDensity:(CGFloat)shadowDensity
                                                     shadowOffset:(CGPoint)shadowOffset NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterDissolveTransitionWithTargetImage:(CIImage *)targetImage
                                                 time:(CGFloat)time NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterFlashTransitionWithTargetImage:(CIImage *)targetImage
                                            center:(CGPoint)center
                                            extent:(CIVector *)extent
                                             color:(UIColor *)color
                                              time:(CGFloat)time
                                maxStriationRadius:(CGFloat)maxStriationRadius  // default 2.58
                                 striationStrength:(CGFloat)striationStrength   // 0.5
                                 striationContrast:(CGFloat)striationContrast   // 1.38
                                inputFadeThreshold:(CGFloat)inputFadeThreshold  // 0.85
                                                   NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterModTransitionWithTargetImage:(CIImage *)targetImage
                                          center:(CGPoint)center
                                           color:(UIColor *)color
                                            time:(CGFloat)time
                                           angle:(CGFloat)angle // 2.0
                                          radius:(CGFloat)radius // 150
                                     compression:(CGFloat)compression // 300
                                             NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterSwipeTransitionWithTargetImage:(CIImage *)targetImage
                                            extent:(CIVector *)extent
                                             color:(UIColor *)color
                                              time:(CGFloat)time
                                             angle:(CGFloat)angle // 2.0
                                             width:(CGFloat)width
                                           opacity:(CGFloat)opacity NS_AVAILABLE_IOS(6_0);
@end
