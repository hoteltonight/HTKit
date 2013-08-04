//
//  CIFilter+HTCICategoryHalftoneEffect.h
//  HTCoreImageDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



//

#import <CoreImage/CoreImage.h>

// CICMYKHalftone

@interface CIFilter (HTCICategoryHalftoneEffect)

+ (CIFilter *)filterCircularScreenWithCenter:(CGPoint)center
                                       width:(CGFloat)width
                                   sharpness:(CGFloat)sharpness // default 0.7
                                             NS_AVAILABLE_IOS(6_0);
+ (CIFilter *)filterDotScreenWithCenter:(CGPoint)center
                                  angle:(CGFloat)angle
                                  width:(CGFloat)width
                              sharpness:(CGFloat)sharpness // default 0.7
                                        NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterHatchedScreenWithCenter:(CGPoint)center
                                      angle:(CGFloat)angle
                                      width:(CGFloat)width
                                  sharpness:(CGFloat)sharpness // default 0.7
                                            NS_AVAILABLE_IOS(6_0);

+ (CIFilter *)filterLineScreenWithCenter:(CGPoint)center
                                   angle:(CGFloat)angle
                                   width:(CGFloat)width
                               sharpness:(CGFloat)sharpness // default 0.7
                                         NS_AVAILABLE_IOS(6_0);


@end
