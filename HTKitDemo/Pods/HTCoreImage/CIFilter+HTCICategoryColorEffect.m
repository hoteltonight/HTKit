//
//  CIFilter+HTCICategoryColorEffect.m
//  HTCoreImageDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



//

#import "CIFilter+HTCICategoryColorEffect.h"

@implementation CIFilter (HTCICategoryColorEffect)

+ (CIFilter *)filterColorCubeWithDimension:(NSUInteger)dimension cubeData:(NSData *)cubeData
{
    CIFilter *colorCubeFilter = [CIFilter filterWithName:@"CIColorCube"];
    [colorCubeFilter setDefaults];
    [colorCubeFilter setValue:@(dimension) forKey:@"inputCubeDimension"];
    [colorCubeFilter setValue:cubeData forKey:@"inputCubeData"];
    return colorCubeFilter;
}

+ (CIFilter *)filterColorInvert
{
    CIFilter *colorInvertFilter = [CIFilter filterWithName:@"CIColorInvert"];
    [colorInvertFilter setDefaults];
    return colorInvertFilter;
}

+ (CIFilter *)filterColorMapWithGradientImage:(CIImage *)gradientImage
{
    CIFilter *colorMapFilter = [CIFilter filterWithName:@"CIColorMap"];
    [colorMapFilter setDefaults];
    [colorMapFilter setValue:gradientImage forKey:@"inputGradientImage"];
    return colorMapFilter;
}

+ (CIFilter *)filterColorMonochromeWithColor:(UIColor *)color intensity:(CGFloat)intensity
{
    CIFilter *monochromeFilter = [CIFilter filterWithName:@"CIColorMonochrome"];
    [monochromeFilter setDefaults];
    [monochromeFilter setValue:[CIColor colorWithCGColor:color.CGColor] forKey:@"inputColor"];
    [monochromeFilter setValue:@(intensity) forKey:@"inputIntensity"];
    return monochromeFilter;
}

+ (CIFilter *)filterPosterizeWithLevels:(CGFloat)levels
{
    CIFilter *posterizeFilter = [CIFilter filterWithName:@"CIColorPosterize"];
    [posterizeFilter setDefaults];
    [posterizeFilter setValue:@(levels) forKey:@"inputLevels"];
    return posterizeFilter;
}

+ (CIFilter *)filterFalseColorWithColor0:(UIColor *)color0 color1:(UIColor *)color1
{
    CIFilter *falseColorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    [falseColorFilter setDefaults];
    [falseColorFilter setValue:[CIColor colorWithCGColor:color0.CGColor] forKey:@"inputColor0"];
    [falseColorFilter setValue:[CIColor colorWithCGColor:color1.CGColor] forKey:@"inputColor1"];
    return falseColorFilter;
}

+ (CIFilter *)filterMaskToAlpha
{
    CIFilter *maskToAlphaFilter = [CIFilter filterWithName:@"CIMaskToAlpha"];
    [maskToAlphaFilter setDefaults];
    return maskToAlphaFilter;
}

+ (CIFilter *)filterMaximumComponent
{
    CIFilter *maximumComponentFilter = [CIFilter filterWithName:@"CIMaximumComponent"];
    [maximumComponentFilter setDefaults];
    return maximumComponentFilter;
}

+ (CIFilter *)filterMinimumComponent
{
    CIFilter *minimumComponentFilter = [CIFilter filterWithName:@"CIMinimumComponent"];
    [minimumComponentFilter setDefaults];
    return minimumComponentFilter;
}

+ (CIFilter *)filterSepiaToneWithIntensity:(CGFloat)intensity
{
    CIFilter *sepiaToneFilter = [CIFilter filterWithName:@"CISepiaTone"];
    [sepiaToneFilter setDefaults];
    [sepiaToneFilter setValue:@(intensity) forKey:@"inputIntensity"];
    return sepiaToneFilter;
}

+ (CIFilter *)filterVignetteWithRadius:(CGFloat)radius intensity:(CGFloat)intensity
{
    CIFilter *vignetteFilter = [CIFilter filterWithName:@"CIVignette"];
    [vignetteFilter setDefaults];
    [vignetteFilter setValue:@(radius) forKey:@"inputRadius"];
    [vignetteFilter setValue:@(intensity) forKey:@"inputIntensity"];
    return vignetteFilter;
}


@end
