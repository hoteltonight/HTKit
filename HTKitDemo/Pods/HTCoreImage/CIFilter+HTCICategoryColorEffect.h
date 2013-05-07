//
//  CIFilter+HTCICategoryColorEffect.h
//  HTCoreImageDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



//

#import <CoreImage/CoreImage.h>

@interface CIFilter (HTCICategoryColorEffect)

+ (CIFilter *)filterColorCubeWithDimension:(NSUInteger)dimension cubeData:(NSData *)cubeData NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterColorInvert NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterColorMapWithGradientImage:(CIImage *)gradientImage NS_AVAILABLE_IOS(6_0);

// intensity default = 1.00
+ (CIFilter *)filterColorMonochromeWithColor:(UIColor *)color intensity:(CGFloat)intensity NS_AVAILABLE_IOS(6_0);

// levels default = 6.00
+ (CIFilter *)filterPosterizeWithLevels:(CGFloat)levels NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterFalseColorWithColor0:(UIColor *)color0 color1:(UIColor *)color1 NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterMaskToAlpha NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterMaximumComponent NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterMinimumComponent NS_AVAILABLE_IOS(6_0);

// intensity default = 1.00
+ (CIFilter *)filterSepiaToneWithIntensity:(CGFloat)intensity NS_AVAILABLE_IOS(5_0);

// radius default = 1, intensity = 0
+ (CIFilter *)filterVignetteWithRadius:(CGFloat)radius intensity:(CGFloat)intensity NS_AVAILABLE_IOS(5_0);

@end
