//
//  CIFilter+HTCICategoryCompositeOperation.m
//  HTCoreImageDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



//

#import "CIFilter+HTCICategoryCompositeOperation.h"

@implementation CIFilter (HTCICategoryCompositeOperation)

+ (CIFilter *)filterAdditionCompositingWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *additionCompositingFilter = [CIFilter filterWithName:@"CIAdditionCompositing"];
    [additionCompositingFilter setDefaults];
    [additionCompositingFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return additionCompositingFilter;
}

+ (CIFilter *)filterColorBlendModeWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *colorBlendFilter = [CIFilter filterWithName:@"CIColorBlendMode"];
    [colorBlendFilter setDefaults];
    [colorBlendFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return colorBlendFilter;
}

+ (CIFilter *)filterColorBurnBlendModeWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *colorBurnBlendFilter = [CIFilter filterWithName:@"CIColorBurnBlendMode"];
    [colorBurnBlendFilter setDefaults];
    [colorBurnBlendFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return colorBurnBlendFilter;
}

+ (CIFilter *)filterColorDodgeBlendModeWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *colorDodgeBlendFilter = [CIFilter filterWithName:@"CIColorDodgeBlendMode"];
    [colorDodgeBlendFilter setDefaults];
    [colorDodgeBlendFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return colorDodgeBlendFilter;
}

+ (CIFilter *)filterDarkenBlendModeWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *darkenBlendFilter = [CIFilter filterWithName:@"CIDarkenBlendMode"];
    [darkenBlendFilter setDefaults];
    [darkenBlendFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return darkenBlendFilter;
}

+ (CIFilter *)filterDifferenceBlendModeWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *differenceBlendFilter = [CIFilter filterWithName:@"CIDifferenceBlendMode"];
    [differenceBlendFilter setDefaults];
    [differenceBlendFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return differenceBlendFilter;
}

+ (CIFilter *)filterExclusionBlendModeWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *exclusionBlendFilter = [CIFilter filterWithName:@"CIExclusionBlendMode"];
    [exclusionBlendFilter setDefaults];
    [exclusionBlendFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return exclusionBlendFilter;
}

+ (CIFilter *)filterHardLightBlendModeWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *hardLightBlendFilter = [CIFilter filterWithName:@"CIHardLightBlendMode"];
    [hardLightBlendFilter setDefaults];
    [hardLightBlendFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return hardLightBlendFilter;
}

+ (CIFilter *)filterHueBlendModeWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *hueBlendFilter = [CIFilter filterWithName:@"CIHueBlendMode"];
    [hueBlendFilter setDefaults];
    [hueBlendFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return hueBlendFilter;
}

+ (CIFilter *)filterLightenBlendModeWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *lightenBlendFilter = [CIFilter filterWithName:@"CILightenBlendMode"];
    [lightenBlendFilter setDefaults];
    [lightenBlendFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return lightenBlendFilter;
}

+ (CIFilter *)filterLuminosityBlendModeWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *luminosityBlendFilter = [CIFilter filterWithName:@"CILuminosityBlendMode"];
    [luminosityBlendFilter setDefaults];
    [luminosityBlendFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return luminosityBlendFilter;
}

+ (CIFilter *)filterMaximumCompositingWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *maximumCompositingFilter = [CIFilter filterWithName:@"CIMaximumCompositing"];
    [maximumCompositingFilter setDefaults];
    [maximumCompositingFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return maximumCompositingFilter;
}

+ (CIFilter *)filterMinimumCompositingWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *minimumCompositingFilter = [CIFilter filterWithName:@"CIMinimumCompositing"];
    [minimumCompositingFilter setDefaults];
    [minimumCompositingFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return minimumCompositingFilter;
}

+ (CIFilter *)filterMultiplyBlendModeWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *multiplyBlendFilter = [CIFilter filterWithName:@"CIMultiplyBlendMode"];
    [multiplyBlendFilter setDefaults];
    [multiplyBlendFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return multiplyBlendFilter;
}

+ (CIFilter *)filterMultiplyCompositingWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *multiplyCompositingFilter = [CIFilter filterWithName:@"CIMultiplyCompositing"];
    [multiplyCompositingFilter setDefaults];
    [multiplyCompositingFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return multiplyCompositingFilter;
}

+ (CIFilter *)filterOverlayBlendModeWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *overlayBlendFilter = [CIFilter filterWithName:@"CIOverlayBlendMode"];
    [overlayBlendFilter setDefaults];
    [overlayBlendFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return overlayBlendFilter;
}

+ (CIFilter *)filterSaturationBlendModeWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *saturationBlendFilter = [CIFilter filterWithName:@"CISaturationBlendMode"];
    [saturationBlendFilter setDefaults];
    [saturationBlendFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return saturationBlendFilter;
}

+ (CIFilter *)filterScreenBlendModeWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *screenBlendFilter = [CIFilter filterWithName:@"CIScreenBlendMode"];
    [screenBlendFilter setDefaults];
    [screenBlendFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return screenBlendFilter;
}

+ (CIFilter *)filterSoftLightBlendModeWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *softLightBlendFilter = [CIFilter filterWithName:@"CISoftLightBlendMode"];
    [softLightBlendFilter setDefaults];
    [softLightBlendFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return softLightBlendFilter;
}

+ (CIFilter *)filterSourceAtopCompositingWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *sourceAtopCompositingFilter = [CIFilter filterWithName:@"CISourceAtopCompositing"];
    [sourceAtopCompositingFilter setDefaults];
    [sourceAtopCompositingFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return sourceAtopCompositingFilter;
}

+ (CIFilter *)filterSourceInCompositingWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *sourceInCompositingFilter = [CIFilter filterWithName:@"CISourceInCompositing"];
    [sourceInCompositingFilter setDefaults];
    [sourceInCompositingFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return sourceInCompositingFilter;
}

+ (CIFilter *)filterSourceOutCompositingWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *sourceOutCompositingFilter = [CIFilter filterWithName:@"CISourceOutCompositing"];
    [sourceOutCompositingFilter setDefaults];
    [sourceOutCompositingFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return sourceOutCompositingFilter;
}

+ (CIFilter *)filterSourceOverCompositingWithBackgroundImage:(CIImage *)backgroundImage
{
    CIFilter *sourceOverCompositingFilter = [CIFilter filterWithName:@"CISourceOverCompositing"];
    [sourceOverCompositingFilter setDefaults];
    [sourceOverCompositingFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    return sourceOverCompositingFilter;
}


@end
