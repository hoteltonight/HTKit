//
//  CIFilter+HTCICategoryGenerator.h
//  HTCoreImageDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <CoreImage/CoreImage.h>

@interface CIFilter (HTCICategoryGenerator)

// OSX oly:
// CILenticularHaloGenerator
// CISunbeamsGenerator

+ (CIFilter *)filterCheckerboardGeneratorWithCenter:(CGPoint)center
                                             color0:(UIColor *)color0
                                             color1:(UIColor *)color1
                                              width:(CGFloat)width
                                          sharpness:(CGFloat)sharpness NS_AVAILABLE_IOS(6_0); // default 1.0

+ (CIFilter *)filterConstantColorGeneratorWithColor:(UIColor *)color NS_AVAILABLE_IOS(5_0);

+ (CIFilter *)filterRandomGenerator NS_AVAILABLE_IOS(6_0); // white noise

+ (CIFilter *)filterStarShineGeneratorWithCenter:(CGPoint)center        // default: 150,150
                                           color:(UIColor *)color
                                          radius:(CGFloat)radius        // 50
                                      crossScale:(CGFloat)crossScale    // 15
                                      crossAngle:(CGFloat)crossAngle    // 0.6
                                    crossOpacity:(CGFloat)crossOpacity  // -2
                                      crossWidth:(CGFloat)crossWidth    // 2.5
                                         epsilon:(CGFloat)epsilon       // -2
                                                 NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterStripesGeneratorWithCenter:(CGPoint)center
                                        color0:(UIColor *)color0
                                        color1:(UIColor *)color1
                                         width:(CGFloat)width
                                     sharpness:(CGFloat)sharpness // default: 1.0
                                               NS_AVAILABLE_IOS(6_0);

@end
