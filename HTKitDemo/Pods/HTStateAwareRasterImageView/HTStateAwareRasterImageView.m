//
//  HTStateAwareRasterImageView.m
//  HotelTonight
//
//  Created by Jacob Jennings on 11/29/12.
//  Copyright (c) 2012 Hotel Tonight. All rights reserved.
//

#import "HTStateAwareRasterImageView.h"
#import "NSObject+HTPropertyHash.h"
#import "MSCachedAsyncViewDrawing.h"
#import "UIView+HTRaster.h"

// Uncommenting this SLOWS THINGS DOWN A LOT and will save all images to disk
//#define HT_DEBUG_SAVEFILES YES

//#define HT_DEBUG_RASTERLOG YES

@interface HTStateAwareRasterImageView ()

@property (nonatomic, assign) BOOL implementsShouldRasterize;
@property (nonatomic, assign) BOOL implementsUseMinimumSizeForCaps;
@property (nonatomic, assign) BOOL implementsCapEdgeInsets;
@property (nonatomic, strong) NSOperation *drawingOperation;
@property (nonatomic, strong) NSMutableArray *descendantRasterImageViews;

@end

@implementation HTStateAwareRasterImageView

- (id)initWithFrame:(CGRect)frame
{
    self = ([super initWithFrame:frame]);
    if (self)
    {
        _kvoEnabled = YES;
        _drawsOnMainThread = YES;
        _descendantRasterImageViews = [NSMutableArray array];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self regenerateImage:nil];
}

- (void)layoutRasterizableView;
{
    if (!(self.implementsUseMinimumSizeForCaps && [self.rasterizableView useMinimumFrameForCaps]))
    {
        self.rasterizableView.frame = self.bounds;
    }
}

- (void)dealloc
{
    [self removeAllObservers];
    _rasterizableView.htRasterImageView = nil;
    self.delegate = nil;
}

- (void)setRasterizableView:(UIView<HTRasterizableView> *)rasterizableView
{
    [self removeAllObservers];
    _rasterizableView.htRasterImageView = nil;
    _rasterizableView = rasterizableView;
    _rasterizableView.htRasterImageView = self;
    [self layoutRasterizableView];
    
    self.implementsShouldRasterize = [self.rasterizableView respondsToSelector:@selector(shouldRegenerateRasterForKeyPath:change:)];
    self.implementsUseMinimumSizeForCaps = [self.rasterizableView respondsToSelector:@selector(useMinimumFrameForCaps)];
    self.implementsCapEdgeInsets = [self.rasterizableView respondsToSelector:@selector(capEdgeInsets)];
    
    for (NSString *propertyName in [rasterizableView keyPathsThatAffectState])
    {
        [rasterizableView addObserver:self forKeyPath:propertyName options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    [self regenerateImage:nil];
}

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

- (void)regenerateImage:(HTSARIVVoidBlock)complete
{
    CGSize size = self.bounds.size;
    BOOL useMinimumCapSize = self.implementsUseMinimumSizeForCaps && [self.rasterizableView useMinimumFrameForCaps];
    if (CGSizeEqualToSize(size, CGSizeZero) && !useMinimumCapSize)
    {
        return;
    }

    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    if (self.implementsCapEdgeInsets)
    {
        edgeInsets = [self.rasterizableView capEdgeInsets];        
    }
    
    if (useMinimumCapSize)
    {
        size = CGSizeMake(edgeInsets.left + edgeInsets.right + 1, edgeInsets.top + edgeInsets.bottom + 1);
    }
    
    self.rasterizableView.frame = (CGRect){.origin = CGPointZero, .size = size};
    
    __block NSString *cacheKey = [self cacheKey];
    __unsafe_unretained HTStateAwareRasterImageView *bSelf = self;

    MSCachedAsyncViewDrawingDrawBlock drawBlock = ^(CGRect frame, CGContextRef context)
    {
        if ([bSelf.delegate respondsToSelector:@selector(rasterImageViewWillRegenerateImage:)])
        {
            [bSelf.delegate rasterImageViewWillRegenerateImage:bSelf];
        }
        bSelf.rasterizableView.frame = frame;
        [bSelf.rasterizableView drawRect:frame inContext:context];
#ifdef HT_DEBUG_RASTERLOG
        NSLog(@"Key: %@\n", [cacheKey stringByReplacingOccurrencesOfString:@"\n" withString:@" "]);
#endif
    };
    
    MSCachedAsyncViewDrawingCompletionBlock completionBlock = ^(UIImage *drawnImage)
    {
        if (!drawnImage)
        {
            return;
        }
        if (drawnImage != bSelf.image)
        {
            bSelf.image = drawnImage;
            [self informFirstAncestorRasterImageViewThatWeRegenerated];
        }

        if ([bSelf.delegate respondsToSelector:@selector(rasterImageViewImageLoaded:)])
        {
            [bSelf.delegate rasterImageViewImageLoaded:bSelf];
        }
        
#ifdef HT_DEBUG_SAVEFILES
        NSString *fileName = [NSString stringWithFormat:@"/%@-%u.png", NSStringFromClass([bSelf.rasterizableView class]), [cacheKey hash]];
        NSData *imageData = UIImageJPEGRepresentation(drawnImage, 1);
        NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
                               stringByAppendingPathComponent:fileName];
        [imageData writeToFile:imagePath atomically:YES];
#endif
        
        if (complete) complete();
    };
    
    [self.drawingOperation cancel];
    self.drawingOperation = [[MSCachedAsyncViewDrawing sharedInstance] drawViewSynchronous:self.drawsOnMainThread
                                                                              withCacheKey:cacheKey
                                                                                      size:size
                                                                           backgroundColor:[UIColor clearColor]
                                                                             capEdgeInsets:edgeInsets
                                                                                 drawBlock:drawBlock
                                                                           completionBlock:completionBlock];
}

- (void)informFirstAncestorRasterImageViewThatWeRegenerated
{
    [[self firstAncestorRasterizableView].htRasterImageView regenerateImage:nil];
}

- (NSString *)cacheKey
{
    NSMutableString *cacheString = [[self.rasterizableView hashStringForKeyPaths:[self.rasterizableView keyPathsThatAffectState]] mutableCopy];
    for (HTStateAwareRasterImageView *descendantRasterImageView in self.descendantRasterImageViews)
    {
        [cacheString appendString:[descendantRasterImageView cacheKey]];
    }
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

- (void)registerDescendantRasterImageView:(HTStateAwareRasterImageView *)descendant
{
    [self.descendantRasterImageViews addObject:descendant];
    [self.descendantRasterImageViews sortUsingComparator:^NSComparisonResult(HTStateAwareRasterImageView *obj1, HTStateAwareRasterImageView *obj2) {
        return [NSStringFromClass([obj1.rasterizableView class]) compare:NSStringFromClass([obj2.rasterizableView class])];
    }];
    [self regenerateImage:nil];
}

- (void)unregisterDescendantRasterImageView:(HTStateAwareRasterImageView *)descendant
{
    [self.descendantRasterImageViews removeObject:descendant];
}

@end
