//
// Created by Jacob Jennings on 3/7/13.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "CIImage+HTConvenience.h"
#import "CIFilter+HTConvenience.h"

@implementation CIImage (HTConvenience)

- (CIImage *)imageByApplyingFilters:(NSArray *)filters;
{
    NSParameterAssert(filters && [filters count]);
    CIImage *ciImage = self;
    for (CIFilter *filter in filters)
    {
        [filter setValue:ciImage forKey:kCIInputImageKey];
        ciImage = [filter valueForKey:kCIOutputImageKey];
    }
    return ciImage;
}

- (CIImage *)imageByApplyingFilter:(CIFilter *)filter;
{
    return [self imageByApplyingFilters:@[filter]];
}

- (void)processToCGImageCompletion:(HTCICGImageCompletionBlock)completion;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        CIContext *ciContext = [CIContext contextWithOptions:@{ kCIContextUseSoftwareRenderer : (id)kCFBooleanFalse }];
        CGImageRef resultCGImage = [ciContext createCGImage:self fromRect:[self extent]];
        dispatch_async(dispatch_get_main_queue(), ^
        {
            completion(resultCGImage);
            CGImageRelease(resultCGImage);
        });
    });
}

- (void)processToUIImageCompletion:(HTCIUIImageCompletionBlock)completion;
{
    [self processToCGImageCompletion:^(CGImageRef cgImage)
    {
        completion([UIImage imageWithCGImage:cgImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]);
    }];
}

- (void)processToUIImageWithOrientation:(UIImageOrientation)orientation completion:(HTCIUIImageCompletionBlock)completion;
{
    [self processToCGImageCompletion:^(CGImageRef cgImage)
    {
        completion([UIImage imageWithCGImage:cgImage scale:[UIScreen mainScreen].scale orientation:orientation]);
    }];
}

- (void)processToUIImageWithOrientation:(UIImageOrientation)orientation scale:(CGFloat)scale completion:(HTCIUIImageCompletionBlock)completion;
{
    [self processToCGImageCompletion:^(CGImageRef cgImage)
    {
        completion([UIImage imageWithCGImage:cgImage scale:scale orientation:orientation]);
    }];
}

@end

