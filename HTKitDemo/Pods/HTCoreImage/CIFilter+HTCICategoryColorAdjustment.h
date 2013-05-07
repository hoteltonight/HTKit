//
//  CIFilter+HTCICategoryColorAdjustment.h
//  HTCoreImageDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



//

#import <CoreImage/CoreImage.h>

@interface CIFilter (HTCICategoryColorAdjustment)

+ (CIFilter *)filterColorControlsSaturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                   contrast:(CGFloat)contrast NS_AVAILABLE_IOS(5_0);

+ (CIFilter *)filterColorMatrixWithAlpha:(CGFloat)alpha NS_AVAILABLE_IOS(5_0);

+ (CIFilter *)filterColorMatrixWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha NS_AVAILABLE_IOS(5_0);

+ (CIFilter *)filterExposureAdjustWithInputEV:(CGFloat)inputEV NS_AVAILABLE_IOS(5_0);

+ (CIFilter *)filterGammaAdjustWithInputPower:(CGFloat)inputPower NS_AVAILABLE_IOS(5_0);

+ (CIFilter *)filterHueAdjustWithInputAngle:(CGFloat)inputAngle NS_AVAILABLE_IOS(5_0);

// Defaults: [6500, 0] and [6500, 0]
+ (CIFilter *)filterTemperatureAndTintWithNeutral:(CGPoint)neutral targetNeutral:(CGPoint)targetNeutral NS_AVAILABLE_IOS(5_0);

+ (CIFilter *)filterToneCurveWithControlPoint0:(CGPoint)point0 point1:(CGPoint)point1 point2:(CGPoint)point2 point3:(CGPoint)point3 NS_AVAILABLE_IOS(5_0);

+ (CIFilter *)filterVibranceWithInputAmount:(CGFloat)inputAmount NS_AVAILABLE_IOS(5_0);

+ (CIFilter *)filterWhitePointAdjustWithInputColor:(UIColor *)inputColor NS_AVAILABLE_IOS(5_0);

@end
