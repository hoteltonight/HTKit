//
//  CIFilter+HTCICategoryStylize.h
//  HTCoreImageDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



//

#import <CoreImage/CoreImage.h>

@interface CIFilter (HTCICategoryStylize)

// osx only
// CIComicEffect
// CICrystallize
// CIDepthOfField
// CIEdges
// CIEdgeWork
// CIHeightFieldFromMask
// CIHexagonalPixellate
// CILineOverlay
// CIPointillize
// CIShadedMaterial
// CISpotColor
// CISpotLight

+ (CIFilter *)filterBlendWithMaskWithBackgroundImage:(CIImage *)backgroundImage
                                           maskImage:(CIImage *)maskImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterBloomWithRadius:(CGFloat)radius
                          intensity:(CGFloat)intensity // 1.0 default
                                    NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterGloomWithRadius:(CGFloat)radius
                          intensity:(CGFloat)intensity // 1.0 default
                                    NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterHighlightShadowAdjustWithHighlightAmount:(CGFloat)highlightAmount // default 1.0
                                                shadowAmount:(CGFloat)shadowAmount NS_AVAILABLE_IOS(5_0);

+ (CIFilter *)filterPixellateWithCenter:(CGPoint)center
                                  scale:(CGFloat)scale // 8.0 default
                                        NS_AVAILABLE_IOS(6_0);

@end
