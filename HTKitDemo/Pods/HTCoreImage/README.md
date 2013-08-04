HTCoreImage
===========

HTCoreImage is a collection of convenience categories for Core Image.  There are convenience constructors for __every filter__, annotated with NS_AVAILABLE_SINCE() macros so you know what's in iOS 5 vs iOS 6.

#### Example:  Let's increase the contrast on an image and colorize it blue:

```objc
    UIImage *sourceUIImage = [UIImage imageNamed:@"asdf"];

    [[[sourceUIImage toCIImage] imageByApplyingFilters:@[
      [CIFilter filterColorControlsSaturation:1 brightness:1 contrast:2],
      [CIFilter filterColorMatrixWithRed:0.5 green:0.5 blue:1 alpha:1]]]
     processToUIImageCompletion:^(UIImage *uiImage) {
        NSLog(@"%@", uiImage);
    }];
```

#### Here's the same thing with stock Core Image for comparison:

```objc
    UIImage *sourceUIImage = [UIImage imageNamed:@"asdf"];

    CIImage *sourceCIImage = [CIImage imageWithCGImage:sourceUIImage.CGImage];

    CIFilter *colorControlsFilter = [CIFilter filterWithName:@"CIColorControls"];
    [colorControlsFilter setDefaults];
    [colorControlsFilter setValue:@(1) forKey:@"inputSaturation"];
    [colorControlsFilter setValue:@(1) forKey:@"inputBrightness"];
    [colorControlsFilter setValue:@(2) forKey:@"inputContrast"];
    [colorControlsFilter setInputCIImage:sourceCIImage];
    
    CIFilter *colorMatrixFilter = [CIFilter filterWithName:@"CIColorMatrix"];
    [colorMatrixFilter setDefaults];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0.5 Y:0 Z:0 W:0]
                         forKey:@"inputRVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:0.5 Z:0 W:0]
                         forKey:@"inputGVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:0 Z:1 W:0]
                         forKey:@"inputBVector"];
    [colorMatrixFilter setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:1]
                         forKey:@"inputAVector"];
    [colorMatrixFilter setInputCIImage:[colorControlsFilter outputImage]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       CIContext *ciContext = [CIContext contextWithOptions:@{ kCIContextUseSoftwareRenderer : (id)kCFBooleanFalse }];
                       CGImageRef resultCGImage = [ciContext createCGImage:[colorMatrixFilter outputImage] fromRect:[[colorMatrixFilter outputImage] extent]];
                       UIImage *resultUIImage = [UIImage imageWithCGImage:resultCGImage scale:sourceUIImage.scale orientation:sourceUIImage.imageOrientation];
                       CGImageRelease(resultCGImage);
                       dispatch_async(dispatch_get_main_queue(), ^
                                      {
                                          NSLog(@"%@", resultUIImage);
                                      });
                   });
```

## Installation

The recommended installation method is cocoapods. Add this line to your Podfile:

    pod 'HTCoreImage'

http://cocoapods.org

## Contributions welcome!

## Use it? Love/hate it?

Tweet the author @jakejennings, and check out HotelTonight's engineering blog: http://engineering.hoteltonight.com

Also, check out HotelTonight's other iOS open source:
* https://github.com/hoteltonight/HTAutocompleteTextField
* https://github.com/hoteltonight/HTRasterView
* https://github.com/hoteltonight/HTKit
* https://github.com/hoteltonight/HTGradientEasing
* https://github.com/hoteltonight/HTDelegateProxy
* https://github.com/hoteltonight/HTCoreImage

