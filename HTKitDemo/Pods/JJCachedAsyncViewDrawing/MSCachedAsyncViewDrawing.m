//
//  MSCachedAsyncViewDrawing.m
//  MindSnacks
//
//  Created by Javier Soto on 11/8/12.
//
//

// Modified by Jacob Jennings

#import <CoreGraphics/CoreGraphics.h>
#import "MSCachedAsyncViewDrawing.h"

//#define MSCachedAsyncViewDrawingDebug 1

@interface MSCachedAsyncViewDrawing () <NSCacheDelegate>

@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, assign) NSUInteger numberOfImagesInCache;

@end

@interface _MSViewDrawingOperation : NSBlockOperation

@property (nonatomic, strong) UIImage *resultImage;

+ (_MSViewDrawingOperation *)viewDrawingBlockOperationWithBlock:(void (^)(_MSViewDrawingOperation *))block;

@end

typedef void (^MSCachedAsyncViewDrawingOperationBlock)(_MSViewDrawingOperation *operation);

@implementation _MSViewDrawingOperation

+ (_MSViewDrawingOperation *)viewDrawingBlockOperationWithBlock:(MSCachedAsyncViewDrawingOperationBlock)operationBlock
{
    _MSViewDrawingOperation *operation = [[self alloc] init];
    operation.threadPriority = 0.5;
    __unsafe_unretained _MSViewDrawingOperation *weakOperation = operation;
    
    [operation addExecutionBlock:^{
        operationBlock(weakOperation);
    }];
    
    return operation;
}

@end

@implementation MSCachedAsyncViewDrawing

static NSOperationQueue *_sharedOperationQueue = nil;

+ (void)initialize
{
    if ([self class] == [MSCachedAsyncViewDrawing class])
    {
        _sharedOperationQueue = [[NSOperationQueue alloc] init];
        [_sharedOperationQueue setMaxConcurrentOperationCount:10];
        _sharedOperationQueue.name = @"com.mindsnacks.view_drawing.queue";
    }
}

