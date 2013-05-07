//
//  UIImage+HTSave.m
//  HotelTonight
//
//  Created by Jacob Jennings on 12/19/12.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "UIImage+HTSave.h"

@implementation UIImage (HTSave)

static NSDateFormatter *dateFormatter;
- (void)saveToDocumentDirectory
{
    [self saveToDocumentDirectoryWithFileNamePrefix:@"Image_"];
}

- (void)saveToDocumentDirectoryWithFileNamePrefix:(NSString *)fileNamePrefix;
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"Y-m-d-H-M-S-A";
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = UIImagePNGRepresentation(self);
        NSString *fileName = [NSString stringWithFormat:@"%@%@.png", fileNamePrefix, [dateFormatter stringFromDate:[NSDate date]]];
        NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
                               stringByAppendingPathComponent:fileName];
        [imageData writeToFile:imagePath atomically:YES];
    });
}

@end
