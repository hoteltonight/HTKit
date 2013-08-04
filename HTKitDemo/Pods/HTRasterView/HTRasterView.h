//
//  HTRasterView.h
//  HotelTonight
//
//  Created by Jacob Jennings on 11/29/12.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#import "NSObject+HTPropertyHash.h"

@class HTRasterView;

typedef void (^HTSARIVVoidBlock)();

@protocol HTRasterizableView <HTStateTrackable, NSObject>

@optional
- (UIEdgeInsets)capEdgeInsets;

- (BOOL)useMinimumFrameForCaps; // YES means 1pt between caps vertically and horizontally for draw size.  capEdgeInsets must be implemented for this.
- (BOOL)shouldRegenerateRaster;
- (UIBezierPath *)rasterViewShadowPathForBounds:(CGRect)bounds;
- (UIImage *)placeholderImage;

@end

@protocol HTRasterViewDelegate <NSObject>

@optional
- (void)rasterViewWillRegenerateImage:(HTRasterView *)rasterView; // May be called outside main thread
- (void)rasterViewImageLoaded:(HTRasterView *)rasterView;

@end

@interface HTRasterView : UIView

@property (nonatomic, strong) UIView<HTRasterizableView> *rasterizableView;
@property (nonatomic, assign) BOOL drawsOnMainThread;
@property (atomic, weak) id<HTRasterViewDelegate> delegate;
@property (nonatomic, assign) BOOL rasterized; // Default YES, change to NO to add rasterizableView as a subview
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, assign, readonly) BOOL loaded; // When drawsOnMainThread = NO, this will return YES if the current state is rendered

- (NSString *)cacheKey;
- (void)generatePlaceholder;

// For prerendering only
@property (nonatomic, assign) BOOL kvoEnabled;
- (void)regenerateImage:(HTSARIVVoidBlock)complete;

@end