+ (MSCachedAsyncViewDrawing *)sharedInstance
{
    static MSCachedAsyncViewDrawing *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (id)init
{
    if ((self = [super init]))
    {
        self.cache = [[NSCache alloc] init];
        self.cache.name = @"com.mindsnacks.view_drawing.cache";
        self.cache.delegate = self;
        self.operationQueue = _sharedOperationQueue;
        self.numberOfImagesInCache = 0;
        self.totalCostLimitInMegabytes = 50;
    }
    
    return self;
}

- (NSOperation *)drawViewSynchronous:(BOOL)synchronous
                        withCacheKey:(NSString *)cacheKey
                                size:(CGSize)imageSize
                     backgroundColor:(UIColor *)backgroundColor
                           drawBlock:(MSCachedAsyncViewDrawingDrawBlock)drawBlock
                     completionBlock:(MSCachedAsyncViewDrawingCompletionBlock)completionBlock;
{
    return [self drawViewSynchronous:synchronous
                        withCacheKey:cacheKey
                                size:imageSize
                     backgroundColor:backgroundColor
                       capEdgeInsets:UIEdgeInsetsZero
                           drawBlock:drawBlock
                     completionBlock:completionBlock];
}

- (NSOperation *)drawViewSynchronous:(BOOL)synchronous
                        withCacheKey:(NSString *)cacheKey
                                size:(CGSize)imageSize
                     backgroundColor:(UIColor *)backgroundColor
                       capEdgeInsets:(UIEdgeInsets)capEdgeInsets
                           drawBlock:(MSCachedAsyncViewDrawingDrawBlock)drawBlock
                     completionBlock:(MSCachedAsyncViewDrawingCompletionBlock)completionBlock;

{
    UIImage *cachedImage = [self.cache objectForKey:cacheKey];

    if (cachedImage)
    {
        completionBlock(cachedImage);
        return nil;
    }

    MSCachedAsyncViewDrawingDrawBlock heapDrawBlock = [drawBlock copy];
    MSCachedAsyncViewDrawingCompletionBlock heapCompletionBlock = [completionBlock copy];
    
    MSCachedAsyncViewDrawingOperationBlock operationBlock = ^(_MSViewDrawingOperation *operation) {
        if (operation.isCancelled)
        {
            return;
        }
        
        CGFloat contentsScale = [[UIScreen mainScreen] scale];
        CGSize size = CGSizeMake(imageSize.width * contentsScale, imageSize.height * contentsScale);

        CGColorSpaceRef colorSpace =  CGColorSpaceCreateDeviceRGB();;
        size_t components = 4;
        size_t width = size.width;
        size_t height = size.height;
        size_t bitsPerComponent = 8;
        size_t bytesPerRow = (width * bitsPerComponent * components + 7)/8;
        size_t dataLength = bytesPerRow * height;

        CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);

        CGContextScaleCTM(context, contentsScale, contentsScale);
        CGAffineTransform flipVertical = CGAffineTransformTranslate(CGAffineTransformMakeScale(1, -1), 0, -imageSize.height);
        CGContextConcatCTM(context, flipVertical);
        
        if (operation.isCancelled)
        {
            CGColorSpaceRelease(colorSpace);
            CGContextRelease(context);
            return;
        }
        
        CGRect rectToDraw = (CGRect){.origin = CGPointZero, .size = imageSize};
        
        BOOL shouldDrawBackgroundColor = ![backgroundColor isEqual:[UIColor clearColor]];
        
        if (shouldDrawBackgroundColor)
        {
            CGContextSaveGState(context);
            {
                CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
                CGContextFillRect(context, rectToDraw);
            }
            CGContextRestoreGState(context);
        }
        
        BOOL shouldContinue = heapDrawBlock(rectToDraw, context);
        
        if (operation.isCancelled || !shouldContinue)
        {
            CGColorSpaceRelease(colorSpace);
            CGContextRelease(context);
            return;
        }
        
        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        UIImage *resultImage = [UIImage imageWithCGImage:imageRef scale:contentsScale orientation:UIImageOrientationUp];
        
        if (!UIEdgeInsetsEqualToEdgeInsets(capEdgeInsets, UIEdgeInsetsZero))
        {
            resultImage = [resultImage resizableImageWithCapInsets:capEdgeInsets];
        }
        
        CGColorSpaceRelease(colorSpace);
        CGContextRelease(context);
        CGImageRelease(imageRef);

        [self.cache setObject:resultImage forKey:cacheKey cost:dataLength];
        self.numberOfImagesInCache++;

        operation.resultImage = resultImage;
    };
    
    _MSViewDrawingOperation *operation = [_MSViewDrawingOperation viewDrawingBlockOperationWithBlock:[operationBlock copy]];
    
    __strong __block _MSViewDrawingOperation *_operation = operation;
    
    operation.completionBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            heapCompletionBlock(_operation.resultImage);
            _operation = nil;
        });
    };
    
    if (synchronous)
    {
        operationBlock(operation);
        completionBlock(operation.resultImage);
        return nil;
    }
    else
    {
        [self.operationQueue addOperation:operation];
        return operation;
    }
}

#pragma mark - Aux

- (BOOL)colorIsOpaque:(UIColor *)color
{
    CGFloat alpha = -1.0f;
    [color getRed:NULL green:NULL blue:NULL alpha:&alpha];
    
    BOOL wrongColorSpace = (alpha == -1.0f);
    if (wrongColorSpace)
    {
        [color getWhite:NULL alpha:&alpha];
    }
    
    return (alpha == 1.0f);
}

#pragma mark - Cache Delegate

- (void)cache:(NSCache *)cache willEvictObject:(id)obj
{
#if MSCachedAsyncViewDrawingDebug
    UIImage *image = (UIImage *)obj;
    NSLog(@"Evicted image of size %@! Remaining images: %u", NSStringFromCGSize(image.size), self.numberOfImagesInCache);
    self.numberOfImagesInCache--;
#endif
}

- (void)setTotalCostLimitInMegabytes:(CGFloat)totalCostLimitInMegabytes
{
    _totalCostLimitInMegabytes = totalCostLimitInMegabytes;
    self.cache.totalCostLimit = self.totalCostLimitInMegabytes * 1024 * 1024; // megabytes * mb/kb * kb/b
}

@end
