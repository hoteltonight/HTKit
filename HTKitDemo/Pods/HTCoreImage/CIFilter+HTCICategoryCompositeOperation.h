//
//  CIFilter+HTCICategoryCompositeOperation.h
//  HTCoreImageDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



//

#import <CoreImage/CoreImage.h>

@interface CIFilter (HTCICategoryCompositeOperation)

+ (CIFilter *)filterAdditionCompositingWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterColorBlendModeWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterColorBurnBlendModeWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterColorDodgeBlendModeWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterDarkenBlendModeWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterDifferenceBlendModeWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterExclusionBlendModeWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterHardLightBlendModeWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterHueBlendModeWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterLightenBlendModeWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterLuminosityBlendModeWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterMaximumCompositingWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterMinimumCompositingWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterMultiplyBlendModeWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterMultiplyCompositingWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterOverlayBlendModeWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterSaturationBlendModeWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterScreenBlendModeWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterSoftLightBlendModeWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterSourceAtopCompositingWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterSourceInCompositingWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterSourceOutCompositingWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterSourceOverCompositingWithBackgroundImage:(CIImage *)backgroundImage NS_AVAILABLE_IOS(5_0);

@end
