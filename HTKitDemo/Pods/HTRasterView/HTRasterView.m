//
//  HTRasterView.m
//  HotelTonight
//
//  Created by Jacob Jennings on 11/29/12.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <QuartzCore/QuartzCore.h>
#import "HTRasterView.h"
#import "NSObject+HTPropertyHash.h"
#import "MSCachedAsyncViewDrawing.h"
#import "UIView+HTRaster.h"

// Uncommenting this SLOWS THINGS DOWN A LOT and will save all images to disk
//#define HT_DEBUG_SAVEFILES YES

//#define HT_DEBUG_RASTERLOG YES
//#define HT_DEBUG_VERBOSE YES

@interface HTRasterView ()

@property (nonatomic, assign) BOOL implementsShouldRasterize;
@property (nonatomic, assign) BOOL implementsUseMinimumSizeForCaps;
@property (nonatomic, assign) BOOL implementsCapEdgeInsets;
@property (nonatomic, assign) BOOL implementsShadowPath;
@property (atomic, strong) NSOperation *drawingOperation;
@property (atomic, strong) NSString *currentRenderingCacheKey; // For avoiding race conditions while drawsOnMainThread = NO
@property (nonatomic, strong) NSMutableArray *descendantRasterViews;
@property (nonatomic, strong) UIView<HTRasterizableView> *rasterizableViewAsSubview;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HTRasterView
@dynamic image;

- (id)initWithFrame:(CGRect)frame
{
    self = ([super initWithFrame:frame]);
    if (self)
    {
        _kvoEnabled = YES;
        _drawsOnMainThread = YES;
        _descendantRasterViews = [NSMutableArray array];
        _rasterized = YES;
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.rasterizableView)
    {
        [self layoutRasterizableView];
    }
    self.rasterizableViewAsSubview.frame = self.bounds;
    self.imageView.frame = self.bounds;
    [self.imageView layoutIfNeeded];
    
    [self regenerateImage:nil];
    
    if (self.implementsShadowPath)
    {
        self.layer.shadowPath = [self.rasterizableView rasterViewShadowPathForBounds:self.bounds].CGPath;
    }
}

- (void)layoutRasterizableView;
{
    CGSize size = self.bounds.size;
    UIEdgeInsets edgeInsets = [self capEdgeInsets];
    
    if ([self useMinimumCapSize])
    {
#ifdef HT_DEBUG_VERBOSE
        NSLog(@"Using minimum cap size for %@", NSStringFromClass([self.rasterizableView class]));
#endif
        size = CGSizeMake(edgeInsets.left + edgeInsets.right + 1, edgeInsets.top + edgeInsets.bottom + 1);
    }
    
    self.rasterizableView.frame = (CGRect){ .origin = CGPointZero, .size = size };
    [self.rasterizableView layoutSubtreeIfNeeded];
}

- (void)dealloc
{
    [self removeAllObservers];
    _rasterizableView.htRasterImageView = nil;
    self.delegate = nil;
}

#pragma mark - Properties

