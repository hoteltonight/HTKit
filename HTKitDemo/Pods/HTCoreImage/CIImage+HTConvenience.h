//
// Created by Jacob Jennings on 3/7/13.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>

typedef void(^HTCICGImageCompletionBlock)(CGImageRef cgImage);
typedef void(^HTCIUIImageCompletionBlock)(UIImage *uiImage);

@interface CIImage (HTConvenience)

- (CIImage *)imageByApplyingFilters:(NSArray *)filters;
- (CIImage *)imageByApplyingFilter:(CIFilter *)filter;
- (void)processToCGImageCompletion:(HTCICGImageCompletionBlock)completion;
- (void)processToUIImageCompletion:(HTCIUIImageCompletionBlock)completion;
- (void)processToUIImageWithOrientation:(UIImageOrientation)orientation completion:(HTCIUIImageCompletionBlock)completion;
- (void)processToUIImageWithOrientation:(UIImageOrientation)orientation scale:(CGFloat)scale completion:(HTCIUIImageCompletionBlock)completion;

@end