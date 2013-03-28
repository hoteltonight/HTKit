//
//  MSCachedAsyncViewDrawing.m
//  MindSnacks
//
//  Created by Javier Soto on 11/8/12.
//
//

// Modified by Jacob Jennings

#import "MSCachedAsyncViewDrawing.h"

@interface MSCachedAsyncViewDrawing ()

@property (nonatomic, strong) NSCache *cache;

@property (nonatomic, strong) NSOperationQueue *operationQueue;

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
        self.operationQueue = _sharedOperationQueue;
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
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
        
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
        
        heapDrawBlock(rectToDraw, context);
        
        if (operation.isCancelled)
        {
            CGColorSpaceRelease(colorSpace);
            CGContextRelease(context);
            return;
        }
        
        if (operation.isCancelled)
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
        CFRelease(imageRef);
        
        [self.cache setObject:resultImage forKey:cacheKey];
        
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

@end