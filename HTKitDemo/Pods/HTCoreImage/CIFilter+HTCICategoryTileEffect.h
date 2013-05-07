//
//  CIFilter+HTCICategoryTileEffect.h
//  HTCoreImageDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



//

#import <CoreImage/CoreImage.h>

@interface CIFilter (HTCICategoryTileEffect)

// osx only
// CIKaleidoscope
// CIOpTile
// CIParallelogramTile


+ (CIFilter *)filterAffineClampWithTransform:(CGAffineTransform)transform NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterAffineTileWithTransform:(CGAffineTransform)transform NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterEightfoldReflectedTileWithCenter:(CGPoint)center
                                               angle:(CGFloat)angle
                                               width:(CGFloat)width NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterFourfoldReflectedTileWithCenter:(CGPoint)center
                                              angle:(CGFloat)angle // 0 default
                                         acuteAngle:(CGFloat)acuteAngle // π / 2
                                              width:(CGFloat)width NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterFourfoldRotatedTileWithCenter:(CGPoint)center
                                            angle:(CGFloat)angle  // default 0
                                            width:(CGFloat)width NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterFourfoldTranslatedTileWithCenter:(CGPoint)center
                                               angle:(CGFloat)angle // default 0
                                          acuteAngle:(CGFloat)acuteAngle // default π / 2
                                               width:(CGFloat)width NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterGlideReflectedTileWithCenter:(CGPoint)center
                                           angle:(CGFloat)angle  // default 0
                                           width:(CGFloat)width NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterPerspectiveTileWithTopLeft:(CGPoint)topLeft
                                      topRight:(CGPoint)topRight
                                   bottomRight:(CGPoint)bottomRight
                                    bottomLeft:(CGPoint)bottomLeft NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterSixfoldReflectedTileWithCenter:(CGPoint)center
                                             angle:(CGFloat)angle
                                             width:(CGFloat)width NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterSixfoldRotatedTileWithCenter:(CGPoint)center
                                           angle:(CGFloat)angle
                                           width:(CGFloat)width NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterTriangleKaleidoscopeWithPoint:(CGPoint)point // 150,150
                                             size:(CGFloat)size // 700
                                         rotation:(CGFloat)rotation // -0.36
                                            decay:(CGFloat)decay // 0.85
                                                    NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterTriangleTileWithCenter:(CGPoint)center
                                     angle:(CGFloat)angle
                                     width:(CGFloat)width NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)twelvefoldReflectedTileWithCenter:(CGPoint)center
                                          angle:(CGFloat)angle
                                          width:(CGFloat)width NS_AVAILABLE_IOS(6_0);

@end