- (void)setRasterizableView:(UIView<HTRasterizableView> *)rasterizableView
{
    [self removeAllObservers];
    _rasterizableView.htRasterImageView = nil;
    _rasterizableView = rasterizableView;
    if (!rasterizableView)
    {
        return;
    }
    _rasterizableView.htRasterImageView = self;
    
    self.implementsShouldRasterize = [self.rasterizableView respondsToSelector:@selector(shouldRegenerateRasterForKeyPath:change:)];
    self.implementsUseMinimumSizeForCaps = [self.rasterizableView respondsToSelector:@selector(useMinimumFrameForCaps)];
    self.implementsCapEdgeInsets = [self.rasterizableView respondsToSelector:@selector(capEdgeInsets)];
    self.implementsShadowPath = [self.rasterizableView respondsToSelector:@selector(rasterViewShadowPathForBounds:)];
    
    if (self.implementsShadowPath)
    {
        self.layer.shadowRadius = self.rasterizableView.layer.shadowRadius;
        self.layer.shadowOffset = self.rasterizableView.layer.shadowOffset;
        self.layer.shadowColor = self.rasterizableView.layer.shadowColor;
        self.layer.shadowOpacity = self.rasterizableView.layer.shadowOpacity;
    }
    else
    {
        self.layer.shadowOpacity = 0;
    }
    
    for (NSString *propertyName in [rasterizableView keyPathsThatAffectState])
    {
        [rasterizableView addObserver:self forKeyPath:propertyName options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    [self setNeedsLayout];
}

- (void)setRasterized:(BOOL)rasterized
{
    if (_rasterized == rasterized)
    {
        return;
    }
    _rasterized = rasterized;
    if (rasterized)
    {
        [self.rasterizableViewAsSubview removeFromSuperview];
        self.rasterizableView = self.rasterizableViewAsSubview;
        self.rasterizableViewAsSubview = nil;
    }
    else
    {
        self.rasterizableViewAsSubview = self.rasterizableView;
        [self addSubview:self.rasterizableViewAsSubview];
        self.rasterizableView = nil;
        [self setNeedsLayout];
    }
}

- (UIImage *)image
{
    return self.imageView.image;
}

#pragma mark - Private

- (void)removeAllObservers;
{
    for (NSString *propertyName in [self.rasterizableView keyPathsThatAffectState])
    {
        [_rasterizableView removeObserver:self forKeyPath:propertyName];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (!self.kvoEnabled)
    {
        return;
    }
    if (self.implementsShouldRasterize)
    {
        if (![self.rasterizableView shouldRegenerateRasterForKeyPath:keyPath change:change])
        {
            return;
        }
    }
    
    id old = change[NSKeyValueChangeOldKey];
    id new = change[NSKeyValueChangeNewKey];
    if ([new isEqual:old])
    {
        return;
    }
    [self regenerateImage:nil];
}

- (UIEdgeInsets)capEdgeInsets
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    if (self.implementsCapEdgeInsets)
    {
        edgeInsets = [self.rasterizableView capEdgeInsets];
    }
    return edgeInsets;
}

- (BOOL)useMinimumCapSize
{
    return self.implementsUseMinimumSizeForCaps && [self.rasterizableView useMinimumFrameForCaps];
}

- (void)regenerateImage:(HTSARIVVoidBlock)complete
{
#ifdef HT_DEBUG_VERBOSE
    NSLog(@"Potential regenerate %@", NSStringFromClass([self.rasterizableView class]));
#endif
    if (!self.rasterizableView)
    {
        return;
    }
    [self layoutRasterizableView];
    CGSize size = self.rasterizableView.bounds.size;
    if ((size.width < 1 || size.height < 1))
    {
#ifdef HT_DEBUG_VERBOSE
        NSLog(@"Too small %@", NSStringFromClass([self.rasterizableView class]));
#endif
        return;
    }
    __block NSString *cacheKey = [self cacheKey];
    //#ifdef HT_DEBUG_RASTERLOG
    //    NSLog(@"%d Maybe drawing cache instance: %d\n", (int)self, (int)cacheKey);
    //#endif
    __unsafe_unretained HTRasterView *bSelf = self;
    MSCachedAsyncViewDrawingDrawBlock drawBlock = ^(CGRect frame, CGContextRef context)
    {
        if (self.currentRenderingCacheKey != cacheKey)
        {
            return;
        }
        if ([bSelf.delegate respondsToSelector:@selector(rasterViewWillRegenerateImage:)])
        {
            [bSelf.delegate rasterViewWillRegenerateImage:bSelf];
        }
        [bSelf.rasterizableView layoutSubtreeIfNeeded];
        [bSelf.rasterizableView drawRect:frame inContext:context];
        //#ifdef HT_DEBUG_RASTERLOG
        //        NSLog(@"%d Drawing: key instance: %d\n\n", (int)self, (int)cacheKey);
        //#endif
    };
    
    MSCachedAsyncViewDrawingCompletionBlock completionBlock = ^(UIImage *drawnImage)
    {
        if (self.currentRenderingCacheKey != cacheKey)
        {
            //            NSLog(@"NOT USING %d BECAUSE != current %d", (int)cacheKey, (int)self.currentRenderingCacheKey);
            return;
        }
        if (!drawnImage)
        {
            return;
        }
        if (drawnImage != bSelf.imageView.image)
        {
#ifdef HT_DEBUG_RASTERLOG
            NSLog(@"%d Using key instance: %d, Key: \n%@\n\n", (int)self, (int)cacheKey, cacheKey);
#endif
            
            bSelf.imageView.image = drawnImage;
            [self informFirstAncestorRasterImageViewThatWeRegenerated];
        }
        
        if ([bSelf.delegate respondsToSelector:@selector(rasterViewImageLoaded:)])
        {
            [bSelf.delegate rasterViewImageLoaded:bSelf];
        }
        
#ifdef HT_DEBUG_SAVEFILES
        NSString *fileName = [NSString stringWithFormat:@"/%@-%u.jpg", NSStringFromClass([bSelf.rasterizableView class]), [cacheKey hash]];
        NSData *imageData = UIImageJPEGRepresentation(drawnImage, 1);
        NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
                               stringByAppendingPathComponent:fileName];
        [imageData writeToFile:imagePath atomically:YES];
#endif
        
        if (complete) complete();
    };
    
    [self.drawingOperation cancel];
#ifdef HT_DEBUG_VERBOSE
    NSLog(@"actual regen %@ size: %@", NSStringFromClass([self.rasterizableView class]), NSStringFromCGSize(size));
#endif
    if (self.drawsOnMainThread)
    {
        self.currentRenderingCacheKey = cacheKey;
    }
    self.drawingOperation = [[MSCachedAsyncViewDrawing sharedInstance] drawViewSynchronous:self.drawsOnMainThread
                                                                              withCacheKey:cacheKey
                                                                                      size:size
                                                                           backgroundColor:[UIColor clearColor]
                                                                             capEdgeInsets:[self capEdgeInsets]
                                                                                 drawBlock:drawBlock
                                                                           completionBlock:completionBlock];
}

- (void)informFirstAncestorRasterImageViewThatWeRegenerated
{
    [[self firstAncestorRasterizableView].htRasterImageView regenerateImage:nil];
}

- (NSString *)cacheKey
{
#ifdef HT_DEBUG_RASTERLOG
    NSMutableString *cacheString = [[[self.rasterizableView hashStringForKeyPaths:[self.rasterizableView keyPathsThatAffectState]] stringByReplacingOccurrencesOfString:@"\n"
                                                                                                                                                             withString:@" "] mutableCopy];
    
    for (HTRasterView *descendantRasterImageView in self.descendantRasterViews)
    {
        NSString *descendantCacheKey = [[descendantRasterImageView cacheKey] stringByReplacingOccurrencesOfString:@"\n"
                                                                                                       withString:@"\n\t"];
        [cacheString appendFormat:@"\n\t%@", descendantCacheKey];
    }
#else
    NSMutableString *cacheString = [[self.rasterizableView hashStringForKeyPaths:[self.rasterizableView keyPathsThatAffectState]] mutableCopy];
    
    for (HTRasterView *descendantRasterImageView in self.descendantRasterViews)
    {
        [cacheString appendString:[descendantRasterImageView cacheKey]];
    }
#endif
    
    return [cacheString copy];
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [self regenerateImage:nil];
}

#pragma mark - Touch forwarding

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    if (!self.gestureRecognizers || ![self.gestureRecognizers count]) {
        [self.rasterizableView touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{
    if (!self.gestureRecognizers || ![self.gestureRecognizers count]) {
        [self.rasterizableView touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
{
    if (!self.gestureRecognizers || ![self.gestureRecognizers count]) {
        [self.rasterizableView touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
{
    if (!self.gestureRecognizers || ![self.gestureRecognizers count]) {
        [self.rasterizableView touchesCancelled:touches withEvent:event];
    }
}

#pragma mark - Descendant rasterization

- (void)registerDescendantRasterView:(HTRasterView *)descendant
{
    [self.descendantRasterViews addObject:descendant];
    [self.descendantRasterViews sortUsingComparator:^NSComparisonResult(HTRasterView *obj1, HTRasterView *obj2) {
        return [NSStringFromClass([obj1.rasterizableView class]) compare:NSStringFromClass([obj2.rasterizableView class])];
    }];
    [self regenerateImage:nil];
}

- (void)unregisterDescendantRasterView:(HTRasterView *)descendant
{
    [self.descendantRasterViews removeObject:descendant];
}

- (NSString *)description
{
    return [[super description] stringByAppendingFormat:@", rasterizableView: %@, image: %@", NSStringFromClass([self.rasterizableView class]), self.imageView.image];
}

@end
